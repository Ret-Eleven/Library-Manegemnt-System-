import { useState, useEffect, useCallback } from 'react';
import api from '../../services/api';

const ROLE_BADGE = {
  user:       'bg-blue-100 text-blue-700',
  admin:      'bg-amber-100 text-amber-700',
  superadmin: 'bg-purple-100 text-purple-700',
};

const ROLE_ICON = { user: '🎓', admin: '📖', superadmin: '👑' };

const EMPTY_FORM = { name: '', email: '', password: '', role: 'user' };

function Avatar({ name, size = 'md' }) {
  const initials = name
    ? name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2)
    : '?';
  const sz = size === 'sm' ? 'w-8 h-8 text-xs' : 'w-10 h-10 text-sm';
  const colors = ['bg-blue-500','bg-purple-500','bg-emerald-500','bg-amber-500','bg-rose-500','bg-indigo-500'];
  const color  = colors[(name?.charCodeAt(0) || 0) % colors.length];
  return (
    <div className={`${sz} ${color} rounded-full flex items-center justify-center text-white font-bold flex-shrink-0`}>
      {initials}
    </div>
  );
}

function Toast({ toast }) {
  if (!toast) return null;
  return (
    <div className={`fixed top-5 right-5 z-[100] flex items-center gap-2.5 px-4 py-3 rounded-xl shadow-lg text-sm font-semibold animate-fade-in
      ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
      <span>{toast.type === 'error' ? '✕' : '✓'}</span>
      {toast.msg}
    </div>
  );
}

function Modal({ title, subtitle, icon, onClose, children }) {
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md">
        {/* Modal header */}
        <div className="flex items-center gap-3 px-6 pt-6 pb-4 border-b border-gray-100">
          {icon && <span className="text-2xl">{icon}</span>}
          <div className="flex-1 min-w-0">
            <h2 className="text-lg font-bold text-gray-900">{title}</h2>
            {subtitle && <p className="text-sm text-gray-400 truncate mt-0.5">{subtitle}</p>}
          </div>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600 text-xl leading-none transition-colors">
            ✕
          </button>
        </div>
        <div className="px-6 py-5">{children}</div>
      </div>
    </div>
  );
}

const ROLE_FILTERS = [
  { value: '',           label: 'All Users' },
  { value: 'user',       label: '🎓 Students' },
  { value: 'admin',      label: '📖 Admins' },
  { value: 'superadmin', label: '👑 Superadmin' },
];

export default function UserManagement() {
  const [users, setUsers]           = useState([]);
  const [total, setTotal]           = useState(0);
  const [pages, setPages]           = useState(1);
  const [page, setPage]             = useState(1);
  const [search, setSearch]         = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [loading, setLoading]       = useState(true);
  const [modal, setModal]           = useState(null);
  const [selected, setSelected]     = useState(null);
  const [form, setForm]             = useState(EMPTY_FORM);
  const [editForm, setEditForm]     = useState({ name: '', role: 'user', is_active: true });
  const [saving, setSaving]         = useState(false);
  const [toast, setToast]           = useState(null);
  const [roleCounts, setRoleCounts] = useState({ user: 0, admin: 0, superadmin: 0 });

  const LIMIT = 15;

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchUsers = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: LIMIT };
      if (search)     params.search = search;
      if (roleFilter) params.role   = roleFilter;
      const { data } = await api.get('/api/users', { params });
      setUsers(data.users);
      setTotal(data.total);
      setPages(data.pages);

      // compute role counts from unfiltered total if no filter active
      if (!search && !roleFilter) {
        const counts = { user: 0, admin: 0, superadmin: 0 };
        data.users.forEach(u => { if (counts[u.role] !== undefined) counts[u.role]++; });
        // fetch all to get accurate counts
        api.get('/api/users', { params: { limit: 1000 } }).then(r => {
          const c = { user: 0, admin: 0, superadmin: 0 };
          r.data.users.forEach(u => { if (c[u.role] !== undefined) c[u.role]++; });
          setRoleCounts(c);
        });
      }
    } finally {
      setLoading(false);
    }
  }, [page, search, roleFilter]);

  useEffect(() => { fetchUsers(); }, [fetchUsers]);

  const openCreate = () => { setForm(EMPTY_FORM); setModal('create'); };
  const openEdit   = (u)  => { setSelected(u); setEditForm({ name: u.name, role: u.role, is_active: u.is_active === 1 }); setModal('edit'); };
  const openToggle = (u)  => { setSelected(u); setModal('toggle'); };
  const closeModal = ()   => { setModal(null); setSelected(null); };

  const handleCreate = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      await api.post('/api/users', form);
      showToast('User created successfully!');
      closeModal();
      fetchUsers();
    } catch (err) {
      showToast(err.response?.data?.message || 'Create failed', 'error');
    } finally { setSaving(false); }
  };

  const handleEdit = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      await api.put(`/api/users/${selected.id}`, editForm);
      showToast('User updated successfully.');
      closeModal();
      fetchUsers();
    } catch (err) {
      showToast(err.response?.data?.message || 'Update failed', 'error');
    } finally { setSaving(false); }
  };

  const handleToggle = async () => {
    setSaving(true);
    try {
      await api.delete(`/api/users/${selected.id}`);
      showToast(selected.is_active ? 'User deactivated.' : 'User activated.');
      closeModal();
      fetchUsers();
    } catch (err) {
      showToast(err.response?.data?.message || 'Action failed', 'error');
    } finally { setSaving(false); }
  };

  return (
    <div className="space-y-6">
      <Toast toast={toast} />

      {/* ── Header ── */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">User Management</h1>
          <p className="text-sm text-gray-400 mt-0.5">{total} total accounts</p>
        </div>
        <button onClick={openCreate} className="btn-primary flex-shrink-0">
          + Add New User
        </button>
      </div>

      {/* ── Stat cards ── */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
        {[
          { label: 'Total Users',   value: total,                icon: '👤', color: 'bg-gray-50   border-gray-200'  },
          { label: 'Students',      value: roleCounts.user,      icon: '🎓', color: 'bg-blue-50   border-blue-200'  },
          { label: 'Admins',        value: roleCounts.admin,     icon: '📖', color: 'bg-amber-50  border-amber-200' },
          { label: 'Superadmins',   value: roleCounts.superadmin,icon: '👑', color: 'bg-purple-50 border-purple-200'},
        ].map(s => (
          <div key={s.label} className={`flex items-center gap-3 p-4 rounded-xl border ${s.color}`}>
            <span className="text-2xl">{s.icon}</span>
            <div>
              <p className="text-2xl font-extrabold text-gray-900 leading-none">{s.value}</p>
              <p className="text-xs text-gray-500 mt-0.5">{s.label}</p>
            </div>
          </div>
        ))}
      </div>

      {/* ── Filters ── */}
      <div className="flex flex-col sm:flex-row gap-3">
        {/* Search */}
        <div className="relative flex-1 max-w-sm">
          <span className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">🔍</span>
          <input
            type="text"
            className="input pl-9 pr-8"
            placeholder="Search name or email…"
            value={search}
            onChange={e => { setSearch(e.target.value); setPage(1); }}
          />
          {search && (
            <button
              onClick={() => { setSearch(''); setPage(1); }}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
            >✕</button>
          )}
        </div>

        {/* Role pills */}
        <div className="flex gap-2 flex-wrap">
          {ROLE_FILTERS.map(r => (
            <button
              key={r.value}
              onClick={() => { setRoleFilter(r.value); setPage(1); }}
              className={`px-4 py-2 rounded-full text-xs font-semibold border transition-all
                ${roleFilter === r.value
                  ? 'bg-blue-600 text-white border-blue-600 shadow-sm'
                  : 'bg-white text-gray-500 border-gray-200 hover:border-blue-300 hover:text-blue-600'}`}
            >
              {r.label}
            </button>
          ))}
        </div>
      </div>

      {/* ── Table ── */}
      {loading ? (
        <div className="flex items-center justify-center py-20">
          <div className="w-10 h-10 border-[3px] border-blue-200 border-t-blue-600 rounded-full animate-spin" />
        </div>
      ) : (
        <>
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>User</th>
                  <th>Role</th>
                  <th>Status</th>
                  <th>Joined</th>
                  <th className="text-right">Actions</th>
                </tr>
              </thead>
              <tbody>
                {users.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="py-16 text-center">
                      <div className="text-4xl mb-2">👤</div>
                      <p className="font-semibold text-gray-600">No users found</p>
                      <p className="text-sm text-gray-400 mt-1">Try a different search or filter</p>
                    </td>
                  </tr>
                ) : users.map(u => (
                  <tr key={u.id} className={!u.is_active ? 'opacity-60' : ''}>
                    {/* User cell */}
                    <td>
                      <div className="flex items-center gap-3">
                        <Avatar name={u.name} />
                        <div className="min-w-0">
                          <p className="font-semibold text-gray-900 text-sm truncate">{u.name}</p>
                          <p className="text-xs text-gray-400 truncate">{u.email}</p>
                        </div>
                      </div>
                    </td>

                    {/* Role */}
                    <td>
                      <span className={`badge ${ROLE_BADGE[u.role]}`}>
                        {ROLE_ICON[u.role]} {u.role}
                      </span>
                    </td>

                    {/* Status */}
                    <td>
                      <span className={`badge ${u.is_active ? 'bg-emerald-100 text-emerald-700' : 'bg-red-100 text-red-600'}`}>
                        {u.is_active ? '● Active' : '● Inactive'}
                      </span>
                    </td>

                    {/* Joined */}
                    <td className="text-xs text-gray-400">
                      {new Date(u.created_at).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })}
                    </td>

                    {/* Actions */}
                    <td>
                      <div className="flex gap-2 justify-end">
                        <button onClick={() => openEdit(u)} className="btn-secondary btn-sm">
                          ✏️ Edit
                        </button>
                        {u.role !== 'superadmin' && (
                          <button
                            onClick={() => openToggle(u)}
                            className={`btn-sm ${u.is_active ? 'btn-danger' : 'btn-success'}`}
                          >
                            {u.is_active ? '🚫 Deactivate' : '✅ Activate'}
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          {pages > 1 && (
            <div className="flex items-center justify-center gap-3 mt-2">
              <button className="btn-secondary btn-sm" onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1}>
                ← Prev
              </button>
              <div className="flex gap-1">
                {Array.from({ length: pages }, (_, i) => i + 1).map(p => (
                  <button
                    key={p}
                    onClick={() => setPage(p)}
                    className={`w-8 h-8 rounded-lg text-xs font-semibold transition-all
                      ${p === page ? 'bg-blue-600 text-white shadow-sm' : 'text-gray-500 hover:bg-gray-100'}`}
                  >
                    {p}
                  </button>
                ))}
              </div>
              <button className="btn-secondary btn-sm" onClick={() => setPage(p => Math.min(pages, p + 1))} disabled={page === pages}>
                Next →
              </button>
            </div>
          )}
        </>
      )}

      {/* ── Create Modal ── */}
      {modal === 'create' && (
        <Modal title="Create New User" icon="👤" onClose={closeModal}>
          <form onSubmit={handleCreate} className="space-y-4">
            <div>
              <label className="label">Full Name *</label>
              <input className="input" placeholder="John Doe" value={form.name}
                onChange={e => setForm({ ...form, name: e.target.value })} required />
            </div>
            <div>
              <label className="label">Email Address *</label>
              <input type="email" className="input" placeholder="john@example.com" value={form.email}
                onChange={e => setForm({ ...form, email: e.target.value })} required />
            </div>
            <div>
              <label className="label">Password *</label>
              <input type="password" className="input" placeholder="Min. 6 characters" value={form.password}
                onChange={e => setForm({ ...form, password: e.target.value })} required minLength={6} />
            </div>
            <div>
              <label className="label">Role</label>
              <select className="input" value={form.role} onChange={e => setForm({ ...form, role: e.target.value })}>
                <option value="user">🎓 Student</option>
                <option value="admin">📖 Admin</option>
              </select>
            </div>
            <div className="flex justify-end gap-3 pt-2">
              <button type="button" onClick={closeModal} className="btn-secondary">Cancel</button>
              <button type="submit" className="btn-primary" disabled={saving}>
                {saving ? 'Creating…' : '+ Create User'}
              </button>
            </div>
          </form>
        </Modal>
      )}

      {/* ── Edit Modal ── */}
      {modal === 'edit' && selected && (
        <Modal title="Edit User" subtitle={selected.email} icon={ROLE_ICON[selected.role]} onClose={closeModal}>
          <div className="flex items-center gap-3 mb-5 p-3 bg-gray-50 rounded-xl">
            <Avatar name={selected.name} />
            <div>
              <p className="font-semibold text-gray-900 text-sm">{selected.name}</p>
              <p className="text-xs text-gray-400">{selected.email}</p>
            </div>
          </div>
          <form onSubmit={handleEdit} className="space-y-4">
            <div>
              <label className="label">Full Name</label>
              <input className="input" value={editForm.name}
                onChange={e => setEditForm({ ...editForm, name: e.target.value })} required />
            </div>
            <div>
              <label className="label">Role</label>
              <select className="input" value={editForm.role}
                onChange={e => setEditForm({ ...editForm, role: e.target.value })}
                disabled={selected.role === 'superadmin'}>
                <option value="user">🎓 Student</option>
                <option value="admin">📖 Admin</option>
                <option value="superadmin">👑 Superadmin</option>
              </select>
            </div>
            <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-xl">
              <input
                type="checkbox" id="is_active"
                checked={editForm.is_active}
                onChange={e => setEditForm({ ...editForm, is_active: e.target.checked })}
                className="w-4 h-4 accent-blue-600"
              />
              <label htmlFor="is_active" className="text-sm text-gray-700 font-medium cursor-pointer">
                Account is active
              </label>
            </div>
            <div className="flex justify-end gap-3 pt-2">
              <button type="button" onClick={closeModal} className="btn-secondary">Cancel</button>
              <button type="submit" className="btn-primary" disabled={saving}>
                {saving ? 'Saving…' : 'Save Changes'}
              </button>
            </div>
          </form>
        </Modal>
      )}

      {/* ── Activate / Deactivate Modal ── */}
      {modal === 'toggle' && selected && (
        <Modal
          title={selected.is_active ? 'Deactivate Account' : 'Activate Account'}
          icon={selected.is_active ? '🚫' : '✅'}
          onClose={closeModal}
        >
          <div className="flex items-center gap-3 mb-5 p-3 bg-gray-50 rounded-xl">
            <Avatar name={selected.name} />
            <div>
              <p className="font-semibold text-gray-900 text-sm">{selected.name}</p>
              <p className="text-xs text-gray-400">{selected.email}</p>
            </div>
          </div>
          <p className="text-sm text-gray-600 mb-6 leading-relaxed">
            {selected.is_active
              ? <>Are you sure you want to deactivate <strong>{selected.name}</strong>'s account? They will not be able to sign in.</>
              : <>Reactivate <strong>{selected.name}</strong>'s account? They will regain full access.</>
            }
          </p>
          <div className="flex justify-end gap-3">
            <button onClick={closeModal} className="btn-secondary">Cancel</button>
            <button
              onClick={handleToggle}
              className={selected.is_active ? 'btn-danger' : 'btn-success'}
              disabled={saving}
            >
              {saving
                ? 'Processing…'
                : selected.is_active ? '🚫 Deactivate' : '✅ Activate'}
            </button>
          </div>
        </Modal>
      )}
    </div>
  );
}
