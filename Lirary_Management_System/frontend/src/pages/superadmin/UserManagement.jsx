import { useState, useEffect, useCallback } from 'react';
import api from '../../services/api';

const ROLE_BADGE = {
  user:       'bg-blue-100 text-blue-800',
  admin:      'bg-amber-100 text-amber-800',
  superadmin: 'bg-purple-100 text-purple-800',
};

const EMPTY_FORM = { name: '', email: '', password: '', role: 'user' };

export default function UserManagement() {
  const [users, setUsers]     = useState([]);
  const [total, setTotal]     = useState(0);
  const [pages, setPages]     = useState(1);
  const [page, setPage]       = useState(1);
  const [search, setSearch]   = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [loading, setLoading] = useState(true);
  const [modal, setModal]     = useState(null); // null | 'create' | 'edit' | 'deactivate'
  const [selected, setSelected] = useState(null);
  const [form, setForm]       = useState(EMPTY_FORM);
  const [editForm, setEditForm] = useState({ name: '', role: 'user', is_active: true });
  const [saving, setSaving]   = useState(false);
  const [toast, setToast]     = useState(null);

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
    } finally {
      setLoading(false);
    }
  }, [page, search, roleFilter]);

  useEffect(() => { fetchUsers(); }, [fetchUsers]);

  const openCreate = () => {
    setForm(EMPTY_FORM);
    setModal('create');
  };

  const openEdit = (user) => {
    setSelected(user);
    setEditForm({ name: user.name, role: user.role, is_active: user.is_active === 1 });
    setModal('edit');
  };

  const openDeactivate = (user) => {
    setSelected(user);
    setModal('deactivate');
  };

  const closeModal = () => { setModal(null); setSelected(null); };

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
    } finally {
      setSaving(false);
    }
  };

  const handleEdit = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      await api.put(`/api/users/${selected.id}`, editForm);
      showToast('User updated.');
      closeModal();
      fetchUsers();
    } catch (err) {
      showToast(err.response?.data?.message || 'Update failed', 'error');
    } finally {
      setSaving(false);
    }
  };

  const handleDeactivate = async () => {
    setSaving(true);
    try {
      await api.delete(`/api/users/${selected.id}`);
      showToast('User deactivated.');
      closeModal();
      fetchUsers();
    } catch (err) {
      showToast(err.response?.data?.message || 'Action failed', 'error');
    } finally {
      setSaving(false);
    }
  };

  const ROLE_FILTERS = ['', 'user', 'admin', 'superadmin'];

  return (
    <div>
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-xl shadow-lg text-sm font-medium
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-green-600 text-white'}`}>
          {toast.msg}
        </div>
      )}

      <div className="mb-6 flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">User Management</h1>
          <p className="text-gray-500 text-sm mt-1">{total} accounts</p>
        </div>
        <button onClick={openCreate} className="btn-primary">+ Create User</button>
      </div>

      {/* Filters */}
      <div className="flex flex-col sm:flex-row gap-3 mb-5">
        <input
          type="text"
          className="input flex-1 max-w-xs"
          placeholder="Search name or email…"
          value={search}
          onChange={e => { setSearch(e.target.value); setPage(1); }}
        />
        <div className="flex gap-2">
          {ROLE_FILTERS.map(r => (
            <button
              key={r || 'all'}
              onClick={() => { setRoleFilter(r); setPage(1); }}
              className={`btn btn-sm capitalize ${roleFilter === r ? 'btn-primary' : 'btn-secondary'}`}
            >
              {r || 'All'}
            </button>
          ))}
        </div>
      </div>

      {loading ? (
        <div className="flex justify-center py-16">
          <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-700" />
        </div>
      ) : (
        <>
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Role</th>
                  <th>Status</th>
                  <th>Joined</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {users.length === 0 ? (
                  <tr><td colSpan={6} className="text-center py-8 text-gray-400">No users found</td></tr>
                ) : users.map(user => (
                  <tr key={user.id}>
                    <td className="font-medium">{user.name}</td>
                    <td className="text-gray-500 text-sm">{user.email}</td>
                    <td>
                      <span className={`badge ${ROLE_BADGE[user.role]}`}>{user.role}</span>
                    </td>
                    <td>
                      <span className={`badge ${user.is_active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                        {user.is_active ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                    <td className="text-gray-400 text-xs">
                      {new Date(user.created_at).toLocaleDateString()}
                    </td>
                    <td>
                      <div className="flex gap-2">
                        <button onClick={() => openEdit(user)} className="btn-secondary btn-sm">Edit</button>
                        {user.role !== 'superadmin' && (
                          <button onClick={() => openDeactivate(user)} className="btn-danger btn-sm">
                            {user.is_active ? 'Deactivate' : 'Deactivated'}
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {pages > 1 && (
            <div className="flex items-center justify-center gap-2 mt-6">
              <button className="btn-secondary btn-sm" onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1}>← Prev</button>
              <span className="text-sm text-gray-600">Page {page} of {pages}</span>
              <button className="btn-secondary btn-sm" onClick={() => setPage(p => Math.min(pages, p + 1))} disabled={page === pages}>Next →</button>
            </div>
          )}
        </>
      )}

      {/* Create user modal */}
      {modal === 'create' && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6">
            <h2 className="text-xl font-bold mb-5">Create User</h2>
            <form onSubmit={handleCreate} className="space-y-4">
              <div>
                <label className="label">Full Name *</label>
                <input className="input" value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} required />
              </div>
              <div>
                <label className="label">Email *</label>
                <input type="email" className="input" value={form.email} onChange={e => setForm({ ...form, email: e.target.value })} required />
              </div>
              <div>
                <label className="label">Password *</label>
                <input type="password" className="input" value={form.password} onChange={e => setForm({ ...form, password: e.target.value })} required minLength={6} />
              </div>
              <div>
                <label className="label">Role</label>
                <select className="input" value={form.role} onChange={e => setForm({ ...form, role: e.target.value })}>
                  <option value="user">User</option>
                  <option value="admin">Admin</option>
                </select>
              </div>
              <div className="flex justify-end gap-3 pt-2">
                <button type="button" onClick={closeModal} className="btn-secondary">Cancel</button>
                <button type="submit" className="btn-primary" disabled={saving}>
                  {saving ? 'Creating…' : 'Create User'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Edit user modal */}
      {modal === 'edit' && selected && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6">
            <h2 className="text-xl font-bold mb-1">Edit User</h2>
            <p className="text-gray-500 text-sm mb-5">{selected.email}</p>
            <form onSubmit={handleEdit} className="space-y-4">
              <div>
                <label className="label">Full Name</label>
                <input className="input" value={editForm.name} onChange={e => setEditForm({ ...editForm, name: e.target.value })} />
              </div>
              <div>
                <label className="label">Role</label>
                <select className="input" value={editForm.role} onChange={e => setEditForm({ ...editForm, role: e.target.value })}
                  disabled={selected.role === 'superadmin'}>
                  <option value="user">User</option>
                  <option value="admin">Admin</option>
                  <option value="superadmin">Superadmin</option>
                </select>
              </div>
              <div className="flex items-center gap-3">
                <input
                  type="checkbox"
                  id="is_active"
                  checked={editForm.is_active}
                  onChange={e => setEditForm({ ...editForm, is_active: e.target.checked })}
                  className="w-4 h-4 text-blue-600"
                />
                <label htmlFor="is_active" className="text-sm text-gray-700">Account active</label>
              </div>
              <div className="flex justify-end gap-3 pt-2">
                <button type="button" onClick={closeModal} className="btn-secondary">Cancel</button>
                <button type="submit" className="btn-primary" disabled={saving}>
                  {saving ? 'Saving…' : 'Save Changes'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Deactivate modal */}
      {modal === 'deactivate' && selected && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-sm p-6">
            <h2 className="text-xl font-bold mb-2">Deactivate Account</h2>
            <p className="text-gray-600 mb-6">
              Are you sure you want to deactivate <strong>{selected.name}</strong>'s account?
              Their pending loan requests will be rejected.
            </p>
            <div className="flex justify-end gap-3">
              <button onClick={closeModal} className="btn-secondary">Cancel</button>
              <button onClick={handleDeactivate} className="btn-danger" disabled={saving}>
                {saving ? 'Deactivating…' : 'Deactivate'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
