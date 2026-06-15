const express = require('express');
const { supabase }       = require('../config/database');
const { authenticate }   = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');

const router = express.Router();
const FINE_PER_DAY = 0.50;
const LOAN_DAYS    = 14;

const today    = () => new Date().toISOString().split('T')[0];
const addDays  = (d, n) => { const x = new Date(d); x.setDate(x.getDate()+n); return x.toISOString().split('T')[0]; };
const calcFine = (due, ret) => { const d = Math.floor((new Date(ret||today()) - new Date(due))/86400000); return d>0 ? +(d*FINE_PER_DAY).toFixed(2) : 0; };

const enrich = t => {
  const overdue = t.status==='active' && t.due_date < today() ? 1 : 0;
  return { ...t, title: t.books?.title, author: t.books?.author, isbn: t.books?.isbn,
           books: undefined, is_overdue: overdue,
           current_fine: overdue ? calcFine(t.due_date, today()) : (t.fine_amount||0) };
};

// User: own loans
router.get('/my', authenticate, async (req, res) => {
  try {
    const { data, error } = await supabase.from('transactions')
      .select('*, books(title, author, isbn)').eq('user_id', req.user.id).order('id', { ascending: false });
    if (error) return res.status(500).json({ message: error.message });
    res.json(data.map(enrich));
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// User: request book
router.post('/request', authenticate, async (req, res) => {
  try {
    const { book_id } = req.body;
    if (!book_id) return res.status(400).json({ message: 'book_id required' });

    const { data: book } = await supabase.from('books').select('id').eq('id', book_id).maybeSingle();
    if (!book) return res.status(404).json({ message: 'Book not found' });

    const { data: existing } = await supabase.from('transactions').select('id')
      .eq('user_id', req.user.id).eq('book_id', book_id).in('status', ['pending','active']).maybeSingle();
    if (existing) return res.status(400).json({ message: 'You already have an active or pending request for this book' });

    const { data, error } = await supabase.from('transactions')
      .insert({ user_id: req.user.id, book_id, status: 'pending' }).select('id').single();
    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'Borrow request submitted', id: data.id });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// User: cancel own pending request
router.post('/:id/cancel', authenticate, async (req, res) => {
  try {
    const { data: loan } = await supabase.from('transactions').select('*').eq('id', req.params.id).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.user_id !== req.user.id) return res.status(403).json({ message: 'Not your request' });
    if (loan.status !== 'pending') return res.status(400).json({ message: 'Only pending requests can be cancelled' });
    await supabase.from('transactions').update({ status: 'rejected' }).eq('id', req.params.id);
    res.json({ message: 'Request cancelled' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: list all loans
router.get('/', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { status, user_id, page=1, limit=20 } = req.query;
    const offset = (Number(page)-1)*Number(limit);

    let q = supabase.from('transactions').select(`
      *, books(title,author,isbn),
      user_data:users!user_id(name,email),
      admin_data:users!issued_by(name)
    `, { count: 'exact' });
    if (status)  q = q.eq('status', status);
    if (user_id) q = q.eq('user_id', user_id);

    const { data: raw, count: total, error } = await q
      .order('id', { ascending: false }).range(offset, offset+Number(limit)-1);
    if (error) return res.status(500).json({ message: error.message });

    const t = today();
    const loans = raw.map(x => {
      const ov = x.status==='active' && x.due_date < t ? 1 : 0;
      return { ...x,
        title: x.books?.title, author: x.books?.author, isbn: x.books?.isbn,
        user_name: x.user_data?.name, user_email: x.user_data?.email,
        issued_by_name: x.admin_data?.name,
        books: undefined, user_data: undefined, admin_data: undefined,
        is_overdue: ov, current_fine: ov ? calcFine(x.due_date,t) : (x.fine_amount||0) };
    });
    res.json({ loans, total, page: Number(page), pages: Math.ceil(total/Number(limit)) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: issue
router.post('/:id/issue', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: loan } = await supabase.from('transactions').select('*').eq('id', req.params.id).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.status !== 'pending') return res.status(400).json({ message: 'Loan is not pending' });

    const { data: book } = await supabase.from('books').select('available_copies').eq('id', loan.book_id).single();
    if (book.available_copies < 1) return res.status(400).json({ message: 'No copies available' });

    const borrowDate = today(), dueDate = addDays(borrowDate, LOAN_DAYS);
    await supabase.from('transactions').update({ status:'active', issued_by: req.user.id, borrow_date: borrowDate, due_date: dueDate }).eq('id', loan.id);
    await supabase.from('books').update({ available_copies: book.available_copies-1 }).eq('id', loan.book_id);
    res.json({ message: 'Book issued successfully', due_date: dueDate });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: return
router.post('/:id/return', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: loan } = await supabase.from('transactions').select('*').eq('id', req.params.id).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.status !== 'active') return res.status(400).json({ message: 'Loan is not active' });

    const returnDate = today(), fine = calcFine(loan.due_date, returnDate);
    await supabase.from('transactions').update({ status:'returned', return_date: returnDate, fine_amount: fine }).eq('id', loan.id);
    const { data: book } = await supabase.from('books').select('available_copies').eq('id', loan.book_id).single();
    await supabase.from('books').update({ available_copies: book.available_copies+1 }).eq('id', loan.book_id);
    res.json({ message: 'Book returned', fine_amount: fine });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: reject
router.post('/:id/reject', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: loan } = await supabase.from('transactions').select('status').eq('id', req.params.id).single();
    if (!loan) return res.status(404).json({ message: 'Loan not found' });
    if (loan.status !== 'pending') return res.status(400).json({ message: 'Loan is not pending' });
    await supabase.from('transactions').update({ status:'rejected' }).eq('id', req.params.id);
    res.json({ message: 'Request rejected' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: pay fine
router.post('/:id/pay-fine', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    await supabase.from('transactions').update({ fine_paid: 1 }).eq('id', req.params.id);
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
      { data: allTx }, { data: recentRaw }, { data: loanDates },
    ] = await Promise.all([
      supabase.from('books').select('*', { count:'exact', head:true }),
      supabase.from('books').select('total_copies'),
      supabase.from('users').select('*', { count:'exact', head:true }).eq('role','user').eq('is_active',1),
      supabase.from('transactions').select('*', { count:'exact', head:true }).eq('status','active'),
      supabase.from('transactions').select('*', { count:'exact', head:true }).eq('status','pending'),
      supabase.from('transactions').select('*', { count:'exact', head:true }).eq('status','active').lt('due_date',t),
      supabase.from('transactions').select('fine_amount').eq('fine_paid',1),
      supabase.from('transactions').select('fine_amount').eq('fine_paid',0).gt('fine_amount',0),
      supabase.from('transactions').select('book_id, books(title,author)').neq('status','pending'),
      supabase.from('transactions').select('id,status,borrow_date,return_date,books(title),user_data:users!user_id(name)').order('id',{ascending:false}).limit(10),
      supabase.from('transactions').select('borrow_date').not('borrow_date','is',null),
    ]);

    const totalCopies          = (booksData||[]).reduce((s,b)=>s+(b.total_copies||0),0);
    const totalFinesCollected  = (finesPaid||[]).reduce((s,x)=>s+(x.fine_amount||0),0);
    const totalFinesPending    = (finesPending||[]).reduce((s,x)=>s+(x.fine_amount||0),0);

    const cnt={}, info={};
    for (const x of (allTx||[])) { cnt[x.book_id]=(cnt[x.book_id]||0)+1; if(x.books) info[x.book_id]=x.books; }
    const mostBorrowed = Object.entries(cnt).sort((a,b)=>b[1]-a[1]).slice(0,5)
      .map(([id,c])=>({ title:info[id]?.title||'', author:info[id]?.author||'', borrow_count:c }));

    const recentActivity = (recentRaw||[]).map(x=>({
      id:x.id, status:x.status, borrow_date:x.borrow_date, return_date:x.return_date,
      title:x.books?.title, user_name:x.user_data?.name,
    }));

    const mc={};
    for (const x of (loanDates||[])) { const m=x.borrow_date?.slice(0,7); if(m) mc[m]=(mc[m]||0)+1; }
    const loansByMonth = Object.entries(mc).sort((a,b)=>b[0].localeCompare(a[0])).slice(0,6)
      .map(([month,count])=>({ month, count }));

    res.json({ totalBooks, totalCopies, totalUsers, activeLoans, pendingRequests, overdueLoans,
      totalFinesCollected:+totalFinesCollected.toFixed(2), totalFinesPending:+totalFinesPending.toFixed(2),
      mostBorrowed, recentActivity, loansByMonth });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

module.exports = router;
