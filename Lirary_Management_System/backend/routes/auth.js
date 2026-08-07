const express = require('express');
<<<<<<< HEAD
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { supabase } = require('../config/database');
=======
const bcrypt  = require('bcryptjs');
const jwt     = require('jsonwebtoken');
const { supabase }              = require('../config/database');
>>>>>>> testing
const { authenticate, JWT_SECRET } = require('../middleware/auth');
const { splitName } = require('../config/lookups');

const router = express.Router();

router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) return res.status(400).json({ message: 'Email and password required' });

<<<<<<< HEAD
    const { data: users } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .eq('is_active', 1)
      .limit(1);

    const user = users?.[0];
    if (!user || !bcrypt.compareSync(password, user.password_hash)) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    const token = jwt.sign(
      { id: user.id, email: user.email, name: user.name, role: user.role },
      JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({ token, user: { id: user.id, name: user.name, email: user.email, role: user.role } });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
=======
    const { data: members } = await supabase
      .from('member').select('*').eq('email_id', email).eq('is_active', 1).limit(1);
    let identity = members?.[0];
    let role = 'user', table = 'member';

    if (!identity) {
      const { data: staff } = await supabase
        .from('library_staff').select('*').eq('email', email).eq('is_active', 1).limit(1);
      identity = staff?.[0];
      if (identity) { role = identity.staff_designation; table = 'library_staff'; }
    }

    if (!identity || !bcrypt.compareSync(password, identity.password_hash || ''))
      return res.status(401).json({ message: 'Invalid credentials' });

    const id   = table === 'member' ? identity.member_id : identity.issued_by_id;
    const name = table === 'member' ? `${identity.first_name} ${identity.last_name}`.trim() : identity.staff_name;

    const token = jwt.sign({ id, email, name, role }, JWT_SECRET, { expiresIn: '24h' });
    res.json({ token, user: { id, name, email, role } });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
>>>>>>> testing
});

router.post('/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!name || !email || !password) return res.status(400).json({ message: 'All fields required' });
    if (password.length < 6) return res.status(400).json({ message: 'Password must be at least 6 characters' });

<<<<<<< HEAD
    const { data: existing } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .maybeSingle();

    if (existing) return res.status(409).json({ message: 'Email already registered' });

    const hash = bcrypt.hashSync(password, 10);
    const { data, error } = await supabase
      .from('users')
      .insert({ name, email, password_hash: hash, role: 'user' })
      .select('id')
      .single();

    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'Account created', id: data.id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
=======
    const { data: existing } = await supabase.from('member').select('member_id').eq('email_id', email).maybeSingle();
    if (existing) return res.status(409).json({ message: 'Email already registered' });

    const { first_name, last_name } = splitName(name);
    const { data, error } = await supabase
      .from('member')
      .insert({ first_name, last_name, email_id: email, password_hash: bcrypt.hashSync(password, 10) })
      .select('member_id').single();

    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'Account created', id: data.member_id });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
>>>>>>> testing
});

router.get('/me', authenticate, async (req, res) => {
  try {
<<<<<<< HEAD
    const { data: user } = await supabase
      .from('users')
      .select('id, name, email, role, created_at')
      .eq('id', req.user.id)
      .single();

    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json(user);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
=======
    if (req.user.role === 'user') {
      const { data: m } = await supabase.from('member')
        .select('member_id, first_name, last_name, email_id, created_at').eq('member_id', req.user.id).single();
      if (!m) return res.status(404).json({ message: 'User not found' });
      return res.json({ id: m.member_id, name: `${m.first_name} ${m.last_name}`.trim(), email: m.email_id, role: 'user', created_at: m.created_at });
    }
    const { data: s } = await supabase.from('library_staff')
      .select('issued_by_id, staff_name, email, staff_designation, created_at').eq('issued_by_id', req.user.id).single();
    if (!s) return res.status(404).json({ message: 'User not found' });
    res.json({ id: s.issued_by_id, name: s.staff_name, email: s.email, role: s.staff_designation, created_at: s.created_at });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
>>>>>>> testing
});

router.put('/profile', authenticate, async (req, res) => {
  try {
    const { name, email } = req.body;
    if (!name || !email) return res.status(400).json({ message: 'Name and email are required' });

<<<<<<< HEAD
    const { data: taken } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .neq('id', req.user.id)
      .maybeSingle();

    if (taken) return res.status(409).json({ message: 'Email is already in use by another account' });

    await supabase.from('users').update({ name, email }).eq('id', req.user.id);

    const { data: updated } = await supabase
      .from('users')
      .select('id, name, email, role, created_at')
      .eq('id', req.user.id)
      .single();

    res.json({ message: 'Profile updated successfully', user: updated });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
=======
    const isMember = req.user.role === 'user';
    const table   = isMember ? 'member' : 'library_staff';
    const emailCol = isMember ? 'email_id' : 'email';
    const idCol    = isMember ? 'member_id' : 'issued_by_id';

    const { data: taken } = await supabase.from(table).select(idCol).eq(emailCol, email).neq(idCol, req.user.id).maybeSingle();
    if (taken) return res.status(409).json({ message: 'Email is already in use by another account' });

    if (isMember) {
      const { first_name, last_name } = splitName(name);
      await supabase.from('member').update({ first_name, last_name, email_id: email }).eq('member_id', req.user.id);
      const { data: updated } = await supabase.from('member')
        .select('member_id, first_name, last_name, email_id, created_at').eq('member_id', req.user.id).single();
      return res.json({ message: 'Profile updated successfully', user: {
        id: updated.member_id, name: `${updated.first_name} ${updated.last_name}`.trim(),
        email: updated.email_id, role: 'user', created_at: updated.created_at } });
    }

    await supabase.from('library_staff').update({ staff_name: name, email }).eq('issued_by_id', req.user.id);
    const { data: updated } = await supabase.from('library_staff')
      .select('issued_by_id, staff_name, email, staff_designation, created_at').eq('issued_by_id', req.user.id).single();
    res.json({ message: 'Profile updated successfully', user: {
      id: updated.issued_by_id, name: updated.staff_name, email: updated.email,
      role: updated.staff_designation, created_at: updated.created_at } });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
>>>>>>> testing
});

router.put('/password', authenticate, async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;
    if (!currentPassword || !newPassword) return res.status(400).json({ message: 'Both passwords are required' });
    if (newPassword.length < 6) return res.status(400).json({ message: 'New password must be at least 6 characters' });

<<<<<<< HEAD
    const { data: user } = await supabase
      .from('users')
      .select('password_hash')
      .eq('id', req.user.id)
      .single();

    if (!bcrypt.compareSync(currentPassword, user.password_hash)) {
      return res.status(401).json({ message: 'Current password is incorrect' });
    }

    await supabase
      .from('users')
      .update({ password_hash: bcrypt.hashSync(newPassword, 10) })
      .eq('id', req.user.id);

    res.json({ message: 'Password changed successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
=======
    const isMember = req.user.role === 'user';
    const table = isMember ? 'member' : 'library_staff';
    const idCol = isMember ? 'member_id' : 'issued_by_id';

    const { data: identity } = await supabase.from(table).select('password_hash').eq(idCol, req.user.id).single();
    if (!bcrypt.compareSync(currentPassword, identity?.password_hash || ''))
      return res.status(401).json({ message: 'Current password is incorrect' });

    await supabase.from(table).update({ password_hash: bcrypt.hashSync(newPassword, 10) }).eq(idCol, req.user.id);
    res.json({ message: 'Password changed successfully' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
>>>>>>> testing
});

module.exports = router;
