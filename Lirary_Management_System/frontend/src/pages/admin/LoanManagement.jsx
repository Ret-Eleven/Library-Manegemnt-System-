import { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import api from '../../services/api';

const STATUS_BADGE = {
  pending:  'bg-yellow-100 text-yellow-800',
  active:   'bg-green-100 text-green-800',
  returned: 'bg-gray-100 text-gray-700',
  rejected: 'bg-red-100 text-red-700',
};

export default function LoanManagement() {
  const [searchParams]        = useSearchParams();
  const [loans, setLoans]     = useState([]);
  const [total, setTotal]     = useState(0);
  const [pages, setPages]     = useState(1);
  const [page, setPage]       = useState(1);
  const [status, setStatus]   = useState(searchParams.get('status') || '');
  const [loading, setLoading] = useState(true);
  const [actionLoading, setActionLoading] = useState(null);
  const [toast, setToast]     = useState(null);

  const LIMIT = 20;

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchLoans = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: LIMIT };
      if (status) params.status = status;
      const { data } = await api.get('/api/loans', { params });
      setLoans(data.loans);
      setTotal(data.total);
      setPages(data.pages);
    } finally {
      setLoading(false);
    }
  }, [page, status]);

  useEffect(() => { fetchLoans(); }, [fetchLoans]);

  const handleAction = async (id, action) => {
    setActionLoading(`${id}-${action}`);
    try {
      const { data } = await api.post(`/api/loans/${id}/${action}`);
      const msgs = {
        issue:      `Book issued! Due date: ${data.due_date}`,
        return:     `Book returned. Fine: $${data.fine_amount?.toFixed(2) ?? '0.00'}`,
        reject:     'Request rejected.',
        'pay-fine': 'Fine marked as paid.',
      };
      showToast(msgs[action] || 'Done.');
      fetchLoans();
    } catch (err) {
      showToast(err.response?.data?.message || 'Action failed', 'error');
    } finally {
      setActionLoading(null);
    }
  };

  const STATUS_FILTERS = ['', 'pending', 'active', 'returned', 'rejected'];

  return (
    <div>
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-xl shadow-lg text-sm font-medium
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-green-600 text-white'}`}>
          {toast.msg}
        </div>
      )}

      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Loans & Requests</h1>
        <p className="text-gray-500 text-sm mt-1">{total} records</p>
      </div>

      {/* Filters */}
      <div className="flex flex-wrap gap-2 mb-5">
        {STATUS_FILTERS.map(s => (
          <button
            key={s || 'all'}
            onClick={() => { setStatus(s); setPage(1); }}
            className={`btn btn-sm capitalize ${status === s ? 'btn-primary' : 'btn-secondary'}`}
          >
            {s || 'All'}
          </button>
        ))}
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
                  <th>#</th>
                  <th>User</th>
                  <th>Book</th>
                  <th>Status</th>
                  <th>Borrow Date</th>
                  <th>Due Date</th>
                  <th>Fine</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {loans.length === 0 ? (
                  <tr><td colSpan={8} className="text-center py-8 text-gray-400">No records found</td></tr>
                ) : loans.map(loan => (
                  <tr key={loan.id}>
                    <td className="text-gray-400 text-xs">{loan.id}</td>
                    <td>
                      <p className="font-medium text-sm">{loan.user_name}</p>
                      <p className="text-xs text-gray-400">{loan.user_email}</p>
                    </td>
                    <td>
                      <p className="font-medium text-sm">{loan.title}</p>
                      <p className="text-xs text-gray-400">{loan.author}</p>
                    </td>
                    <td>
                      <span className={`badge ${STATUS_BADGE[loan.status]}`}>{loan.status}</span>
                      {loan.is_overdue ? (
                        <span className="badge bg-red-100 text-red-700 ml-1">Overdue</span>
                      ) : null}
                    </td>
                    <td className="text-gray-500 text-sm">{loan.borrow_date || '—'}</td>
                    <td className={`text-sm ${loan.is_overdue ? 'text-red-600 font-medium' : 'text-gray-500'}`}>
                      {loan.due_date || '—'}
                    </td>
                    <td>
                      {(loan.current_fine || 0) > 0 ? (
                        <span className={`text-sm font-semibold ${loan.fine_paid ? 'text-green-600' : 'text-red-600'}`}>
                          ${loan.current_fine.toFixed(2)}
                          {loan.fine_paid && <span className="text-xs ml-1">(paid)</span>}
                        </span>
                      ) : '—'}
                    </td>
                    <td>
                      <div className="flex flex-wrap gap-1.5">
                        {loan.status === 'pending' && (
                          <>
                            <button
                              onClick={() => handleAction(loan.id, 'issue')}
                              disabled={!!actionLoading}
                              className="btn-success btn-sm"
                            >
                              {actionLoading === `${loan.id}-issue` ? '…' : 'Issue'}
                            </button>
                            <button
                              onClick={() => handleAction(loan.id, 'reject')}
                              disabled={!!actionLoading}
                              className="btn-danger btn-sm"
                            >
                              {actionLoading === `${loan.id}-reject` ? '…' : 'Reject'}
                            </button>
                          </>
                        )}
                        {loan.status === 'active' && (
                          <button
                            onClick={() => handleAction(loan.id, 'return')}
                            disabled={!!actionLoading}
                            className="btn-warning btn-sm"
                          >
                            {actionLoading === `${loan.id}-return` ? '…' : 'Return'}
                          </button>
                        )}
                        {loan.status === 'returned' && (loan.current_fine || 0) > 0 && !loan.fine_paid && (
                          <button
                            onClick={() => handleAction(loan.id, 'pay-fine')}
                            disabled={!!actionLoading}
                            className="btn-success btn-sm"
                          >
                            {actionLoading === `${loan.id}-pay-fine` ? '…' : 'Mark Paid'}
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
    </div>
  );
}
