const { memId, staffId, reqId, issId } = require('./identity');

const FINE_PER_DAY = 0.50;
const LOAN_DAYS    = 14;

const today    = () => new Date().toISOString().split('T')[0];
const addDays  = (d, n) => { const x = new Date(d); x.setDate(x.getDate()+n); return x.toISOString().split('T')[0]; };
const calcFine = (due, ret) => { const d = Math.floor((new Date(ret||today()) - new Date(due))/86400000); return d>0 ? +(d*FINE_PER_DAY).toFixed(2) : 0; };
const genPickupCode = () => String(Math.floor(10000000 + Math.random() * 90000000));

const BOOK_JOIN = 'book_title, isbn_code, book_author(author:author_id(first_name,last_name))';

const bookInfo = (book) => ({
  title: book?.book_title,
  author: (book?.book_author || []).map(ba => `${ba.author?.first_name||''} ${ba.author?.last_name||''}`.trim()).filter(Boolean).join(', '),
  isbn: book?.isbn_code,
});

const memberName = (m) => m ? `${m.first_name} ${m.last_name}`.trim() : undefined;

const enrichRequest = (r) => {
  const b = bookInfo(r.book);
  return {
    id: reqId(r.request_id), user_id: memId(r.member_id), book_id: r.book_id,
    borrow_date: r.request_date, due_date: null, return_date: null,
    status: r.status, fine_amount: 0, fine_paid: 1, pickup_code: null,
    title: b.title, author: b.author, isbn: b.isbn,
    is_overdue: 0, current_fine: 0,
    user_name: memberName(r.member), user_email: r.member?.email_id,
  };
};

const enrichIssue = (i) => {
  const b = bookInfo(i.book);
  const fine = (i.fine_due || [])[0];
  const overdue = i.status === 'active' && i.due_date && i.due_date < today() ? 1 : 0;
  return {
    id: issId(i.issue_id), user_id: memId(i.member_id), book_id: i.book_id,
    issued_by: i.issued_by_id != null ? staffId(i.issued_by_id) : null,
    borrow_date: i.issue_date, due_date: i.due_date, return_date: i.return_date,
    status: i.status, fine_amount: fine?.fine_total || 0, fine_paid: fine ? fine.paid : 1,
    pickup_code: i.pickup_code,
    title: b.title, author: b.author, isbn: b.isbn,
    is_overdue: overdue, current_fine: overdue ? calcFine(i.due_date, today()) : (fine?.fine_total || 0),
    user_name: memberName(i.member), user_email: i.member?.email_id,
    issued_by_name: i.staff?.staff_name,
  };
};

module.exports = { FINE_PER_DAY, LOAN_DAYS, today, addDays, calcFine, genPickupCode, BOOK_JOIN, bookInfo, memberName, enrichRequest, enrichIssue };
