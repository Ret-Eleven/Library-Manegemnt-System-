const express = require('express');
const { getDb } = require('../config/database');
const { authenticate } = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');

const router = express.Router();

const FINE_PER_DAY = 0.50;
const LOAN_DAYS = 14;

function today() {
  return new Date().toISOString().split('T')[0];
}

function addDays(dateStr, days) {
  const d = new Date(dateStr);
  d.setDate(d.getDate() + days);
  return d.toISOString().split('T')[0];
}

function calcFine(dueDate, returnDate) {
  const due = new Date(dueDate);
  const ret = new Date(returnDate || today());
  const days = Math.floor((ret - due) / 86400000);
  return days > 0 ? +(days * FINE_PER_DAY).toFixed(2) : 0;
}

// User: view own loans
router.get('/my', authenticate, (req, res) => {
  const t = today();
  const loans = getDb().prepare(`
    SELECT t.*, b.title, b.author, b.isbn,
      CASE WHEN t.status = 'active' AND t.due_date < ? THEN 1 ELSE 0 END AS is_overdue,
      CASE
        WHEN t.status = 'active' AND t.due_date < ?
        THEN ROUND((julianday(?) - julianday(t.due_date)) * ?, 2)
        ELSE t.fine_amount
      END AS current_fine
    FROM transactions t
    JOIN books b ON t.book_id = b.id
    WHERE t.user_id = ?
    ORDER BY t.id DESC
  `).all(t, t, t, FINE_PER_DAY, req.user.id);
  res.json(loans);
});

// User: request a book
router.post('/request', authenticate, (req, res) => {
  const { book_id } = req.body;
  if (!book_id) return res.status(400).json({ message: 'book_id required' });

  const book = getDb().prepare('SELECT * FROM books WHERE id = ?').get(book_id);
  if (!book) return res.status(404).json({ message: 'Book not found' });

  const existing = getDb()
    .prepare("SELECT id FROM transactions WHERE user_id = ? AND book_id = ? AND status IN ('pending', 'active')")
    .get(req.user.id, book_id);
  if (existing) return res.status(400).json({ message: 'You already have an active or pending request for this book' });

  const result = getDb()
    .prepare("INSERT INTO transactions (user_id, book_id, status) VALUES (?, ?, 'pending')")
    .run(req.user.id, book_id);

  res.status(201).json({ message: 'Borrow request submitted', id: result.lastInsertRowid });
});

// Admin+: list all loans with filters
router.get('/', authenticate, requireMinRole('admin'), (req, res) => {
  const { status, user_id, page = 1, limit = 20 } = req.query;
  const offset = (Number(page) - 1) * Number(limit);
  const t = today();

  const conditions = [];
  const params = [];
  if (status) { conditions.push('t.status = ?'); params.push(status); }
  if (user_id) { conditions.push('t.user_id = ?'); params.push(user_id); }
  const where = conditions.length ? 'WHERE ' + conditions.join(' AND ') : '';

  const { count: total } = getDb()
    .prepare(`SELECT COUNT(*) as count FROM transactions t ${where}`)
    .get(...params);

  const loans = getDb().prepare(`
    SELECT t.*, b.title, b.author, b.isbn,
      u.name AS user_name, u.email AS user_email,
      a.name AS issued_by_name,
      CASE WHEN t.status = 'active' AND t.due_date < ? THEN 1 ELSE 0 END AS is_overdue,
      CASE
        WHEN t.status = 'active' AND t.due_date < ?
        THEN ROUND((julianday(?) - julianday(t.due_date)) * ?, 2)
        ELSE t.fine_amount
      END AS current_fine
    FROM transactions t
    JOIN books b ON t.book_id = b.id
    JOIN users u ON t.user_id = u.id
    LEFT JOIN users a ON t.issued_by = a.id
    ${where}
    ORDER BY t.id DESC LIMIT ? OFFSET ?
  `).all(t, t, t, FINE_PER_DAY, ...params, Number(limit), offset);

  res.json({ loans, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
});

// Admin+: issue a pending loan
router.post('/:id/issue', authenticate, requireMinRole('admin'), (req, res) => {
  const db = getDb();
  const loan = db.prepare('SELECT * FROM transactions WHERE id = ?').get(req.params.id);
  if (!loan) return res.status(404).json({ message: 'Loan not found' });
  if (loan.status !== 'pending') return res.status(400).json({ message: 'Loan is not pending' });

  const book = db.prepare('SELECT * FROM books WHERE id = ?').get(loan.book_id);
  if (book.available_copies < 1) return res.status(400).json({ message: 'No copies available' });

  const borrowDate = today();
  const dueDate = addDays(borrowDate, LOAN_DAYS);

  db.prepare("UPDATE transactions SET status='active', issued_by=?, borrow_date=?, due_date=? WHERE id=?")
    .run(req.user.id, borrowDate, dueDate, loan.id);
  db.prepare('UPDATE books SET available_copies = available_copies - 1 WHERE id = ?').run(loan.book_id);

  res.json({ message: 'Book issued successfully', due_date: dueDate });
});

// Admin+: return an active loan
router.post('/:id/return', authenticate, requireMinRole('admin'), (req, res) => {
  const db = getDb();
  const loan = db.prepare('SELECT * FROM transactions WHERE id = ?').get(req.params.id);
  if (!loan) return res.status(404).json({ message: 'Loan not found' });
  if (loan.status !== 'active') return res.status(400).json({ message: 'Loan is not active' });

  const returnDate = today();
  const fine = calcFine(loan.due_date, returnDate);

  db.prepare("UPDATE transactions SET status='returned', return_date=?, fine_amount=? WHERE id=?")
    .run(returnDate, fine, loan.id);
  db.prepare('UPDATE books SET available_copies = available_copies + 1 WHERE id = ?').run(loan.book_id);

  res.json({ message: 'Book returned', fine_amount: fine });
});

// Admin+: reject a pending request
router.post('/:id/reject', authenticate, requireMinRole('admin'), (req, res) => {
  const loan = getDb().prepare('SELECT * FROM transactions WHERE id = ?').get(req.params.id);
  if (!loan) return res.status(404).json({ message: 'Loan not found' });
  if (loan.status !== 'pending') return res.status(400).json({ message: 'Loan is not pending' });

  getDb().prepare("UPDATE transactions SET status='rejected' WHERE id=?").run(req.params.id);
  res.json({ message: 'Request rejected' });
});

// Admin+: mark fine as paid
router.post('/:id/pay-fine', authenticate, requireMinRole('admin'), (req, res) => {
  getDb().prepare('UPDATE transactions SET fine_paid=1 WHERE id=?').run(req.params.id);
  res.json({ message: 'Fine marked as paid' });
});

// Superadmin: library-wide statistics
router.get('/stats/overview', authenticate, requireMinRole('superadmin'), (req, res) => {
  const db = getDb();
  const t = today();

  res.json({
    totalBooks:         db.prepare('SELECT COUNT(*) as c FROM books').get().c,
    totalCopies:        db.prepare('SELECT SUM(total_copies) as c FROM books').get().c || 0,
    totalUsers:         db.prepare("SELECT COUNT(*) as c FROM users WHERE role = 'user' AND is_active = 1").get().c,
    activeLoans:        db.prepare("SELECT COUNT(*) as c FROM transactions WHERE status = 'active'").get().c,
    pendingRequests:    db.prepare("SELECT COUNT(*) as c FROM transactions WHERE status = 'pending'").get().c,
    overdueLoans:       db.prepare("SELECT COUNT(*) as c FROM transactions WHERE status = 'active' AND due_date < ?").get(t).c,
    totalFinesCollected:db.prepare('SELECT COALESCE(SUM(fine_amount),0) as s FROM transactions WHERE fine_paid = 1').get().s,
    totalFinesPending:  db.prepare('SELECT COALESCE(SUM(fine_amount),0) as s FROM transactions WHERE fine_paid = 0 AND fine_amount > 0').get().s,
    mostBorrowed: db.prepare(`
      SELECT b.title, b.author, COUNT(*) AS borrow_count
      FROM transactions t JOIN books b ON t.book_id = b.id
      WHERE t.status != 'pending'
      GROUP BY b.id ORDER BY borrow_count DESC LIMIT 5
    `).all(),
    recentActivity: db.prepare(`
      SELECT t.id, t.status, t.borrow_date, t.return_date, b.title, u.name AS user_name
      FROM transactions t
      JOIN books b ON t.book_id = b.id
      JOIN users u ON t.user_id = u.id
      ORDER BY t.id DESC LIMIT 10
    `).all(),
    loansByMonth: db.prepare(`
      SELECT strftime('%Y-%m', borrow_date) AS month, COUNT(*) AS count
      FROM transactions WHERE borrow_date IS NOT NULL
      GROUP BY month ORDER BY month DESC LIMIT 6
    `).all(),
  });
});

module.exports = router;
