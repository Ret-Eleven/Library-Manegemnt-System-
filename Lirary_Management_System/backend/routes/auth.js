const express = require('express');
const bcrypt  = require('bcryptjs');
const jwt     = require('jsonwebtoken');
const { supabase }              = require('../config/database');
const { authenticate, JWT_SECRET } = require('../middleware/auth');

const router = express.Router();

router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return res.status(400).json({ message: 'Email and password required' });

    const { data: users } = await supabase
      .from('users').select('*').eq('email', email).eq('is_active', 1).limit(1);

    const user = users?.[0];
    if (!user || !bcrypt.compareSync(password, user.password_hash))
      return res.status(401).json({ message: 'Invalid credentials' });

    const token = jwt.sign(
      { id: user.id, email: user.email, name: user.name, role: user.role },
      JWT_SECRET, { expiresIn: '24h' }
    );
    res.json({ token, user: { id: user.id, name: user.name, email: user.email, role: user.role } });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.post('/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!name || !email || !password) return res.status(400).json({ message: 'All fields required' });
    if (password.length < 6) return res.status(400).json({ message: 'Password must be at least 6 characters' });

    const { data: existing } = await supabase.from('users').select('id').eq('email', email).maybeSingle();
    if (existing) return res.status(409).json({ message: 'Email already registered' });

    const { data, error } = await supabase
      .from('users')
      .insert({ name, email, password_hash: bcrypt.hashSync(password, 10), role: 'user' })
      .select('id').single();

    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'Account created', id: data.id });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.get('/me', authenticate, async (req, res) => {
  try {
    const { data: user } = await supabase
      .from('users').select('id, name, email, role, created_at').eq('id', req.user.id).single();
    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json(user);
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.put('/profile', authenticate, async (req, res) => {
  try {
    const { name, email } = req.body;
    if (!name || !email) return res.status(400).json({ message: 'Name and email are required' });

    const { data: taken } = await supabase
      .from('users').select('id').eq('email', email).neq('id', req.user.id).maybeSingle();
    if (taken) return res.status(409).json({ message: 'Email is already in use by another account' });

    await supabase.from('users').update({ name, email }).eq('id', req.user.id);
    const { data: updated } = await supabase
      .from('users').select('id, name, email, role, created_at').eq('id', req.user.id).single();
    res.json({ message: 'Profile updated successfully', user: updated });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.put('/password', authenticate, async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;
    if (!currentPassword || !newPassword) return res.status(400).json({ message: 'Both passwords are required' });
    if (newPassword.length < 6) return res.status(400).json({ message: 'New password must be at least 6 characters' });

    const { data: user } = await supabase
      .from('users').select('password_hash').eq('id', req.user.id).single();
    if (!bcrypt.compareSync(currentPassword, user.password_hash))
      return res.status(401).json({ message: 'Current password is incorrect' });

    await supabase.from('users')
      .update({ password_hash: bcrypt.hashSync(newPassword, 10) }).eq('id', req.user.id);
    res.json({ message: 'Password changed successfully' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

module.exports = router;
