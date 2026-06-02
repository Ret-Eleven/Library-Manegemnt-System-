import { useState, useEffect } from 'react';
import api from '../../services/api';

const STATUS_CONFIG = {
  pending:  { label: 'Pending',  bg: 'bg-yellow-100 text-yellow-700', icon: '⏳', bar: 'bg-yellow-400' },
  active:   { label: 'Borrowed', bg: 'bg-blue-100 text-blue-700',     icon: '📖', bar: 'bg-blue-500'  },
  returned: { label: 'Returned', bg: 'bg-gray-100 text-gray-600',     icon: '✅', bar: 'bg-gray-300'  },
  rejected: { label: 'Rejected', bg: 'bg-red-100 text-red-600',       icon: '❌', bar: 'bg-red-400'   },
};

function StatCard({ label, value, icon, color }) {
  return (
    <div className={`bg-white border border-gray-200 rounded-2xl p-4 flex items-center gap-3`}>
      <div className={`w-11 h-11 rounded-xl flex items-center justify-center text-xl flex-shrink-0 ${color}`}>
        {icon}
      </div>
      <div>
        <p className="text-2xl font-extrabold text-gray-900 leading-none">{value}</p>
        <p className="text-xs text-gray-400 mt-0.5">{label}</p>
      </div>
    </div>
  );
}

function LoanCard({ loan }) {
  const cfg     = STATUS_CONFIG[loan.status] || STATUS_CONFIG.returned;
  const overdue = loan.is_overdue;
  const fine    = loan.current_fine || 0;

  return (
    <div className={`bg-white rounded-2xl border overflow-hidden transition-shadow hover:shadow-md
      ${overdue ? 'border-red-200' : 'border-gray-200'}`}>

      {/* Colored top bar */}
      <div className={`h-1 w-full ${overdue ? 'bg-red-400' : cfg.bar}`} />

      <div className="p-4">
        {/* Header row */}
        <div className="flex items-start justify-between gap-2 mb-3">
          <div className="flex-1 min-w-0">
            <p className="font-bold text-gray-900 text-sm leading-snug line-clamp-2">{loan.title}</p>
            <p className="text-xs text-gray-400 mt-0.5">{loan.author}</p>
          </div>
          <div className="flex flex-col items-end gap-1 flex-shrink-0">
            <span className={`badge text-[10px] ${cfg.bg}`}>
              {cfg.icon} {cfg.label}
            </span>
            {overdue && (
              <span className="badge text-[10px] bg-red-100 text-red-600">⚠️ Overdue</span>
            )}
          </div>
        </div>

        {/* Date grid */}
        <div className="grid grid-cols-3 gap-2 text-center">
          {[
            { label: 'Borrowed',  value: loan.borrow_date || '—' },
            { label: 'Due',       value: loan.due_date    || '—', red: overdue },
            { label: 'Returned',  value: loan.return_date || '—' },
          ].map(d => (
            <div key={d.label} className="bg-gray-50 rounded-xl px-2 py-2">
              <p className={`text-xs font-semibold ${d.red ? 'text-red-600' : 'text-gray-800'}`}>
                {d.value}
              </p>
              <p className="text-[10px] text-gray-400 mt-0.5">{d.label}</p>
            </div>
          ))}
        </div>

        {/* Fine */}
        {fine > 0 && (
          <div className={`mt-3 flex items-center justify-between px-3 py-2 rounded-xl text-xs font-semibold
            ${loan.fine_paid ? 'bg-emerald-50 text-emerald-700' : 'bg-red-50 text-red-600'}`}>
            <span>{loan.fine_paid ? '✅ Fine paid' : '⚠️ Fine due'}</span>
            <span>${fine.toFixed(2)}</span>
          </div>
        )}
      </div>
    </div>
  );
}

const FILTERS = [
  { value: '',         label: 'All'      },
  { value: 'active',   label: '📖 Active'  },
  { value: 'pending',  label: '⏳ Pending' },
  { value: 'returned', label: '✅ Returned'},
  { value: 'rejected', label: '❌ Rejected'},
];

export default function BorrowingHistory() {
  const [loans, setLoans]     = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter]   = useState('');

  useEffect(() => {
    api.get('/api/loans/my')
      .then(r => setLoans(r.data))
      .finally(() => setLoading(false));
  }, []);

  const active     = loans.filter(l => l.status === 'active');
  const overdue    = loans.filter(l => l.is_overdue);
  const totalFine  = loans.reduce((s, l) => s + (l.current_fine || 0), 0);
  const borrowed   = loans.filter(l => !['pending', 'rejected'].includes(l.status));

  const filtered   = filter ? loans.filter(l => l.status === filter) : loans;

  if (loading) {
    return (
      <div className="flex items-center justify-center py-24">
        <div className="w-10 h-10 border-[3px] border-blue-200 border-t-blue-600 rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-5">

      {/* Header */}
      <div>
        <h1 className="text-2xl font-extrabold text-gray-900">My Borrowings</h1>
        <p className="text-sm text-gray-400 mt-0.5">{loans.length} total transactions</p>
      </div>

      {/* Stat cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <StatCard label="Currently Borrowed" value={active.length}          icon="📖" color="bg-blue-50"    />
        <StatCard label="Overdue"             value={overdue.length}         icon="⚠️" color="bg-red-50"     />
        <StatCard label="Total Borrowed"      value={borrowed.length}        icon="📚" color="bg-gray-50"    />
        <StatCard label="Pending Fines"       value={`$${totalFine.toFixed(2)}`} icon="💰" color="bg-amber-50" />
      </div>

      {/* Filter pills */}
      <div className="flex flex-wrap gap-2">
        {FILTERS.map(f => (
          <button
            key={f.value}
            onClick={() => setFilter(f.value)}
            className={`px-4 py-1.5 rounded-full text-xs font-semibold border transition-all
              ${filter === f.value
                ? 'bg-blue-600 text-white border-blue-600 shadow-sm'
                : 'bg-white text-gray-500 border-gray-200 hover:border-blue-300 hover:text-blue-600'}`}
          >
            {f.label}
          </button>
        ))}
      </div>

      {/* Empty state */}
      {loans.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <div className="w-20 h-20 bg-gray-100 rounded-3xl flex items-center justify-center text-4xl mb-4">📭</div>
          <p className="font-bold text-gray-700">No borrowing history yet</p>
          <p className="text-sm text-gray-400 mt-1">Browse books to make your first request</p>
        </div>
      ) : filtered.length === 0 ? (
        <div className="text-center py-12 text-gray-400">
          <p className="text-3xl mb-2">🔍</p>
          <p className="text-sm font-medium">No {filter} loans found</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
          {filtered.map(loan => <LoanCard key={loan.id} loan={loan} />)}
        </div>
      )}
    </div>
  );
}
