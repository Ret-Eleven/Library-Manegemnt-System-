import { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';

/* ── helpers ─────────────────────────────────────────────────── */
const fmt = (d) =>
  d ? new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : '—';

const greeting = () => {
  const h = new Date().getHours();
  return h < 12 ? 'Good morning' : h < 17 ? 'Good afternoon' : 'Good evening';
};

/* ── Stat card ───────────────────────────────────────────────── */
function StatCard({ icon, value, label, sub, gradient, loading }) {
  return (
    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-5 flex items-center gap-4">
      <div className={`w-12 h-12 rounded-2xl bg-gradient-to-br ${gradient} flex items-center justify-center text-xl shadow-md flex-shrink-0`}>
        {icon}
      </div>
      <div className="min-w-0">
        <p className="text-2xl font-extrabold text-gray-900 leading-none">
          {loading ? <span className="inline-block w-10 h-6 bg-gray-100 rounded animate-pulse"/> : value}
        </p>
        <p className="text-sm font-semibold text-gray-700 mt-0.5 truncate">{label}</p>
        {sub && <p className="text-xs text-gray-400 mt-0.5 truncate">{sub}</p>}
      </div>
    </div>
  );
}

/* ── Pending request card ────────────────────────────────────── */
function RequestCard({ loan, onIssue, onReject, busy }) {
  return (
    <div className="flex items-center gap-3 p-3.5 bg-gray-50 hover:bg-gray-100/70 rounded-xl transition-colors group">
      {/* Avatar */}
      <div className="w-9 h-9 rounded-xl bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center text-white text-xs font-extrabold flex-shrink-0 shadow-sm">
        {loan.user_name?.split(' ').map(w => w[0]).join('').slice(0, 2).toUpperCase() || '?'}
      </div>

      {/* Info */}
      <div className="flex-1 min-w-0">
        <p className="text-sm font-bold text-gray-900 truncate">{loan.title}</p>
        <p className="text-xs text-gray-500 truncate">{loan.user_name} · {loan.user_email}</p>
      </div>

      {/* Actions */}
      <div className="flex items-center gap-1.5 flex-shrink-0">
        <button
          onClick={() => onIssue(loan.id)}
          disabled={busy}
          className="flex items-center gap-1 bg-emerald-500 hover:bg-emerald-600 disabled:opacity-50
            text-white text-[11px] font-bold px-3 py-1.5 rounded-lg transition-colors shadow-sm"
        >
          {busy === `${loan.id}-issue` ? (
            <span className="w-3 h-3 border-2 border-white/30 border-t-white rounded-full animate-spin"/>
          ) : '✓'} Approve
        </button>
        <button
          onClick={() => onReject(loan.id)}
          disabled={busy}
          className="flex items-center gap-1 bg-white hover:bg-red-50 border border-red-200
            text-red-500 text-[11px] font-bold px-3 py-1.5 rounded-lg transition-colors"
        >
          {busy === `${loan.id}-reject` ? '…' : '✕'}
        </button>
      </div>
    </div>
  );
}

/* ── Activity item ───────────────────────────────────────────── */
const ACTIVITY_CFG = {
  pending:  { dot: 'bg-amber-400',  label: 'Requested', icon: '📋' },
  active:   { dot: 'bg-emerald-500', label: 'Issued',   icon: '📖' },
  returned: { dot: 'bg-blue-400',    label: 'Returned', icon: '✅' },
  rejected: { dot: 'bg-gray-300',    label: 'Rejected', icon: '✕'  },
};

function ActivityItem({ loan }) {
  const cfg = ACTIVITY_CFG[loan.status] || ACTIVITY_CFG.pending;
  return (
    <div className="flex items-start gap-3 py-2.5 border-b border-gray-50 last:border-0">
      <div className={`w-2 h-2 rounded-full ${cfg.dot} flex-shrink-0 mt-1.5`}/>
      <div className="flex-1 min-w-0">
        <p className="text-sm font-semibold text-gray-800 truncate">{loan.title}</p>
        <p className="text-xs text-gray-400 truncate">{loan.user_name} — {cfg.label}</p>
      </div>
      <p className="text-[11px] text-gray-400 flex-shrink-0">{fmt(loan.borrow_date || loan.return_date)}</p>
    </div>
  );
}

/* ── Main dashboard ──────────────────────────────────────────── */
export default function AdminDashboard() {
  const { user } = useAuth();

  const [pending,  setPending]  = useState([]);
  const [recent,   setRecent]   = useState([]);
  const [stats,    setStats]    = useState({ pending: 0, active: 0, overdue: 0, books: 0 });
  const [loading,  setLoading]  = useState(true);
  const [busy,     setBusy]     = useState(null);
  const [toast,    setToast]    = useState(null);

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchData = useCallback(async () => {
    try {
      const [r1, r2, r3, r4] = await Promise.all([
        api.get('/api/loans', { params: { status: 'pending', limit: 8 } }),
        api.get('/api/loans', { params: { status: 'active',  limit: 200 } }),
        api.get('/api/books', { params: { limit: 1 } }),
        api.get('/api/loans', { params: { limit: 6 } }),
      ]);

      const activeList = r2.data.loans || [];
      const overdueCount = activeList.filter(l => l.is_overdue).length;

      setPending(r1.data.loans || []);
      setRecent(r4.data.loans || []);
      setStats({
        pending: r1.data.total || 0,
        active:  r2.data.total || 0,
        overdue: overdueCount,
        books:   r3.data.total || 0,
      });
    } catch {
      showToast('Failed to load dashboard data', 'error');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { fetchData(); }, [fetchData]);

  const handleAction = async (id, action) => {
    setBusy(`${id}-${action}`);
    try {
      const { data } = await api.post(`/api/loans/${id}/${action}`);
      const msgs = {
        issue:  `Issued! Due: ${data.due_date}`,
        reject: 'Request rejected.',
      };
      showToast(msgs[action] || 'Done.');
      fetchData();
    } catch (err) {
      showToast(err.response?.data?.message || 'Action failed', 'error');
    } finally {
      setBusy(null);
    }
  };

  return (
    <div className="max-w-6xl mx-auto space-y-6">

      {/* ── Toast ── */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          {toast.type === 'error' ? '✕' : '✓'} {toast.msg}
        </div>
      )}

      {/* ── Welcome header ── */}
      <div className="bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-900 rounded-3xl p-6 text-white relative overflow-hidden">
        {/* Texture */}
        <div className="absolute inset-0 opacity-[0.05] pointer-events-none"
          style={{ backgroundImage: 'radial-gradient(circle at 1px 1px, white 1px, transparent 0)', backgroundSize: '24px 24px' }}/>
        <div className="absolute top-0 right-0 w-64 h-64 bg-blue-400/10 rounded-full blur-3xl pointer-events-none -translate-y-1/2 translate-x-1/4"/>

        <div className="relative flex flex-wrap items-center justify-between gap-4">
          <div>
            <p className="text-blue-300 text-sm font-semibold mb-1">
              {new Date().toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' })}
            </p>
            <h1 className="text-2xl sm:text-3xl font-extrabold leading-tight">
              {greeting()}, {user?.name?.split(' ')[0]} 👋
            </h1>
            <p className="text-blue-300 text-sm mt-1">
              {stats.pending > 0
                ? `You have ${stats.pending} pending request${stats.pending > 1 ? 's' : ''} to review.`
                : 'Everything is up to date. Great work!'}
            </p>
          </div>

          <div className="flex gap-2 flex-wrap">
            <Link to="/admin/books"
              className="inline-flex items-center gap-2 bg-white/15 hover:bg-white/25 border border-white/20
                text-white text-sm font-bold px-4 py-2.5 rounded-xl transition-colors backdrop-blur-sm">
              📚 Books
            </Link>
            <Link to="/admin/loans"
              className="inline-flex items-center gap-2 bg-white text-blue-900 hover:bg-blue-50
                text-sm font-bold px-4 py-2.5 rounded-xl transition-colors shadow-lg">
              📋 All Loans
            </Link>
          </div>
        </div>
      </div>

      {/* ── Stat cards ── */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard
          icon="⏳" value={stats.pending} label="Pending Requests"
          sub={stats.pending > 0 ? 'Needs review' : 'Queue clear'}
          gradient="from-amber-400 to-orange-500" loading={loading}
        />
        <StatCard
          icon="📖" value={stats.active} label="Active Loans"
          sub="Currently borrowed"
          gradient="from-blue-500 to-indigo-600" loading={loading}
        />
        <StatCard
          icon="⚠️" value={stats.overdue} label="Overdue"
          sub={stats.overdue > 0 ? 'Needs attention' : 'All on time'}
          gradient="from-red-500 to-rose-600" loading={loading}
        />
        <StatCard
          icon="📚" value={stats.books} label="Total Books"
          sub="In catalog"
          gradient="from-violet-500 to-purple-700" loading={loading}
        />
      </div>

      {/* ── Main grid ── */}
      <div className="grid grid-cols-1 lg:grid-cols-5 gap-6">

        {/* Pending requests — 3/5 */}
        <div className="lg:col-span-3 bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
          <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 bg-amber-50 rounded-xl flex items-center justify-center text-base">⏳</div>
              <div>
                <p className="font-extrabold text-gray-900 text-sm">Pending Approvals</p>
                <p className="text-xs text-gray-400">{stats.pending} request{stats.pending !== 1 ? 's' : ''} waiting</p>
              </div>
            </div>
            <Link to="/admin/loans?status=pending"
              className="text-xs text-blue-600 hover:text-blue-500 font-bold transition-colors">
              View all →
            </Link>
          </div>

          <div className="p-4 space-y-2">
            {loading ? (
              [1,2,3].map(i => <div key={i} className="h-14 bg-gray-100 rounded-xl animate-pulse"/>)
            ) : pending.length === 0 ? (
              <div className="flex flex-col items-center justify-center py-12 text-center">
                <div className="w-14 h-14 bg-emerald-50 rounded-2xl flex items-center justify-center text-3xl mb-3">✅</div>
                <p className="font-bold text-gray-700">All clear!</p>
                <p className="text-sm text-gray-400 mt-1">No pending requests right now.</p>
              </div>
            ) : (
              pending.map(loan => (
                <RequestCard
                  key={loan.id}
                  loan={loan}
                  onIssue={id => handleAction(id, 'issue')}
                  onReject={id => handleAction(id, 'reject')}
                  busy={busy}
                />
              ))
            )}
          </div>
        </div>

        {/* Right column — 2/5 */}
        <div className="lg:col-span-2 space-y-5">

          {/* Quick actions */}
          <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-5">
            <p className="text-xs font-bold text-gray-400 uppercase tracking-widest mb-4">Quick Actions</p>
            <div className="grid grid-cols-2 gap-3">
              {[
                { to: '/admin/books',        icon: '➕', label: 'Add Book',      color: 'from-blue-500 to-indigo-600' },
                { to: '/admin/loans',        icon: '📋', label: 'All Loans',     color: 'from-violet-500 to-purple-700' },
                { to: '/admin/loans?status=active',  icon: '📖', label: 'Active',       color: 'from-emerald-500 to-teal-600' },
                { to: '/admin/loans?status=overdue', icon: '⚠️', label: 'Overdue',      color: 'from-red-500 to-rose-600' },
              ].map(item => (
                <Link key={item.to} to={item.to}
                  className="flex flex-col items-center gap-2 p-4 bg-gray-50 hover:bg-gray-100 rounded-xl transition-colors group">
                  <div className={`w-10 h-10 bg-gradient-to-br ${item.color} rounded-xl flex items-center justify-center text-lg shadow-sm group-hover:scale-105 transition-transform`}>
                    {item.icon}
                  </div>
                  <span className="text-xs font-bold text-gray-700">{item.label}</span>
                </Link>
              ))}
            </div>
          </div>

          {/* Recent activity */}
          <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
            <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100">
              <div className="flex items-center gap-3">
                <div className="w-8 h-8 bg-blue-50 rounded-xl flex items-center justify-center text-base">🕐</div>
                <p className="font-extrabold text-gray-900 text-sm">Recent Activity</p>
              </div>
              <Link to="/admin/loans" className="text-xs text-blue-600 hover:text-blue-500 font-bold">View all →</Link>
            </div>
            <div className="px-5 py-3">
              {loading ? (
                [1,2,3].map(i => <div key={i} className="h-10 bg-gray-100 rounded-lg animate-pulse mb-2"/>)
              ) : recent.length === 0 ? (
                <p className="text-sm text-gray-400 text-center py-6">No recent activity</p>
              ) : (
                recent.map(loan => <ActivityItem key={loan.id} loan={loan} />)
              )}
            </div>
          </div>

        </div>
      </div>

      {/* ── Overdue alert banner ── */}
      {!loading && stats.overdue > 0 && (
        <div className="flex items-center gap-4 bg-red-50 border border-red-200 rounded-2xl px-5 py-4">
          <span className="text-2xl">⚠️</span>
          <div className="flex-1">
            <p className="font-extrabold text-red-700 text-sm">
              {stats.overdue} overdue loan{stats.overdue > 1 ? 's' : ''} require attention
            </p>
            <p className="text-xs text-red-500 mt-0.5">
              Members with overdue books may have accumulating fines. Review and follow up as needed.
            </p>
          </div>
          <Link to="/admin/loans"
            className="flex-shrink-0 bg-red-600 hover:bg-red-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-colors shadow-sm">
            Review →
          </Link>
        </div>
      )}
    </div>
  );
}
