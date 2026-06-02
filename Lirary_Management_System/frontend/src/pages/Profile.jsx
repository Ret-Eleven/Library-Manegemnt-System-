import { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import api from '../services/api';

const ROLE_BADGE = {
  user:       'bg-blue-100 text-blue-800',
  admin:      'bg-amber-100 text-amber-800',
  superadmin: 'bg-purple-100 text-purple-800',
};

function Toast({ toast }) {
  if (!toast) return null;
  return (
    <div className={`fixed top-4 right-4 z-50 flex items-center gap-2 px-4 py-3 rounded-xl shadow-lg text-sm font-medium
      ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-green-600 text-white'}`}>
      <span>{toast.type === 'error' ? '✕' : '✓'}</span>
      {toast.msg}
    </div>
  );
}

export default function Profile() {
  const { user, login, logout } = useAuth();

  const [tab, setTab]         = useState('profile');
  const [profile, setProfile] = useState({ name: '', email: '' });
  const [pw, setPw]           = useState({ current: '', next: '', confirm: '' });
  const [saving, setSaving]   = useState(false);
  const [toast, setToast]     = useState(null);
  const [fullUser, setFullUser] = useState(null);

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  useEffect(() => {
    api.get('/api/auth/me').then(r => {
      setFullUser(r.data);
      setProfile({ name: r.data.name, email: r.data.email });
    });
  }, []);

  const handleProfileSave = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      const { data } = await api.put('/api/auth/profile', profile);
      setFullUser(data.user);
      localStorage.setItem('user', JSON.stringify({ ...user, name: data.user.name, email: data.user.email }));
      showToast('Profile updated successfully');
    } catch (err) {
      showToast(err.response?.data?.message || 'Failed to update profile', 'error');
    } finally {
      setSaving(false);
    }
  };

  const handlePasswordSave = async (e) => {
    e.preventDefault();
    if (pw.next !== pw.confirm) return showToast('New passwords do not match', 'error');
    setSaving(true);
    try {
      await api.put('/api/auth/password', { currentPassword: pw.current, newPassword: pw.next });
      setPw({ current: '', next: '', confirm: '' });
      showToast('Password changed successfully');
    } catch (err) {
      showToast(err.response?.data?.message || 'Failed to change password', 'error');
    } finally {
      setSaving(false);
    }
  };

  const initials = (fullUser?.name || user?.name || '?')
    .split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2);

  const joinedDate = fullUser?.created_at
    ? new Date(fullUser.created_at).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
    : '—';

  return (
    <div className="max-w-2xl mx-auto">
      <Toast toast={toast} />

      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">My Profile</h1>
        <p className="text-gray-500 text-sm mt-1">Manage your personal information and password</p>
      </div>

      {/* Avatar card */}
      <div className="card flex items-center gap-5 mb-6">
        <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-blue-600 to-blue-800 flex items-center justify-center text-white text-xl font-extrabold shadow-md flex-shrink-0">
          {initials}
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-lg font-bold text-gray-900 truncate">{fullUser?.name || user?.name}</p>
          <p className="text-sm text-gray-500 truncate">{fullUser?.email || user?.email}</p>
          <div className="flex items-center gap-2 mt-1.5">
            <span className={`badge ${ROLE_BADGE[user?.role]}`}>{user?.role}</span>
            <span className="text-xs text-gray-400">Member since {joinedDate}</span>
          </div>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex gap-1 bg-gray-100 p-1 rounded-xl mb-6">
        {[
          { id: 'profile',  label: '👤 Edit Profile' },
          { id: 'password', label: '🔒 Change Password' },
        ].map(t => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            className={`flex-1 py-2 text-sm font-semibold rounded-lg transition-all
              ${tab === t.id ? 'bg-white shadow text-gray-900' : 'text-gray-500 hover:text-gray-700'}`}
          >
            {t.label}
          </button>
        ))}
      </div>

      {/* Profile tab */}
      {tab === 'profile' && (
        <div className="card">
          <h2 className="text-base font-semibold text-gray-900 mb-5">Personal Information</h2>
          <form onSubmit={handleProfileSave} className="space-y-4">
            <div>
              <label className="label">Full Name</label>
              <input
                className="input"
                type="text"
                value={profile.name}
                onChange={e => setProfile({ ...profile, name: e.target.value })}
                required
              />
            </div>
            <div>
              <label className="label">Email Address</label>
              <input
                className="input"
                type="email"
                value={profile.email}
                onChange={e => setProfile({ ...profile, email: e.target.value })}
                required
              />
            </div>
            <div>
              <label className="label">Role</label>
              <input
                className="input bg-gray-50 cursor-not-allowed"
                value={user?.role}
                disabled
              />
              <p className="text-xs text-gray-400 mt-1">Role cannot be changed here</p>
            </div>
            <div className="pt-2 flex justify-end">
              <button type="submit" className="btn-primary" disabled={saving}>
                {saving ? 'Saving…' : 'Save Changes'}
              </button>
            </div>
          </form>
        </div>
      )}

      {/* Password tab */}
      {tab === 'password' && (
        <div className="card">
          <h2 className="text-base font-semibold text-gray-900 mb-1">Change Password</h2>
          <p className="text-sm text-gray-500 mb-5">Choose a strong password with at least 6 characters.</p>
          <form onSubmit={handlePasswordSave} className="space-y-4">
            <div>
              <label className="label">Current Password</label>
              <input
                className="input"
                type="password"
                placeholder="Enter your current password"
                value={pw.current}
                onChange={e => setPw({ ...pw, current: e.target.value })}
                required
              />
            </div>
            <div>
              <label className="label">New Password</label>
              <input
                className="input"
                type="password"
                placeholder="At least 6 characters"
                value={pw.next}
                onChange={e => setPw({ ...pw, next: e.target.value })}
                minLength={6}
                required
              />
            </div>
            <div>
              <label className="label">Confirm New Password</label>
              <input
                className="input"
                type="password"
                placeholder="Repeat new password"
                value={pw.confirm}
                onChange={e => setPw({ ...pw, confirm: e.target.value })}
                required
              />
              {pw.confirm && pw.next !== pw.confirm && (
                <p className="text-xs text-red-500 mt-1">Passwords do not match</p>
              )}
            </div>
            <div className="pt-2 flex justify-end">
              <button
                type="submit"
                className="btn-primary"
                disabled={saving || (pw.confirm && pw.next !== pw.confirm)}
              >
                {saving ? 'Saving…' : 'Update Password'}
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
}
