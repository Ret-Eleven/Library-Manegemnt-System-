const express = require('express');
const bcrypt = require('bcrypt');
const { getDb } = require('../config/database');
const { authenticate } = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');

const router = express.Router();

// Superadmin: list all users
router.get('/', authenticate, requireMinRole('superadmin'), (req, res) => {
  const { role, search, page = 1, limit = 20 } = req.query;
  const offset = (Number(page) - 1) * Number(limit);

  const conditions = [];
  const params = [];
  if (role) { conditions.push('role = ?'); params.push(role); }
  if (search) {
    conditions.push('(name LIKE ? OR email LIKE ?)');
    params.push(`%${search}%`, `%${search}%`);
  }
  const where = conditions.length ? 'WHERE ' + conditions.join(' AND ') : '';

  const { count: total } = getDb().prepare(`SELECT COUNT(*) as count FROM users ${where}`).get(...params);
  const users = getDb()
    .prepare(`SELECT id, name, email, role, is_active, created_at FROM users ${where} ORDER BY created_at DESC LIMIT ? OFFSET ?`)
    .all(...params, Number(limit), offset);

  res.json({ users, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
});

// Superadmin: create admin or user
router.post('/', authenticate, requireMinRole('superadmin'), (req, res) => {
  const { name, email, password, role = 'user' } = req.body;
  if (!name || !email || !password) return res.status(400).json({ message: 'All fields required' });
  if (!['user', 'admin'].includes(role)) return res.status(400).json({ message: 'Invalid role. Allowed: user, admin' });

  const existing = getDb().prepare('SELECT id FROM users WHERE email = ?').get(email);
  if (existing) return res.status(409).json({ message: 'Email already registered' });

  const hash = bcrypt.hashSync(password, 10);
  const result = getDb()
    .prepare('INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)')
    .run(name, email, hash, role);

  res.status(201).json({ message: 'User created', id: result.lastInsertRowid });
});

// Superadmin: update user role / status / name
router.put('/:id', authenticate, requireMinRole('superadmin'), (req, res) => {
  const user = getDb().prepare('SELECT * FROM users WHERE id = ?').get(req.params.id);
  if (!user) return res.status(404).json({ message: 'User not found' });
  if (user.role === 'superadmin' && Number(req.params.id) !== req.user.id) {
    return res.status(403).json({ message: 'Cannot modify another superadmin' });
  }

  const { role, is_active, name } = req.body;
  const validRoles = ['user', 'admin', 'superadmin'];
  if (role && !validRoles.includes(role)) return res.status(400).json({ message: 'Invalid role' });

  getDb()
    .prepare('UPDATE users SET name=?, role=?, is_active=? WHERE id=?')
    .run(
      name ?? user.name,
      role ?? user.role,
      is_active !== undefined ? (is_active ? 1 : 0) : user.is_active,
      req.params.id
    );

  res.json({ message: 'User updated' });
});

// Superadmin: deactivate user (soft delete)
router.delete('/:id', authenticate, requireMinRole('superadmin'), (req, res) => {
  const user = getDb().prepare('SELECT * FROM users WHERE id = ?').get(req.params.id);
  if (!user) return res.status(404).json({ message: 'User not found' });
  if (user.role === 'superadmin') return res.status(403).json({ message: 'Cannot delete a superadmin account' });

  // Reject any pending requests for this user
  getDb()
    .prepare("UPDATE transactions SET status='rejected' WHERE user_id = ? AND status = 'pending'")
    .run(req.params.id);
  getDb().prepare('UPDATE users SET is_active=0 WHERE id=?').run(req.params.id);

  res.json({ message: 'User deactivated' });
});

// Admin+: view loans for a specific user
router.get('/:id/loans', authenticate, requireMinRole('admin'), (req, res) => {
  const loans = getDb().prepare(`
    SELECT t.*, b.title, b.author, b.isbn
    FROM transactions t
    JOIN books b ON t.book_id = b.id
    WHERE t.user_id = ?
    ORDER BY t.id DESC
  `).all(req.params.id);
  res.json(loans);
});

module.exports = router;
