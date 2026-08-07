const express = require('express');
const { supabase }       = require('../config/database');
const { authenticate }   = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');
const { parseUserId, reqId, issId, parseLoanId } = require('../config/identity');
const { today, addDays, calcFine, genPickupCode, BOOK_JOIN, bookInfo, memberName, enrichRequest, enrichIssue } = require('../config/loanFormat');

const router = express.Router();
const LOAN_DAYS = 14;

// User: own loans
router.get('/my', authenticate, async (req, res) => {
  try {
    const memberId = req.user.id;
    const [{ data: reqs, error: e1 }, { data: iss, error: e2 }] = await Promise.all([
      supabase.from('book_request').select(`request_id, book_id, member_id, request_date, status, book:book_id(${BOOK_JOIN})`)
        .eq('member_id', memberId).in('status', ['pending', 'rejected']),
      supabase.from('book_issue').select(`issue_id, book_id, member_id, issued_by_id, issue_date, due_date, return_date, status, pickup_code, book:book_id(${BOOK_JOIN}), fine_due(fine_total,paid)`)
        .eq('member_id', memberId),
    ]);
    if (e1) return res.status(500).json({ message: e1.message });
    if (e2) return res.status(500).json({ message: e2.message });
    const loans = [...reqs.map(enrichRequest), ...iss.map(enrichIssue)]
      .sort((a, b) => (b.borrow_date || '').localeCompare(a.borrow_date || ''));
    res.json(loans);
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// User: request book
router.post('/request', authenticate, async (req, res) => {
  try {
    const { book_id } = req.body;
    if (!book_id) return res.status(400).json({ message: 'book_id required' });

    const { data: book } = await supabase.from('book').select('book_id').eq('book_id', book_id).maybeSingle();
    if (!book) return res.status(404).json({ message: 'Book not found' });

    const { data: existingReq } = await supabase.from('book_request').select('request_id')
      .eq('member_id', req.user.id).eq('book_id', book_id).eq('status', 'pending').maybeSingle();
    const { data: existingIss } = await supabase.from('book_issue').select('issue_id')
      .eq('member_id', req.user.id).eq('book_id', book_id).eq('status', 'active').maybeSingle();
    if (existingReq || existingIss) return res.status(400).json({ message: 'You already have an active or pending request for this book' });

    const { data, error } = await supabase.from('book_request')
      .insert({ member_id: req.user.id, book_id, request_date: today(), status: 'pending' }).select('request_id').single();
    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'Borrow request submitted', id: reqId(data.request_id) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: direct-issue (no prior request needed)
router.post('/direct-issue', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { user_id, book_id } = req.body;
    if (!user_id || !book_id) return res.status(400).json({ message: 'user_id and book_id required' });
    const { rawId: memberId } = parseUserId(user_id);

    const { data: member } = await supabase.from('member').select('member_id').eq('member_id', memberId).eq('is_active', 1).maybeSingle();
    if (!member) return res.status(404).json({ message: 'User not found or inactive' });

    const { data: book } = await supabase.from('book').select('book_id,copies_available').eq('book_id', book_id).single();
    if (!book) return res.status(404).json({ message: 'Book not found' });
    if (book.copies_available < 1) return res.status(400).json({ message: 'No copies available' });

    const { data: existingReq } = await supabase.from('book_request').select('request_id')
      .eq('member_id', memberId).eq('book_id', book_id).eq('status', 'pending').maybeSingle();
    const { data: existingIss } = await supabase.from('book_issue').select('issue_id')
      .eq('member_id', memberId).eq('book_id', book_id).eq('status', 'active').maybeSingle();
    if (existingReq || existingIss) return res.status(400).json({ message: 'User already has an active or pending loan for this book' });

    const borrowDate = today(), dueDate = addDays(borrowDate, LOAN_DAYS);
    const pickupCode = genPickupCode();

    const { data: issue, error } = await supabase.from('book_issue')
      .insert({ book_id, member_id: memberId, issued_by_id: req.user.id, issue_date: borrowDate,
                due_date: dueDate, status: 'active', pickup_code: pickupCode })
      .select('issue_id').single();
    if (error) return res.status(500).json({ message: error.message });

    await supabase.from('book').update({ copies_available: book.copies_available - 1 }).eq('book_id', book_id);
    res.status(201).json({ message: 'Book issued successfully', id: issId(issue.issue_id), due_date: dueDate, pickup_code: pickupCode });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// User: cancel own pending request
router.post('/:id/cancel', authenticate, async (req, res) => {
  try {
    const { table, rawId } = parseLoanId(req.params.id);
    if (table !== 'book_request') return res.status(400).json({ message: 'Only pending requests can be cancelled' });
    const { data: loan } = await supabase.from('book_request').select('*').eq('request_id', rawId).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.member_id !== req.user.id) return res.status(403).json({ message: 'Not your request' });
    if (loan.status !== 'pending') return res.status(400).json({ message: 'Only pending requests can be cancelled' });
    await supabase.from('book_request').update({ status: 'rejected' }).eq('request_id', rawId);
    res.json({ message: 'Request cancelled' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: list all loans
router.get('/', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { status, user_id, page = 1, limit = 20 } = req.query;
    const offset = (Number(page) - 1) * Number(limit);

    const wantsRequests = !status || ['pending', 'rejected'].includes(status);
    const wantsIssues   = !status || ['active', 'returned'].includes(status);

    let memberFilter = null;
    if (user_id) { try { memberFilter = parseUserId(user_id).rawId; } catch { memberFilter = Number(user_id); } }

    const reqSelect = `request_id, book_id, member_id, request_date, status, book:book_id(${BOOK_JOIN}), member:member_id(first_name,last_name,email_id)`;
    const issSelect = `issue_id, book_id, member_id, issued_by_id, issue_date, due_date, return_date, status, pickup_code, book:book_id(${BOOK_JOIN}), member:member_id(first_name,last_name,email_id), staff:issued_by_id(staff_name), fine_due(fine_total,paid)`;

    let reqQ = supabase.from('book_request').select(reqSelect).in('status', status ? [status] : ['pending', 'rejected']);
    let issQ = supabase.from('book_issue').select(issSelect).in('status', status ? [status] : ['active', 'returned']);
    if (memberFilter) { reqQ = reqQ.eq('member_id', memberFilter); issQ = issQ.eq('member_id', memberFilter); }

    const [{ data: reqs, error: e1 }, { data: iss, error: e2 }] = await Promise.all([
      wantsRequests ? reqQ : Promise.resolve({ data: [] }),
      wantsIssues   ? issQ : Promise.resolve({ data: [] }),
    ]);
    if (e1) return res.status(500).json({ message: e1.message });
    if (e2) return res.status(500).json({ message: e2.message });

    const all = [...(reqs || []).map(enrichRequest), ...(iss || []).map(enrichIssue)]
      .sort((a, b) => (b.borrow_date || '').localeCompare(a.borrow_date || ''));
    const total = all.length;
    const loans = all.slice(offset, offset + Number(limit));

    res.json({ loans, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: issue
router.post('/:id/issue', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { table, rawId } = parseLoanId(req.params.id);
    if (table !== 'book_request') return res.status(400).json({ message: 'Loan is not pending' });
    const { data: loan } = await supabase.from('book_request').select('*').eq('request_id', rawId).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.status !== 'pending') return res.status(400).json({ message: 'Loan is not pending' });

    const { data: book } = await supabase.from('book').select('copies_available').eq('book_id', loan.book_id).single();
    if (book.copies_available < 1) return res.status(400).json({ message: 'No copies available' });

    const borrowDate = today(), dueDate = addDays(borrowDate, LOAN_DAYS);
    const pickupCode = genPickupCode();
    const { error: txErr } = await supabase.from('book_issue').insert({
      book_id: loan.book_id, member_id: loan.member_id, issued_by_id: req.user.id,
      issue_date: borrowDate, due_date: dueDate, status: 'active', pickup_code: pickupCode,
    });
    if (txErr) return res.status(500).json({ message: txErr.message });

    await supabase.from('book_request').update({ status: 'approved' }).eq('request_id', rawId);
    await supabase.from('book').update({ copies_available: book.copies_available - 1 }).eq('book_id', loan.book_id);
    res.json({ message: 'Book issued successfully', due_date: dueDate, pickup_code: pickupCode });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: return
router.post('/:id/return', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { table, rawId } = parseLoanId(req.params.id);
    if (table !== 'book_issue') return res.status(400).json({ message: 'Loan is not active' });
    const { data: loan } = await supabase.from('book_issue').select('*').eq('issue_id', rawId).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.status !== 'active') return res.status(400).json({ message: 'Loan is not active' });

    const returnDate = today(), fine = calcFine(loan.due_date, returnDate);
    await supabase.from('book_issue').update({ status: 'returned', return_date: returnDate }).eq('issue_id', rawId);
    if (fine > 0) await supabase.from('fine_due').insert({ member_id: loan.member_id, issue_id: rawId, fine_date: returnDate, fine_total: fine, paid: 0 });

    const { data: book } = await supabase.from('book').select('copies_available').eq('book_id', loan.book_id).single();
    await supabase.from('book').update({ copies_available: book.copies_available + 1 }).eq('book_id', loan.book_id);
    res.json({ message: 'Book returned', fine_amount: fine });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: reject
router.post('/:id/reject', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { table, rawId } = parseLoanId(req.params.id);
    if (table !== 'book_request') return res.status(400).json({ message: 'Loan is not pending' });
    const { data: loan } = await supabase.from('book_request').select('status').eq('request_id', rawId).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.status !== 'pending') return res.status(400).json({ message: 'Loan is not pending' });
    await supabase.from('book_request').update({ status: 'rejected' }).eq('request_id', rawId);
    res.json({ message: 'Request rejected' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: pay fine
router.post('/:id/pay-fine', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { table, rawId } = parseLoanId(req.params.id);
    if (table !== 'book_issue') return res.status(400).json({ message: 'Loan not found' });
    await supabase.from('fine_due').update({ paid: 1 }).eq('issue_id', rawId);
    res.json({ message: 'Fine marked as paid' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Superadmin: stats
router.get('/stats/overview', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const t = today();
    const [
      { count: totalBooks }, { data: booksData },
      { count: totalUsers }, { count: activeLoans },
      { count: pendingRequests }, { count: overdueLoans },
      { data: finesPaid }, { data: finesPending },
      { data: allIssues }, { data: recentReq }, { data: recentIss }, { data: issueDates },
    ] = await Promise.all([
      supabase.from('book').select('*', { count: 'exact', head: true }),
      supabase.from('book').select('copies_total'),
      supabase.from('member').select('*', { count: 'exact', head: true }).eq('is_active', 1),
      supabase.from('book_issue').select('*', { count: 'exact', head: true }).eq('status', 'active'),
      supabase.from('book_request').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
      supabase.from('book_issue').select('*', { count: 'exact', head: true }).eq('status', 'active').lt('due_date', t),
      supabase.from('fine_due').select('fine_total').eq('paid', 1),
      supabase.from('fine_due').select('fine_total').eq('paid', 0),
      supabase.from('book_issue').select(`book_id, book:book_id(${BOOK_JOIN})`),
      supabase.from('book_request').select('request_id,status,request_date,book:book_id(book_title),member:member_id(first_name,last_name)').order('request_id', { ascending: false }).limit(10),
      supabase.from('book_issue').select('issue_id,status,issue_date,return_date,book:book_id(book_title),member:member_id(first_name,last_name)').order('issue_id', { ascending: false }).limit(10),
      supabase.from('book_issue').select('issue_date'),
    ]);

    const totalCopies         = (booksData || []).reduce((s, b) => s + (b.copies_total || 0), 0);
    const totalFinesCollected = (finesPaid || []).reduce((s, x) => s + (x.fine_total || 0), 0);
    const totalFinesPending   = (finesPending || []).reduce((s, x) => s + (x.fine_total || 0), 0);

    const cnt = {}, info = {};
    for (const x of (allIssues || [])) {
      cnt[x.book_id] = (cnt[x.book_id] || 0) + 1;
      if (x.book) info[x.book_id] = bookInfo(x.book);
    }
    const mostBorrowed = Object.entries(cnt).sort((a, b) => b[1] - a[1]).slice(0, 5)
      .map(([id, c]) => ({ title: info[id]?.title || '', author: info[id]?.author || '', borrow_count: c }));

    const recentActivity = [
      ...(recentReq || []).map(x => ({ id: reqId(x.request_id), status: x.status, borrow_date: x.request_date, return_date: null,
        title: x.book?.book_title, user_name: memberName(x.member) })),
      ...(recentIss || []).map(x => ({ id: issId(x.issue_id), status: x.status, borrow_date: x.issue_date, return_date: x.return_date,
        title: x.book?.book_title, user_name: memberName(x.member) })),
    ].sort((a, b) => (b.borrow_date || '').localeCompare(a.borrow_date || '')).slice(0, 10);

    const mc = {};
    for (const x of (issueDates || [])) { const m = x.issue_date?.slice(0, 7); if (m) mc[m] = (mc[m] || 0) + 1; }
    const loansByMonth = Object.entries(mc).sort((a, b) => b[0].localeCompare(a[0])).slice(0, 6)
      .map(([month, count]) => ({ month, count }));

    res.json({ totalBooks, totalCopies, totalUsers, activeLoans, pendingRequests, overdueLoans,
      totalFinesCollected: +totalFinesCollected.toFixed(2), totalFinesPending: +totalFinesPending.toFixed(2),
      mostBorrowed, recentActivity, loansByMonth });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

module.exports = router;
