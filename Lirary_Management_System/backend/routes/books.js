const express = require('express');
const { getDb } = require('../config/database');
const { authenticate } = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');

const router = express.Router();

router.get('/', authenticate, (req, res) => {
  const { search, category, page = 1, limit = 20 } = req.query;
  const offset = (Number(page) - 1) * Number(limit);

  let baseWhere = 'WHERE 1=1';
  const params = [];

  if (search) {
    baseWhere += ' AND (b.title LIKE ? OR b.author LIKE ? OR b.isbn LIKE ?)';
    const t = `%${search}%`;
    params.push(t, t, t);
  }
  if (category) {
    baseWhere += ' AND b.category = ?';
    params.push(category);
  }

  const { count: total } = getDb()
    .prepare(`SELECT COUNT(*) as count FROM books b ${baseWhere}`)
    .get(...params);

  const books = getDb()
    .prepare(`SELECT b.* FROM books b ${baseWhere} ORDER BY b.title ASC LIMIT ? OFFSET ?`)
    .all(...params, Number(limit), offset);

  res.json({ books, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
});

router.get('/categories', authenticate, (req, res) => {
  const rows = getDb()
    .prepare('SELECT DISTINCT category FROM books WHERE category IS NOT NULL ORDER BY category')
    .all();
  res.json(rows.map(r => r.category));
});

router.get('/:id', authenticate, (req, res) => {
  const book = getDb().prepare('SELECT * FROM books WHERE id = ?').get(req.params.id);
  if (!book) return res.status(404).json({ message: 'Book not found' });
  res.json(book);
});

router.post('/', authenticate, requireMinRole('admin'), (req, res) => {
  const { title, author, isbn, category, total_copies = 1, published_year, description } = req.body;
  if (!title || !author) return res.status(400).json({ message: 'Title and author required' });

  const copies = Number(total_copies);
  const result = getDb()
    .prepare('INSERT INTO books (title, author, isbn, category, total_copies, available_copies, published_year, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
    .run(title, author, isbn || null, category || null, copies, copies, published_year || null, description || null);

  res.status(201).json({ message: 'Book added', id: result.lastInsertRowid });
});

router.put('/:id', authenticate, requireMinRole('admin'), (req, res) => {
  const book = getDb().prepare('SELECT * FROM books WHERE id = ?').get(req.params.id);
  if (!book) return res.status(404).json({ message: 'Book not found' });

  const { title, author, isbn, category, total_copies, published_year, description } = req.body;
  const newTotal = total_copies != null ? Number(total_copies) : book.total_copies;
  const diff = newTotal - book.total_copies;
  const newAvailable = Math.max(0, book.available_copies + diff);

  getDb()
    .prepare('UPDATE books SET title=?, author=?, isbn=?, category=?, total_copies=?, available_copies=?, published_year=?, description=? WHERE id=?')
    .run(
      title ?? book.title,
      author ?? book.author,
      isbn !== undefined ? isbn : book.isbn,
      category !== undefined ? category : book.category,
      newTotal,
      newAvailable,
      published_year !== undefined ? published_year : book.published_year,
      description !== undefined ? description : book.description,
      req.params.id
    );

  res.json({ message: 'Book updated' });
});

router.delete('/:id', authenticate, requireMinRole('admin'), (req, res) => {
  const { count } = getDb()
    .prepare("SELECT COUNT(*) as count FROM transactions WHERE book_id = ? AND status IN ('active', 'pending')")
    .get(req.params.id);
  if (count > 0) return res.status(400).json({ message: 'Cannot delete a book with active or pending loans' });

  getDb().prepare('DELETE FROM books WHERE id = ?').run(req.params.id);
  res.json({ message: 'Book deleted' });
});

module.exports = router;
