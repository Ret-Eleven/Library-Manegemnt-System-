import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import api from '../../services/api';

function Stat({ icon, label, value, sub, color }) {
  return (
    <div className="card flex items-center gap-4">
      <div className={`w-14 h-14 rounded-2xl flex items-center justify-center text-2xl flex-shrink-0 ${color}`}>
        {icon}
      </div>
      <div className="min-w-0">
        <p className="text-3xl font-bold text-gray-900 truncate">{value}</p>
        <p className="text-sm font-medium text-gray-700 truncate">{label}</p>
        {sub && <p className="text-xs text-gray-400">{sub}</p>}
      </div>
    </div>
  );
}

const STATUS_BADGE = {
  pending:  'bg-yellow-100 text-yellow-800',
  active:   'bg-green-100 text-green-800',
  returned: 'bg-gray-100 text-gray-700',
  rejected: 'bg-red-100 text-red-700',
};

export default function SuperadminDashboard() {
  const [stats, setStats]   = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get('/api/loans/stats/overview')
      .then(r => setStats(r.data))
      .finally(() => setLoading(false));
  }, []);

  if (loading) {
    return (
      <div className="flex justify-center py-16">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-700" />
      </div>
    );
  }

  return (
    <div>
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Library Statistics</h1>
          <p className="text-gray-500 text-sm mt-1">System-wide overview</p>
        </div>
        <Link to="/superadmin/users" className="btn-primary">Manage Users</Link>
      </div>

      {/* KPI grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <Stat icon="📚" label="Total Books"    value={stats.totalBooks}     sub={`${stats.totalCopies} total copies`}  color="bg-blue-50" />
        <Stat icon="👥" label="Active Users"   value={stats.totalUsers}     color="bg-green-50" />
        <Stat icon="📋" label="Active Loans"   value={stats.activeLoans}    sub={`${stats.pendingRequests} pending`}   color="bg-purple-50" />
        <Stat icon="⚠️" label="Overdue Loans"  value={stats.overdueLoans}   color="bg-red-50" />
        <Stat icon="💰" label="Fines Collected" value={`$${Number(stats.totalFinesCollected).toFixed(2)}`} color="bg-emerald-50" />
        <Stat icon="💳" label="Fines Pending"  value={`$${Number(stats.totalFinesPending).toFixed(2)}`}   color="bg-amber-50" />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Most borrowed */}
        <div className="card">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Most Borrowed Books</h2>
          {stats.mostBorrowed.length === 0 ? (
            <p className="text-gray-400 text-sm">No data yet</p>
          ) : (
            <div className="space-y-3">
              {stats.mostBorrowed.map((book, i) => (
                <div key={i} className="flex items-center gap-3">
                  <span className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0
                    ${i === 0 ? 'bg-yellow-100 text-yellow-700' : i === 1 ? 'bg-gray-200 text-gray-600' : 'bg-orange-100 text-orange-700'}`}>
                    {i + 1}
                  </span>
                  <div className="flex-1 min-w-0">
                    <p className="font-medium text-sm truncate">{book.title}</p>
                    <p className="text-xs text-gray-400">{book.author}</p>
                  </div>
                  <span className="badge bg-blue-100 text-blue-700 flex-shrink-0">
                    {book.borrow_count}×
                  </span>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Recent activity */}
        <div className="card">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Recent Activity</h2>
            <Link to="/admin/loans" className="text-sm text-blue-600 hover:underline">View all →</Link>
          </div>
          {stats.recentActivity.length === 0 ? (
            <p className="text-gray-400 text-sm">No activity yet</p>
          ) : (
            <div className="space-y-2">
              {stats.recentActivity.map(a => (
                <div key={a.id} className="flex items-start gap-3 py-2 border-b border-gray-50 last:border-0">
                  <span className={`badge mt-0.5 ${STATUS_BADGE[a.status]}`}>{a.status}</span>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium truncate">{a.title}</p>
                    <p className="text-xs text-gray-400">{a.user_name} · {a.borrow_date || a.return_date || 'pending'}</p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Loans by month */}
      {stats.loansByMonth.length > 0 && (
        <div className="card mt-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Loans by Month (Last 6 months)</h2>
          <div className="flex items-end gap-3 h-32">
            {[...stats.loansByMonth].reverse().map(m => {
              const maxCount = Math.max(...stats.loansByMonth.map(x => x.count));
              const height = maxCount > 0 ? Math.round((m.count / maxCount) * 100) : 0;
              return (
                <div key={m.month} className="flex-1 flex flex-col items-center gap-1">
                  <span className="text-xs font-medium text-gray-700">{m.count}</span>
                  <div
                    className="w-full bg-blue-500 rounded-t-lg transition-all"
                    style={{ height: `${Math.max(height, 4)}%`, minHeight: '4px' }}
                  />
                  <span className="text-xs text-gray-400">{m.month.slice(5)}/{m.month.slice(2, 4)}</span>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
