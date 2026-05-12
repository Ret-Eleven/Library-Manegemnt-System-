import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import api from '../../services/api';

function StatCard({ label, value, icon, color }) {
  return (
    <div className="card flex items-center gap-4">
      <div className={`w-12 h-12 rounded-xl flex items-center justify-center text-2xl ${color}`}>
        {icon}
      </div>
      <div>
        <p className="text-2xl font-bold text-gray-900">{value}</p>
        <p className="text-sm text-gray-500">{label}</p>
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

export default function AdminDashboard() {
  const [loans, setLoans]   = useState([]);
  const [stats, setStats]   = useState(null);
  const [loading, setLoading] = useState(true);
  const [actionLoading, setActionLoading] = useState(null);
  const [toast, setToast]   = useState(null);

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchData = async () => {
    try {
      const [loansRes, pendingRes] = await Promise.all([
        api.get('/api/loans', { params: { status: 'pending', limit: 10 } }),
        api.get('/api/loans', { params: { limit: 1 } }),
      ]);
      setLoans(loansRes.data.loans);
      setStats({
        pending: loansRes.data.total,
        total:   pendingRes.data.total,
      });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchData(); }, []);

  const handleAction = async (id, action) => {
    setActionLoading(`${id}-${action}`);
    try {
      await api.post(`/api/loans/${id}/${action}`);
      showToast(action === 'issue' ? 'Book issued successfully!' : 'Request rejected.');
      fetchData();
    } catch (err) {
      showToast(err.response?.data?.message || 'Action failed', 'error');
    } finally {
      setActionLoading(null);
    }
  };

  return (
    <div>
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-xl shadow-lg text-sm font-medium
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-green-600 text-white'}`}>
          {toast.msg}
        </div>
      )}

      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Admin Dashboard</h1>
        <div className="flex gap-2">
          <Link to="/admin/books" className="btn-secondary btn-sm">Manage Books</Link>
          <Link to="/admin/loans" className="btn-primary btn-sm">All Loans</Link>
        </div>
      </div>

      {/* Quick stats */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <StatCard label="Pending Requests" value={stats?.pending ?? '—'} icon="⏳" color="bg-yellow-50" />
        <StatCard label="Total Transactions" value={stats?.total ?? '—'} icon="📋" color="bg-blue-50" />
        <StatCard label="Manage Books" value="→" icon="📚" color="bg-purple-50" />
        <StatCard label="View All Loans" value="→" icon="🔍" color="bg-green-50" />
      </div>

      {/* Pending approvals */}
      <div className="card">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Pending Borrow Requests</h2>
          <Link to="/admin/loans?status=pending" className="text-sm text-blue-600 hover:underline">
            View all →
          </Link>
        </div>

        {loading ? (
          <div className="flex justify-center py-8">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-700" />
          </div>
        ) : loans.length === 0 ? (
          <div className="text-center py-8 text-gray-400">
            <div className="text-4xl mb-2">✅</div>
            <p>No pending requests</p>
          </div>
        ) : (
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>User</th>
                  <th>Book</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {loans.map(loan => (
                  <tr key={loan.id}>
                    <td>
                      <p className="font-medium">{loan.user_name}</p>
                      <p className="text-xs text-gray-400">{loan.user_email}</p>
                    </td>
                    <td>
                      <p className="font-medium">{loan.title}</p>
                      <p className="text-xs text-gray-400">{loan.author}</p>
                    </td>
                    <td>
                      <span className={`badge ${STATUS_BADGE[loan.status]}`}>{loan.status}</span>
                    </td>
                    <td>
                      <div className="flex gap-2">
                        <button
                          onClick={() => handleAction(loan.id, 'issue')}
                          disabled={!!actionLoading}
                          className="btn-success btn-sm"
                        >
                          {actionLoading === `${loan.id}-issue` ? '…' : 'Approve'}
                        </button>
                        <button
                          onClick={() => handleAction(loan.id, 'reject')}
                          disabled={!!actionLoading}
                          className="btn-danger btn-sm"
                        >
                          {actionLoading === `${loan.id}-reject` ? '…' : 'Reject'}
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
