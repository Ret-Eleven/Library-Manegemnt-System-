const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { getDb } = require('../config/database');
const { authenticate, JWT_SECRET } = require('../middleware/auth');

const router = express.Router();

router.post('/login', (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) return res.status(400).json({ message: 'Email and password required' });

  const user = getDb().prepare('SELECT * FROM users WHERE email = ? AND is_active = 1').get(email);
  if (!user || !bcrypt.compareSync(password, user.password_hash)) {
    return res.status(401).json({ message: 'Invalid credentials' });
  }

  const token = jwt.sign(
    { id: user.id, email: user.email, name: user.name, role: user.role },
    JWT_SECRET,
    { expiresIn: '24h' }
  );

  res.json({ token, user: { id: user.id, name: user.name, email: user.email, role: user.role } });
});

router.post('/register', (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password) return res.status(400).json({ message: 'All fields required' });
  if (password.length < 6) return res.status(400).json({ message: 'Password must be at least 6 characters' });

  const existing = getDb().prepare('SELECT id FROM users WHERE email = ?').get(email);
  if (existing) return res.status(409).json({ message: 'Email already registered' });

  const hash = bcrypt.hashSync(password, 10);
  const result = getDb()
    .prepare('INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)')
    .run(name, email, hash, 'user');

  res.status(201).json({ message: 'Account created', id: result.lastInsertRowid });
});

router.get('/me', authenticate, (req, res) => {
  const user = getDb()
    .prepare('SELECT id, name, email, role, created_at FROM users WHERE id = ?')
    .get(req.user.id);
  if (!user) return res.status(404).json({ message: 'User not found' });
  res.json(user);
});

module.exports = router;
