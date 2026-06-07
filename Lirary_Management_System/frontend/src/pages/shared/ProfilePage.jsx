import { useState, useEffect } from 'react';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';

const ROLE_META = {
  user:       { label: 'Student',   color: 'bg-blue-100 text-blue-700',     icon: '🎓' },
  admin:      { label: 'Librarian', color: 'bg-amber-100 text-amber-700',   icon: '📖' },
  superadmin: { label: 'Director',  color: 'bg-purple-100 text-purple-700', icon: '👑' },
};

function StatCard({ icon, label, value, bg }) {
  return (
    <div className={`${bg} rounded-2xl p-4 flex items-center gap-3 border border-white/60`}>
      <span className="text-2xl">{icon}</span>
      <div>
        <p className="text-2xl font-extrabold text-gray-900 leading-none">{value}</p>
        <p className="text-xs text-gray-500 mt-0.5">{label}</p>
      </div>
    </div>
  );
}

export default function ProfilePage() {
  const { user, updateUser } = useAuth();

  const [profile,  setProfile]  = useState(null);
  const [loans,    setLoans]    = useState([]);
  const [loading,  setLoading]  = useState(true);
  const [toast,    setToast]    = useState(null);

  const [editName,  setEditName]  = useState('');
  const [editEmail, setEditEmail] = useState('');
  const [saving,    setSaving]    = useState(false);

  const [pw,      setPw]      = useState({ current: '', newPw: '', confirm: '' });
  const [pwSaving, setPwSaving] = useState(false);

  useEffect(() => {
    Promise.all([
      api.get('/api/auth/me'),
      user?.role === 'user' ? api.get('/api/loans/my') : Promise.resolve({ data: [] }),
    ]).then(([pr, lr]) => {
      setProfile(pr.data);
      setEditName(pr.data.name);
      setEditEmail(pr.data.email);
      setLoans(Array.isArray(lr.data) ? lr.data : []);
    }).catch(() => {}).finally(() => setLoading(false));
  }, [user?.role]);

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const handleSaveProfile = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      const { data } = await api.put('/api/auth/profile', { name: editName, email: editEmail });
      updateUser({ name: data.user.name, email: data.user.email });
      setProfile(data.user);
      showToast('Profile updated successfully');
    } catch (err) {
      showToast(err.response?.data?.message || 'Update failed', 'error');
    } finally {
      setSaving(false);
    }
  };

  const handleChangePassword = async (e) => {
    e.preventDefault();
    if (pw.newPw !== pw.confirm) { showToast('New passwords do not match', 'error'); return; }
    if (pw.newPw.length < 6)    { showToast('Password must be at least 6 characters', 'error'); return; }
    setPwSaving(true);
    try {
      await api.put('/api/auth/password', { currentPassword: pw.current, newPassword: pw.newPw });
      setPw({ current: '', newPw: '', confirm: '' });
      showToast('Password changed successfully');
    } catch (err) {
      showToast(err.response?.data?.message || 'Failed to change password', 'error');
    } finally {
      setPwSaving(false);
    }
  };

  const active   = loans.filter(l => l.status === 'active');
  const returned = loans.filter(l => l.status === 'returned');
  const overdue  = loans.filter(l => l.is_overdue);

  const meta = ROLE_META[user?.role] || { label: user?.role, color: 'bg-gray-100 text-gray-700', icon: '👤' };

  const inputCls = 'w-full border border-gray-200 rounded-xl px-4 py-2.5 text-sm text-gray-900 outline-none focus:ring-2 focus:ring-blue-400 transition-all bg-white';
  const labelCls = 'block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1.5';

  return (
    <div className="max-w-3xl space-y-6">

      {/* Toast */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          {toast.type === 'error' ? '✕' : '✓'} {toast.msg}
        </div>
      )}

      {/* Header */}
      <div>
        <h1 className="text-2xl font-extrabold text-gray-900">My Profile</h1>
        <p className="text-sm text-gray-400 mt-0.5">View and manage your account information</p>
      </div>

      {/* Profile card */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6 flex items-center gap-5">
        <div className="w-20 h-20 bg-gradient-to-br from-blue-600 to-indigo-700 rounded-2xl flex items-center justify-center
          text-white text-2xl font-extrabold flex-shrink-0 shadow-lg">
          {user?.name?.split(' ').map(w => w[0]).join('').slice(0, 2).toUpperCase()}
        </div>
        <div>
          <h2 className="text-xl font-extrabold text-gray-900">{profile?.name || user?.name}</h2>
          <p className="text-sm text-gray-400 mt-0.5">{profile?.email || user?.email}</p>
          <div className="flex items-center gap-2 mt-2 flex-wrap">
            <span className={`inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1 rounded-full ${meta.color}`}>
              {meta.icon} {meta.label}
            </span>
            {profile?.created_at && (
              <span className="text-xs text-gray-400">
                Member since {new Date(profile.created_at).toLocaleDateString('en-US', { year: 'numeric', month: 'long' })}
              </span>
            )}
          </div>
        </div>
      </div>

      {/* Loan stats — user role only */}
      {user?.role === 'user' && (
        <div className="grid grid-cols-3 gap-4">
          <StatCard icon="📖" label="Active Loans" value={loading ? '…' : active.length}   bg="bg-blue-50" />
          <StatCard icon="✅" label="Returned"     value={loading ? '…' : returned.length} bg="bg-emerald-50" />
          <StatCard icon="⚠️" label="Overdue"      value={loading ? '…' : overdue.length}  bg="bg-red-50" />
        </div>
      )}

      {/* Edit profile */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6">
        <h3 className="font-extrabold text-gray-900 mb-5">Edit Profile</h3>
        <form onSubmit={handleSaveProfile} className="space-y-4">
          <div>
            <label className={labelCls}>Full Name</label>
            <input value={editName} onChange={e => setEditName(e.target.value)} required className={inputCls} />
          </div>
          <div>
            <label className={labelCls}>Email Address</label>
            <input type="email" value={editEmail} onChange={e => setEditEmail(e.target.value)} required className={inputCls} />
          </div>
          <div className="flex justify-end pt-1">
            <button type="submit" disabled={saving}
              className="bg-slate-900 hover:bg-slate-700 disabled:opacity-60 text-white text-sm font-bold px-6 py-2.5 rounded-xl transition-colors">
              {saving ? 'Saving…' : 'Save Changes'}
            </button>
          </div>
        </form>
      </div>

      {/* Change password */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6">
        <h3 className="font-extrabold text-gray-900 mb-5">Change Password</h3>
        <form onSubmit={handleChangePassword} className="space-y-4">
          {[
            { label: 'Current Password', key: 'current', placeholder: 'Enter your current password' },
            { label: 'New Password',     key: 'newPw',   placeholder: 'At least 6 characters'      },
            { label: 'Confirm New',      key: 'confirm', placeholder: 'Repeat new password'         },
          ].map(f => (
            <div key={f.key}>
              <label className={labelCls}>{f.label}</label>
              <input
                type="password"
                value={pw[f.key]}
                onChange={e => setPw(p => ({ ...p, [f.key]: e.target.value }))}
                placeholder={f.placeholder}
                required
                className={inputCls}
              />
            </div>
          ))}
          <div className="flex justify-end pt-1">
            <button type="submit" disabled={pwSaving}
              className="bg-slate-900 hover:bg-slate-700 disabled:opacity-60 text-white text-sm font-bold px-6 py-2.5 rounded-xl transition-colors">
              {pwSaving ? 'Updating…' : 'Update Password'}
            </button>
          </div>
        </form>
      </div>

    </div>
  );
}
