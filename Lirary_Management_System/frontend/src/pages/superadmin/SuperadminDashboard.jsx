import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';
import { Library, Users, ClipboardList, AlertTriangle, DollarSign, CreditCard } from 'lucide-react';

const STATUS_BADGE = {
  pending:  'bg-yellow-100 text-yellow-700',
  active:   'bg-green-100 text-green-700',
  returned: 'bg-gray-100 text-gray-600',
  rejected: 'bg-red-100 text-red-600',
};

function KpiCard({ icon, label, value, sub, color, to }) {
  const inner = (
    <div className={`card flex items-center gap-4 ${to ? 'hover:shadow-md transition-shadow cursor-pointer' : ''}`}>
      <div className={`w-14 h-14 rounded-2xl flex items-center justify-center text-2xl flex-shrink-0 ${color}`}>
        {icon}
      </div>
      <div className="min-w-0">
        <p className="text-3xl font-extrabold text-gray-900 leading-none">{value}</p>
        <p className="text-sm font-medium text-gray-600 mt-0.5">{label}</p>
        {sub && <p className="text-xs text-gray-400 mt-0.5">{sub}</p>}
      </div>
    </div>
  );
  return to ? <Link to={to} className="block">{inner}</Link> : inner;
}

function RankBadge({ i }) {
  const cls = i === 0 ? 'bg-yellow-100 text-yellow-700'
            : i === 1 ? 'bg-gray-200 text-gray-600'
            : i === 2 ? 'bg-orange-100 text-orange-600'
            :           'bg-gray-100 text-gray-500';
  return (
    <span className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0 ${cls}`}>
      {i + 1}
    </span>
  );
}

export default function SuperadminDashboard() {
  const { user } = useAuth();
  const [stats, setStats]     = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get('/api/loans/stats/overview')
      .then(r => setStats(r.data))
      .finally(() => setLoading(false));
  }, []);

  const today = new Date().toLocaleDateString('en-US', {
    weekday: 'long', year: 'numeric', month: 'long', day: 'numeric',
  });

  if (loading) {
    return (
      <div className="flex items-center justify-center py-24">
        <div className="w-10 h-10 border-[3px] border-blue-200 border-t-blue-600 rounded-full animate-spin" />
      </div>
    );
  }

  if (!stats) {
    return (
      <div className="flex flex-col items-center justify-center py-24 text-center">
        <div className="text-5xl mb-4">⚠️</div>
        <p className="text-lg font-bold text-gray-700">Could not load dashboard</p>
        <p className="text-sm text-gray-400 mt-1">Make sure the backend server is running</p>
        <button onClick={() => window.location.reload()} className="mt-4 btn-primary btn-sm">Retry</button>
      </div>
    );
  }

  const hasAlerts = stats.overdueLoans > 0 || stats.pendingRequests > 0;

  return (
    <div className="space-y-6">

      {/* ── Header ── */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <span className="text-xl">👑</span>
            <span className="badge bg-purple-100 text-purple-700 text-xs">Superadmin</span>
          </div>
          <h1 className="text-2xl font-extrabold text-gray-900">
            Welcome back, {user?.name?.split(' ')[0]}
          </h1>
          <p className="text-sm text-gray-400 mt-0.5">{today}</p>
        </div>
        <div className="flex gap-2 flex-wrap">
          <Link to="/superadmin/users" className="btn-primary btn-sm">👥 Manage Users</Link>
          <Link to="/admin/loans"      className="btn-secondary btn-sm">📋 All Loans</Link>
          <Link to="/admin/books"      className="btn-secondary btn-sm">📚 Books</Link>
        </div>
      </div>

<<<<<<< HEAD
      {/* ── Alert banners ── */}
      {hasAlerts && (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {stats.overdueLoans > 0 && (
            <div className="flex items-center gap-3 px-4 py-3 bg-red-50 border border-red-200 rounded-xl">
              <span className="text-xl">⚠️</span>
              <div>
                <p className="text-sm font-semibold text-red-700">
                  {stats.overdueLoans} overdue loan{stats.overdueLoans > 1 ? 's' : ''}
                </p>
                <p className="text-xs text-red-400">Fines may be accumulating</p>
              </div>
              <Link to="/admin/loans" className="ml-auto text-xs text-red-600 font-semibold hover:underline flex-shrink-0">
                View →
              </Link>
            </div>
          )}
          {stats.pendingRequests > 0 && (
            <div className="flex items-center gap-3 px-4 py-3 bg-yellow-50 border border-yellow-200 rounded-xl">
              <span className="text-xl">⏳</span>
              <div>
                <p className="text-sm font-semibold text-yellow-700">
                  {stats.pendingRequests} pending request{stats.pendingRequests > 1 ? 's' : ''}
                </p>
                <p className="text-xs text-yellow-500">Awaiting admin approval</p>
              </div>
              <Link to="/admin/loans" className="ml-auto text-xs text-yellow-700 font-semibold hover:underline flex-shrink-0">
                Review →
              </Link>
            </div>
          )}
        </div>
      )}

      {/* ── KPI Cards ── */}
      <div className="grid grid-cols-2 lg:grid-cols-3 gap-4">
        <KpiCard icon="📚" label="Total Books"       value={stats.totalBooks}   sub={`${stats.totalCopies} total copies`}           color="bg-blue-50"    to="/admin/books" />
        <KpiCard icon="👥" label="Registered Users"  value={stats.totalUsers}                                                        color="bg-indigo-50"  to="/superadmin/users" />
        <KpiCard icon="📋" label="Active Loans"      value={stats.activeLoans}  sub={`${stats.pendingRequests} pending approval`}    color="bg-purple-50"  to="/admin/loans" />
        <KpiCard icon="⚠️" label="Overdue Loans"     value={stats.overdueLoans}                                                      color="bg-red-50"     to="/admin/loans" />
        <KpiCard icon="💰" label="Fines Collected"   value={`$${Number(stats.totalFinesCollected).toFixed(2)}`}                     color="bg-emerald-50" />
        <KpiCard icon="💳" label="Fines Pending"     value={`$${Number(stats.totalFinesPending).toFixed(2)}`}                       color="bg-amber-50" />
=======
      {/* KPI grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <Stat icon={<Library className="w-7 h-7" />}       label="Total Books"    value={stats.totalBooks}     sub={`${stats.totalCopies} total copies`}  color="bg-blue-50" />
        <Stat icon={<Users className="w-7 h-7" />}         label="Active Users"   value={stats.totalUsers}     color="bg-green-50" />
        <Stat icon={<ClipboardList className="w-7 h-7" />} label="Active Loans"   value={stats.activeLoans}    sub={`${stats.pendingRequests} pending`}   color="bg-purple-50" />
        <Stat icon={<AlertTriangle className="w-7 h-7" />} label="Overdue Loans"  value={stats.overdueLoans}   color="bg-red-50" />
        <Stat icon={<DollarSign className="w-7 h-7" />}    label="Fines Collected" value={`$${Number(stats.totalFinesCollected).toFixed(2)}`} color="bg-emerald-50" />
        <Stat icon={<CreditCard className="w-7 h-7" />}    label="Fines Pending"  value={`$${Number(stats.totalFinesPending).toFixed(2)}`}   color="bg-amber-50" />
>>>>>>> testing
      </div>

      {/* ── Two columns ── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">

        {/* Most Borrowed */}
        <div className="card">
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-bold text-gray-900">🏆 Most Borrowed Books</h2>
          </div>
          {stats.mostBorrowed.length === 0 ? (
            <p className="text-sm text-gray-400 py-4 text-center">No borrowing data yet</p>
          ) : (
            <div className="space-y-3">
              {stats.mostBorrowed.map((book, i) => (
                <div key={i} className="flex items-center gap-3 py-2 border-b border-gray-50 last:border-0">
                  <RankBadge i={i} />
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold text-sm text-gray-800 truncate">{book.title}</p>
                    <p className="text-xs text-gray-400">{book.author}</p>
                  </div>
                  <span className="badge bg-blue-100 text-blue-700 flex-shrink-0">
                    {book.borrow_count}× borrowed
                  </span>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Recent Activity */}
        <div className="card">
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-bold text-gray-900">🕐 Recent Activity</h2>
            <Link to="/admin/loans" className="text-xs text-blue-600 hover:underline">View all →</Link>
          </div>
          {stats.recentActivity.length === 0 ? (
            <p className="text-sm text-gray-400 py-4 text-center">No activity yet</p>
          ) : (
            <div className="space-y-2">
              {stats.recentActivity.map(a => (
                <div key={a.id} className="flex items-start gap-3 py-2.5 border-b border-gray-50 last:border-0">
                  <span className={`badge flex-shrink-0 mt-0.5 ${STATUS_BADGE[a.status]}`}>{a.status}</span>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-gray-800 truncate">{a.title}</p>
                    <p className="text-xs text-gray-400">
                      {a.user_name} · {a.borrow_date || a.return_date || 'pending'}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* ── Loans by Month bar chart ── */}
      {stats.loansByMonth.length > 0 && (
        <div className="card">
          <h2 className="font-bold text-gray-900 mb-5">📈 Loans by Month</h2>
          <div className="flex items-end gap-3 h-36">
            {[...stats.loansByMonth].reverse().map(m => {
              const maxCount = Math.max(...stats.loansByMonth.map(x => x.count), 1);
              const pct = Math.round((m.count / maxCount) * 100);
              return (
                <div key={m.month} className="flex-1 flex flex-col items-center gap-1.5">
                  <span className="text-xs font-semibold text-gray-700">{m.count}</span>
                  <div
                    className="w-full bg-blue-500 rounded-t-lg transition-all hover:bg-blue-600"
                    style={{ height: `${Math.max(pct, 5)}%` }}
                  />
                  <span className="text-[10px] text-gray-400 font-medium">
                    {m.month.slice(5)}/{m.month.slice(2, 4)}
                  </span>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* ── Quick actions ── */}
      <div className="card">
        <h2 className="font-bold text-gray-900 mb-4">⚡ Quick Actions</h2>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {[
            { icon: '👥', label: 'Manage Users',  to: '/superadmin/users', color: 'bg-indigo-50 hover:bg-indigo-100' },
            { icon: '📚', label: 'Manage Books',  to: '/admin/books',      color: 'bg-blue-50 hover:bg-blue-100'    },
            { icon: '📋', label: 'All Loans',     to: '/admin/loans',      color: 'bg-purple-50 hover:bg-purple-100' },
            { icon: '⚙️', label: 'Settings',      to: '/superadmin/settings', color: 'bg-gray-50 hover:bg-gray-100' },
          ].map(a => (
            <Link
              key={a.label}
              to={a.to}
              className={`flex flex-col items-center gap-2 p-4 rounded-xl border border-gray-200 transition-colors ${a.color}`}
            >
              <span className="text-2xl">{a.icon}</span>
              <span className="text-xs font-semibold text-gray-700 text-center">{a.label}</span>
            </Link>
          ))}
        </div>
      </div>

    </div>
  );
}
