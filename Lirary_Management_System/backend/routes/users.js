const express = require('express');
const bcrypt  = require('bcryptjs');
const { supabase }       = require('../config/database');
const { authenticate }   = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');

const router = express.Router();

router.get('/', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { role, search, page=1, limit=20 } = req.query;
    const offset = (Number(page)-1)*Number(limit);

    let q = supabase.from('users').select('id,name,email,role,is_active,created_at',{ count:'exact' });
    if (role)   q = q.eq('role', role);
    if (search) q = q.or(`name.ilike.%${search}%,email.ilike.%${search}%`);

    const { data: users, count: total, error } = await q
      .order('created_at',{ ascending:false }).range(offset, offset+Number(limit)-1);
    if (error) return res.status(500).json({ message: error.message });
    res.json({ users, total, page:Number(page), pages:Math.ceil(total/Number(limit)) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.post('/', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { name, email, password, role='user' } = req.body;
    if (!name||!email||!password) return res.status(400).json({ message: 'All fields required' });
    if (!['user','admin'].includes(role)) return res.status(400).json({ message: 'Invalid role. Allowed: user, admin' });

    const { data: existing } = await supabase.from('users').select('id').eq('email',email).maybeSingle();
    if (existing) return res.status(409).json({ message: 'Email already registered' });

    const { data, error } = await supabase.from('users')
      .insert({ name, email, password_hash: bcrypt.hashSync(password,10), role }).select('id').single();
    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'User created', id: data.id });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.put('/:id', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { data: user } = await supabase.from('users').select('*').eq('id',req.params.id).single();
    if (!user) return res.status(404).json({ message: 'User not found' });
    if (user.role==='superadmin' && Number(req.params.id)!==req.user.id)
      return res.status(403).json({ message: 'Cannot modify another superadmin' });

    const { role, is_active, name } = req.body;
    if (role && !['user','admin','superadmin'].includes(role))
      return res.status(400).json({ message: 'Invalid role' });

    const { error } = await supabase.from('users').update({
      name:      name      ?? user.name,
      role:      role      ?? user.role,
      is_active: is_active !== undefined ? (is_active?1:0) : user.is_active,
    }).eq('id', req.params.id);
    if (error) return res.status(500).json({ message: error.message });
    res.json({ message: 'User updated' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.delete('/:id', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { data: user } = await supabase.from('users').select('role').eq('id',req.params.id).single();
    if (!user) return res.status(404).json({ message: 'User not found' });
    if (user.role==='superadmin') return res.status(403).json({ message: 'Cannot delete a superadmin account' });

    await supabase.from('transactions').update({ status:'rejected' }).eq('user_id',req.params.id).eq('status','pending');
    await supabase.from('users').update({ is_active:0 }).eq('id',req.params.id);
    res.json({ message: 'User deactivated' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.get('/:id/loans', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: loans, error } = await supabase.from('transactions')
      .select('*, books(title,author,isbn)').eq('user_id',req.params.id).order('id',{ascending:false});
    if (error) return res.status(500).json({ message: error.message });
    res.json(loans.map(t=>({ ...t, title:t.books?.title, author:t.books?.author, isbn:t.books?.isbn, books:undefined })));
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

module.exports = router;
