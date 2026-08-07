const express = require('express');
<<<<<<< HEAD
const bcrypt = require('bcryptjs');
const { supabase } = require('../config/database');
const { authenticate } = require('../middleware/auth');
=======
const bcrypt  = require('bcryptjs');
const { supabase }       = require('../config/database');
const { authenticate }   = require('../middleware/auth');
>>>>>>> testing
const { requireMinRole } = require('../middleware/rbac');
const { splitName }      = require('../config/lookups');
const { parseUserId, memId, staffId } = require('../config/identity');
const { BOOK_JOIN, enrichRequest, enrichIssue } = require('../config/loanFormat');

const router = express.Router();

<<<<<<< HEAD
// Superadmin: list all users
=======
>>>>>>> testing
router.get('/', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { role, search, page = 1, limit = 20 } = req.query;
    const offset = (Number(page) - 1) * Number(limit);

<<<<<<< HEAD
    let query = supabase
      .from('users')
      .select('id, name, email, role, is_active, created_at', { count: 'exact' });

    if (role) query = query.eq('role', role);
    if (search) query = query.or(`name.ilike.%${search}%,email.ilike.%${search}%`);

    const { data: users, count: total, error } = await query
      .order('created_at', { ascending: false })
      .range(offset, offset + Number(limit) - 1);

    if (error) return res.status(500).json({ message: error.message });
    res.json({ users, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

// Superadmin: create admin or user
=======
    const wantsMembers = !role || role === 'user';
    const wantsStaff   = !role || role === 'admin' || role === 'superadmin';

    let memberQ = supabase.from('member').select('member_id,first_name,last_name,email_id,is_active,created_at');
    if (search) memberQ = memberQ.or(`first_name.ilike.%${search}%,last_name.ilike.%${search}%,email_id.ilike.%${search}%`);

    let staffQ = supabase.from('library_staff').select('issued_by_id,staff_name,email,staff_designation,is_active,created_at');
    if (role === 'admin' || role === 'superadmin') staffQ = staffQ.eq('staff_designation', role);
    if (search) staffQ = staffQ.or(`staff_name.ilike.%${search}%,email.ilike.%${search}%`);

    const [{ data: members, error: e1 }, { data: staff, error: e2 }] = await Promise.all([
      wantsMembers ? memberQ : Promise.resolve({ data: [] }),
      wantsStaff   ? staffQ  : Promise.resolve({ data: [] }),
    ]);
    if (e1) return res.status(500).json({ message: e1.message });
    if (e2) return res.status(500).json({ message: e2.message });

    const mapped = [
      ...(members || []).map(m => ({ id: memId(m.member_id), name: `${m.first_name} ${m.last_name}`.trim(), email: m.email_id, role: 'user', is_active: m.is_active, created_at: m.created_at })),
      ...(staff || []).map(s => ({ id: staffId(s.issued_by_id), name: s.staff_name, email: s.email, role: s.staff_designation, is_active: s.is_active, created_at: s.created_at })),
    ].sort((a, b) => (b.created_at || '').localeCompare(a.created_at || ''));

    const total = mapped.length;
    const users = mapped.slice(offset, offset + Number(limit));
    res.json({ users, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

>>>>>>> testing
router.post('/', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { name, email, password, role = 'user' } = req.body;
    if (!name || !email || !password) return res.status(400).json({ message: 'All fields required' });
    if (!['user', 'admin'].includes(role)) return res.status(400).json({ message: 'Invalid role. Allowed: user, admin' });

<<<<<<< HEAD
    const { data: existing } = await supabase.from('users').select('id').eq('email', email).maybeSingle();
    if (existing) return res.status(409).json({ message: 'Email already registered' });

    const hash = bcrypt.hashSync(password, 10);
    const { data, error } = await supabase
      .from('users')
      .insert({ name, email, password_hash: hash, role })
      .select('id')
      .single();

    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'User created', id: data.id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

// Superadmin: update user role / status / name
router.put('/:id', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { data: user } = await supabase.from('users').select('*').eq('id', req.params.id).single();
    if (!user) return res.status(404).json({ message: 'User not found' });
    if (user.role === 'superadmin' && Number(req.params.id) !== req.user.id) {
      return res.status(403).json({ message: 'Cannot modify another superadmin' });
    }

    const { role, is_active, name } = req.body;
    const validRoles = ['user', 'admin', 'superadmin'];
    if (role && !validRoles.includes(role)) return res.status(400).json({ message: 'Invalid role' });

    const { error } = await supabase
      .from('users')
      .update({
        name: name ?? user.name,
        role: role ?? user.role,
        is_active: is_active !== undefined ? (is_active ? 1 : 0) : user.is_active,
      })
      .eq('id', req.params.id);

    if (error) return res.status(500).json({ message: error.message });
    res.json({ message: 'User updated' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

// Superadmin: deactivate user (soft delete)
router.delete('/:id', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { data: user } = await supabase.from('users').select('role').eq('id', req.params.id).single();
    if (!user) return res.status(404).json({ message: 'User not found' });
    if (user.role === 'superadmin') return res.status(403).json({ message: 'Cannot delete a superadmin account' });

    await supabase
      .from('transactions')
      .update({ status: 'rejected' })
      .eq('user_id', req.params.id)
      .eq('status', 'pending');

    await supabase.from('users').update({ is_active: 0 }).eq('id', req.params.id);
    res.json({ message: 'User deactivated' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

// Admin+: view loans for a specific user
router.get('/:id/loans', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: loans, error } = await supabase
      .from('transactions')
      .select('*, books(title, author, isbn)')
      .eq('user_id', req.params.id)
      .order('id', { ascending: false });

    if (error) return res.status(500).json({ message: error.message });

    const result = loans.map(t => ({
      ...t,
      title: t.books?.title,
      author: t.books?.author,
      isbn: t.books?.isbn,
      books: undefined,
    }));
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
=======
    const { data: existingMember } = await supabase.from('member').select('member_id').eq('email_id', email).maybeSingle();
    const { data: existingStaff }  = await supabase.from('library_staff').select('issued_by_id').eq('email', email).maybeSingle();
    if (existingMember || existingStaff) return res.status(409).json({ message: 'Email already registered' });

    if (role === 'user') {
      const { first_name, last_name } = splitName(name);
      const { data, error } = await supabase.from('member')
        .insert({ first_name, last_name, email_id: email, password_hash: bcrypt.hashSync(password, 10) })
        .select('member_id').single();
      if (error) return res.status(500).json({ message: error.message });
      return res.status(201).json({ message: 'User created', id: memId(data.member_id) });
    }

    const { data, error } = await supabase.from('library_staff')
      .insert({ staff_name: name, email, password_hash: bcrypt.hashSync(password, 10), staff_designation: 'admin' })
      .select('issued_by_id').single();
    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'User created', id: staffId(data.issued_by_id) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

// Admin: search active users by name/email (for direct-issue modal)
router.get('/search', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { q = '' } = req.query;
    let query = supabase.from('member').select('member_id,first_name,last_name,email_id').eq('is_active', 1);
    if (q) query = query.or(`first_name.ilike.%${q}%,last_name.ilike.%${q}%,email_id.ilike.%${q}%`);
    const { data, error } = await query.order('first_name').limit(10);
    if (error) return res.status(500).json({ message: error.message });
    res.json((data || []).map(m => ({ id: memId(m.member_id), name: `${m.first_name} ${m.last_name}`.trim(), email: m.email_id, role: 'user' })));
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.put('/:id', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { table, rawId } = parseUserId(req.params.id);
    const { role, is_active, name } = req.body;

    if (table === 'member') {
      if (role && role !== 'user') return res.status(400).json({ message: 'Cannot change role across account type' });
      const { data: user } = await supabase.from('member').select('*').eq('member_id', rawId).single();
      if (!user) return res.status(404).json({ message: 'User not found' });

      const update = { is_active: is_active !== undefined ? (is_active ? 1 : 0) : user.is_active };
      if (name) Object.assign(update, splitName(name));
      const { error } = await supabase.from('member').update(update).eq('member_id', rawId);
      if (error) return res.status(500).json({ message: error.message });
      return res.json({ message: 'User updated' });
    }

    const { data: staff } = await supabase.from('library_staff').select('*').eq('issued_by_id', rawId).single();
    if (!staff) return res.status(404).json({ message: 'User not found' });
    if (staff.staff_designation === 'superadmin' && rawId !== req.user.id)
      return res.status(403).json({ message: 'Cannot modify another superadmin' });
    if (role && !['admin', 'superadmin'].includes(role))
      return res.status(400).json({ message: 'Cannot change role across account type' });

    const { error } = await supabase.from('library_staff').update({
      staff_name: name ?? staff.staff_name,
      staff_designation: role ?? staff.staff_designation,
      is_active: is_active !== undefined ? (is_active ? 1 : 0) : staff.is_active,
    }).eq('issued_by_id', rawId);
    if (error) return res.status(500).json({ message: error.message });
    res.json({ message: 'User updated' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.delete('/:id', authenticate, requireMinRole('superadmin'), async (req, res) => {
  try {
    const { table, rawId } = parseUserId(req.params.id);

    if (table === 'member') {
      const { data: user } = await supabase.from('member').select('member_id').eq('member_id', rawId).maybeSingle();
      if (!user) return res.status(404).json({ message: 'User not found' });
      await supabase.from('book_request').update({ status: 'rejected' }).eq('member_id', rawId).eq('status', 'pending');
      await supabase.from('member').update({ is_active: 0 }).eq('member_id', rawId);
      return res.json({ message: 'User deactivated' });
    }

    const { data: staff } = await supabase.from('library_staff').select('staff_designation').eq('issued_by_id', rawId).maybeSingle();
    if (!staff) return res.status(404).json({ message: 'User not found' });
    if (staff.staff_designation === 'superadmin') return res.status(403).json({ message: 'Cannot delete a superadmin account' });
    await supabase.from('library_staff').update({ is_active: 0 }).eq('issued_by_id', rawId);
    res.json({ message: 'User deactivated' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.get('/:id/loans', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { table, rawId } = parseUserId(req.params.id);
    if (table !== 'member') return res.json([]);

    const [{ data: reqs, error: e1 }, { data: iss, error: e2 }] = await Promise.all([
      supabase.from('book_request').select(`request_id, book_id, member_id, request_date, status, book:book_id(${BOOK_JOIN})`)
        .eq('member_id', rawId).in('status', ['pending', 'rejected']),
      supabase.from('book_issue').select(`issue_id, book_id, member_id, issued_by_id, issue_date, due_date, return_date, status, pickup_code, book:book_id(${BOOK_JOIN}), fine_due(fine_total,paid)`)
        .eq('member_id', rawId),
    ]);
    if (e1) return res.status(500).json({ message: e1.message });
    if (e2) return res.status(500).json({ message: e2.message });

    const loans = [...(reqs || []).map(enrichRequest), ...(iss || []).map(enrichIssue)]
      .sort((a, b) => (b.borrow_date || '').localeCompare(a.borrow_date || ''));
    res.json(loans);
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
>>>>>>> testing
});

module.exports = router;
