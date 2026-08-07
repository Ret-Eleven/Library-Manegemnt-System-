import { useState, useEffect, useCallback } from 'react';
import api from '../../services/api';
import { AlertTriangle } from 'lucide-react';

const STATUS_BADGE = {
  active:   'bg-green-100 text-green-800',
  returned: 'bg-gray-100 text-gray-700',
  rejected: 'bg-red-100 text-red-700',
  pending:  'bg-yellow-100 text-yellow-800',
};

const STATUS_OPTIONS = [
  { value: 'active',   label: 'Active' },
  { value: 'returned', label: 'Returned' },
  { value: 'rejected', label: 'Rejected' },
  { value: 'pending',  label: 'Pending' },
];

export default function ApprovalHistory() {
  const [loans, setLoans]     = useState([]);
  const [total, setTotal]     = useState(0);
  const [pages, setPages]     = useState(1);
  const [page, setPage]       = useState(1);
  const [status, setStatus]   = useState('active');
  const [loading, setLoading] = useState(true);

  const fetchLoans = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: 20 };
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

  const handleStatusChange = (val) => {
    setStatus(val);
    setPage(1);
  };

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Book Approval History</h1>
        <p className="text-gray-500 text-sm mt-1">View which admin approved each book loan request</p>
      </div>

      {/* Filters */}
      <div className="card mb-4 flex flex-wrap items-center gap-3">
        <span className="text-sm font-medium text-gray-700">Filter by status:</span>
        <div className="flex gap-2 flex-wrap">
          <button
            onClick={() => handleStatusChange('')}
            className={`px-3 py-1 rounded-full text-sm font-medium border transition-colors
              ${status === '' ? 'bg-blue-600 text-white border-blue-600' : 'bg-white text-gray-600 border-gray-300 hover:border-blue-400'}`}
          >
            All
          </button>
          {STATUS_OPTIONS.map(opt => (
            <button
              key={opt.value}
              onClick={() => handleStatusChange(opt.value)}
              className={`px-3 py-1 rounded-full text-sm font-medium border transition-colors
                ${status === opt.value ? 'bg-blue-600 text-white border-blue-600' : 'bg-white text-gray-600 border-gray-300 hover:border-blue-400'}`}
            >
              {opt.label}
            </button>
          ))}
        </div>
        <span className="ml-auto text-sm text-gray-400">{total} record{total !== 1 ? 's' : ''}</span>
      </div>

      {/* Table */}
      <div className="card overflow-hidden p-0">
        {loading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-700" />
          </div>
        ) : loans.length === 0 ? (
          <p className="text-center text-gray-400 py-12">No records found.</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Book</th>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Borrower</th>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Approved By</th>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Borrow Date</th>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Due Date</th>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Status</th>
                  <th className="text-left px-4 py-3 font-semibold text-gray-700">Fine</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {loans.map(loan => (
                  <tr key={loan.id} className="hover:bg-gray-50">
                    <td className="px-4 py-3">
                      <p className="font-medium text-gray-900 truncate max-w-[180px]">{loan.title}</p>
                      <p className="text-xs text-gray-400 truncate max-w-[180px]">{loan.author}</p>
                    </td>
                    <td className="px-4 py-3">
                      <p className="font-medium text-gray-900">{loan.user_name || '—'}</p>
                      <p className="text-xs text-gray-400">{loan.user_email || ''}</p>
                    </td>
                    <td className="px-4 py-3">
                      {loan.issued_by_name ? (
                        <span className="inline-flex items-center gap-1.5">
                          <span className="w-6 h-6 rounded-full bg-blue-100 text-blue-700 flex items-center justify-center text-xs font-bold flex-shrink-0">
                            {loan.issued_by_name.charAt(0).toUpperCase()}
                          </span>
                          <span className="text-gray-900">{loan.issued_by_name}</span>
                        </span>
                      ) : (
                        <span className="text-gray-400 italic text-xs">Not approved yet</span>
                      )}
                    </td>
                    <td className="px-4 py-3 text-gray-700">{loan.borrow_date || '—'}</td>
                    <td className="px-4 py-3 text-gray-700">
                      {loan.due_date ? (
                        <span className={loan.is_overdue ? 'text-red-600 font-medium' : ''}>
                          {loan.due_date}{loan.is_overdue && <AlertTriangle className="w-3 h-3 text-red-500 inline-block ml-1" />}
                        </span>
                      ) : '—'}
                    </td>
                    <td className="px-4 py-3">
                      <span className={`badge ${STATUS_BADGE[loan.status] || 'bg-gray-100 text-gray-700'}`}>
                        {loan.status}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-gray-700">
                      {loan.current_fine > 0 ? (
                        <span className={loan.fine_paid ? 'text-gray-400 line-through' : 'text-red-600 font-medium'}>
                          ${Number(loan.current_fine).toFixed(2)}
                        </span>
                      ) : '—'}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Pagination */}
      {pages > 1 && (
        <div className="flex justify-center gap-2 mt-4">
          <button
            className="btn-secondary text-sm"
            onClick={() => setPage(p => Math.max(1, p - 1))}
            disabled={page === 1}
          >
            Previous
          </button>
          <span className="px-3 py-1.5 text-sm text-gray-600">
            Page {page} of {pages}
          </span>
          <button
            className="btn-secondary text-sm"
            onClick={() => setPage(p => Math.min(pages, p + 1))}
            disabled={page === pages}
          >
            Next
          </button>
        </div>
      )}
    </div>
  );
}
