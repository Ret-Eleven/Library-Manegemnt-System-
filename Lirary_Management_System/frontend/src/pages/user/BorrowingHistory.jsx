import { useState, useEffect } from 'react';
import api from '../../services/api';

const STATUS_BADGE = {
  pending:  'bg-yellow-100 text-yellow-800',
  active:   'bg-green-100 text-green-800',
  returned: 'bg-gray-100 text-gray-700',
  rejected: 'bg-red-100 text-red-700',
};

const STATUS_LABEL = {
  pending:  '⏳ Pending approval',
  active:   '✅ Borrowed',
  returned: '📥 Returned',
  rejected: '❌ Rejected',
};

export default function BorrowingHistory() {
  const [loans, setLoans]   = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get('/api/loans/my')
      .then(r => setLoans(r.data))
      .finally(() => setLoading(false));
  }, []);

  const active   = loans.filter(l => l.status === 'active');
  const overdue  = loans.filter(l => l.is_overdue);
  const totalFine = loans.reduce((sum, l) => sum + (l.current_fine || 0), 0);

  if (loading) {
    return (
      <div className="flex justify-center py-16">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-700" />
      </div>
    );
  }

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">My Borrowings</h1>
        <p className="text-gray-500 mt-1 text-sm">{loans.length} total transactions</p>
      </div>

      {/* Summary cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-6">
        {[
          { label: 'Currently Borrowed', value: active.length,   color: 'text-blue-700',  bg: 'bg-blue-50'   },
          { label: 'Overdue',            value: overdue.length,  color: 'text-red-700',   bg: 'bg-red-50'    },
          { label: 'Total Borrowed',     value: loans.filter(l => l.status !== 'pending' && l.status !== 'rejected').length, color: 'text-gray-700', bg: 'bg-gray-50' },
          { label: 'Pending Fines ($)',  value: `$${totalFine.toFixed(2)}`, color: 'text-amber-700', bg: 'bg-amber-50' },
        ].map(c => (
          <div key={c.label} className={`card ${c.bg} border-0 text-center`}>
            <p className={`text-2xl font-bold ${c.color}`}>{c.value}</p>
            <p className="text-xs text-gray-500 mt-0.5">{c.label}</p>
          </div>
        ))}
      </div>

      {loans.length === 0 ? (
        <div className="text-center py-16 text-gray-400">
          <div className="text-5xl mb-3">📭</div>
          <p className="font-medium">No borrowing history yet</p>
          <p className="text-sm mt-1">Browse books to make your first request</p>
        </div>
      ) : (
        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>Book</th>
                <th>Status</th>
                <th>Borrow Date</th>
                <th>Due Date</th>
                <th>Return Date</th>
                <th>Fine</th>
              </tr>
            </thead>
            <tbody>
              {loans.map(loan => (
                <tr key={loan.id}>
                  <td>
                    <p className="font-medium text-gray-900">{loan.title}</p>
                    <p className="text-xs text-gray-400">{loan.author}</p>
                  </td>
                  <td>
                    <span className={`badge ${STATUS_BADGE[loan.status]}`}>
                      {STATUS_LABEL[loan.status]}
                    </span>
                    {loan.is_overdue ? (
                      <span className="badge bg-red-100 text-red-700 ml-1">Overdue</span>
                    ) : null}
                  </td>
                  <td className="text-gray-500">{loan.borrow_date || '—'}</td>
                  <td className={loan.is_overdue ? 'text-red-600 font-medium' : 'text-gray-500'}>
                    {loan.due_date || '—'}
                  </td>
                  <td className="text-gray-500">{loan.return_date || '—'}</td>
                  <td>
                    {(loan.current_fine || 0) > 0 ? (
                      <span className={`font-semibold ${loan.fine_paid ? 'text-green-600' : 'text-red-600'}`}>
                        ${(loan.current_fine).toFixed(2)}
                        {loan.fine_paid && <span className="text-xs ml-1">(paid)</span>}
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
  );
}
