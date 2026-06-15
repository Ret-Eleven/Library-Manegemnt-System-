import { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import api from '../../services/api';

/* ── helpers ─────────────────────────────────────────────────── */
const fmt = (d) =>
  d ? new Date(d).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' }) : '—';

const daysUntil = (d) =>
  d ? Math.ceil((new Date(d) - new Date()) / 86400000) : null;

/* ── Status config ───────────────────────────────────────────── */
const STATUS_CFG = {
  active:   { label: 'Active',   dot: 'bg-emerald-500', badge: 'bg-emerald-50 border-emerald-200 text-emerald-700' },
  overdue:  { label: 'Overdue',  dot: 'bg-red-500',     badge: 'bg-red-50 border-red-200 text-red-600'             },
  pending:  { label: 'Pending',  dot: 'bg-amber-400',   badge: 'bg-amber-50 border-amber-200 text-amber-700'       },
  returned: { label: 'Returned', dot: 'bg-gray-400',    badge: 'bg-gray-50 border-gray-200 text-gray-500'          },
  rejected: { label: 'Cancelled',dot: 'bg-gray-300',    badge: 'bg-gray-50 border-gray-200 text-gray-400'          },
};
const getStatus = (loan) => (loan.is_overdue ? 'overdue' : loan.status);

/* ── Book cover placeholder ──────────────────────────────────── */
const COVER_COLORS = [
  'from-blue-500 to-indigo-600', 'from-violet-500 to-purple-700',
  'from-emerald-500 to-teal-600','from-orange-400 to-red-500',
  'from-pink-400 to-rose-600',   'from-cyan-400 to-blue-600',
  'from-amber-400 to-orange-500','from-teal-500 to-green-600',
];
const coverColor = (id) => COVER_COLORS[id % COVER_COLORS.length];

function BookCover({ loanId, title }) {
  const initials = title ? title.split(' ').map(w => w[0]).join('').slice(0, 2).toUpperCase() : '??';
  return (
    <div className={`w-12 h-16 rounded-lg bg-gradient-to-br ${coverColor(loanId)}
      flex items-center justify-center text-white text-sm font-extrabold flex-shrink-0 shadow-sm`}>
      {initials}
    </div>
  );
}

/* ── Stat card ───────────────────────────────────────────────── */
function StatCard({ icon, value, label, sub, color = 'bg-blue-50 text-blue-600' }) {
  return (
    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-4 flex items-center gap-3 min-w-0 flex-1">
      <div className={`w-10 h-10 ${color} rounded-xl flex items-center justify-center text-lg flex-shrink-0`}>
        {icon}
      </div>
      <div className="min-w-0">
        <p className="text-xl font-extrabold text-gray-900 leading-none">{value}</p>
        <p className="text-xs font-semibold text-gray-700 mt-0.5 truncate">{label}</p>
        {sub && <p className="text-[11px] text-gray-400 truncate">{sub}</p>}
      </div>
    </div>
  );
}

/* ── Loan detail modal ───────────────────────────────────────── */
function LoanModal({ loan, onClose, onCancel }) {
  const [cancelling, setCancelling] = useState(false);
  const status = getStatus(loan);
  const cfg    = STATUS_CFG[status];
  const days   = daysUntil(loan.due_date);

  const handleCancel = async () => {
    setCancelling(true);
    await onCancel(loan.id);
    setCancelling(false);
    onClose();
  };

  const steps = [
    { key: 'pending',  label: 'Requested',   date: loan.created_at, icon: '📋' },
    { key: 'active',   label: 'Issued',       date: loan.borrow_date, icon: '📖' },
    { key: 'returned', label: 'Returned',     date: loan.return_date, icon: '✅' },
  ];
  const statusOrder = ['pending', 'active', 'returned'];
  const currentIdx  = loan.status === 'rejected'
    ? -1
    : statusOrder.indexOf(loan.status === 'active' ? 'active' : loan.status) ?? 0;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
      onClick={onClose}>
      <div className="bg-white rounded-3xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto"
        onClick={e => e.stopPropagation()}>

        {/* Header */}
        <div className="flex items-start gap-4 p-6 border-b border-gray-100">
          <BookCover loanId={loan.id} title={loan.title} />
          <div className="flex-1 min-w-0">
            <p className="font-extrabold text-gray-900 text-lg leading-snug">{loan.title}</p>
            <p className="text-sm text-gray-500 mt-0.5">{loan.author || 'Unknown Author'}</p>
            {loan.isbn && <p className="text-xs text-gray-400 font-mono mt-1">ISBN: {loan.isbn}</p>}
          </div>
          <button onClick={onClose}
            className="w-8 h-8 rounded-full bg-gray-100 hover:bg-gray-200 flex items-center justify-center text-gray-500 transition-colors flex-shrink-0">
            ✕
          </button>
        </div>

        {/* Status badge + due warning */}
        <div className="px-6 py-4 flex flex-wrap items-center gap-3 border-b border-gray-50">
          <span className={`inline-flex items-center gap-1.5 border text-xs font-bold px-3 py-1.5 rounded-full ${cfg.badge}`}>
            <span className={`w-1.5 h-1.5 rounded-full ${cfg.dot}`}/>
            {cfg.label}
          </span>
          <span className="text-xs text-gray-400 font-mono">Loan #{loan.id}</span>
          {status === 'active' && days !== null && days >= 0 && days <= 3 && (
            <span className="text-xs bg-amber-100 text-amber-700 font-bold px-3 py-1.5 rounded-full">
              ⏰ Due {days === 0 ? 'today' : `in ${days} day${days > 1 ? 's' : ''}`}
            </span>
          )}
          {status === 'overdue' && (
            <span className="text-xs bg-red-100 text-red-600 font-bold px-3 py-1.5 rounded-full">
              ⚠️ {Math.abs(days || 0)} day{Math.abs(days || 0) !== 1 ? 's' : ''} overdue
            </span>
          )}
        </div>

        {/* Timeline */}
        <div className="px-6 py-5 border-b border-gray-50">
          <p className="text-xs font-bold text-gray-400 uppercase tracking-widest mb-4">Timeline</p>
          {loan.status === 'rejected' ? (
            <div className="flex items-center gap-3 bg-gray-50 rounded-xl p-3">
              <span className="text-xl">❌</span>
              <div>
                <p className="text-sm font-bold text-gray-600">Request Cancelled</p>
                <p className="text-xs text-gray-400">{fmt(loan.created_at)}</p>
              </div>
            </div>
          ) : (
            <div className="flex items-start gap-0">
              {steps.map((step, i) => {
                const done    = i <= currentIdx;
                const current = i === currentIdx;
                const last    = i === steps.length - 1;
                return (
                  <div key={step.key} className="flex flex-col items-center flex-1">
                    <div className="flex items-center w-full">
                      <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm border-2 flex-shrink-0
                        ${done
                          ? current ? 'border-blue-500 bg-blue-500 text-white' : 'border-emerald-500 bg-emerald-500 text-white'
                          : 'border-gray-200 bg-white text-gray-300'}`}>
                        {done ? (current ? step.icon : '✓') : step.icon}
                      </div>
                      {!last && (
                        <div className={`flex-1 h-0.5 mx-1 ${i < currentIdx ? 'bg-emerald-400' : 'bg-gray-200'}`}/>
                      )}
                    </div>
                    <div className="mt-2 text-center px-1">
                      <p className={`text-[11px] font-bold ${done ? 'text-gray-800' : 'text-gray-300'}`}>{step.label}</p>
                      <p className={`text-[10px] mt-0.5 ${done && step.date ? 'text-gray-500' : 'text-gray-300'}`}>
                        {step.date ? fmt(step.date) : '—'}
                      </p>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        {/* Details grid */}
        <div className="px-6 py-5 grid grid-cols-2 gap-4 border-b border-gray-50">
          {[
            { label: 'Requested On', value: fmt(loan.created_at) },
            { label: 'Borrow Date',  value: fmt(loan.borrow_date) },
            { label: 'Due Date',     value: fmt(loan.due_date),   urgent: status === 'overdue' },
            { label: 'Returned On',  value: fmt(loan.return_date) },
          ].map(item => (
            <div key={item.label} className="bg-gray-50 rounded-xl p-3">
              <p className="text-[11px] text-gray-400 font-semibold uppercase tracking-wider">{item.label}</p>
              <p className={`text-sm font-bold mt-0.5 ${item.urgent ? 'text-red-500' : 'text-gray-900'}`}>
                {item.value}
              </p>
            </div>
          ))}
        </div>

        {/* Fine section */}
        {(loan.current_fine > 0 || loan.fine_amount > 0) && (
          <div className={`mx-6 my-4 rounded-2xl p-4 border
            ${loan.fine_paid ? 'bg-gray-50 border-gray-200' : 'bg-red-50 border-red-200'}`}>
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-bold text-gray-500 uppercase tracking-wider">
                  {loan.fine_paid ? 'Fine Paid' : 'Outstanding Fine'}
                </p>
                <p className={`text-2xl font-extrabold mt-0.5 ${loan.fine_paid ? 'text-gray-600' : 'text-red-600'}`}>
                  ${(loan.current_fine || loan.fine_amount || 0).toFixed(2)}
                </p>
              </div>
              <span className={`text-2xl ${loan.fine_paid ? '✅' : '⚠️'}`}>
                {loan.fine_paid ? '✅' : '⚠️'}
              </span>
            </div>
            {!loan.fine_paid && (
              <p className="text-xs text-red-500 mt-2">
                Please visit the library desk to settle this fine.
              </p>
            )}
          </div>
        )}

        {/* Actions */}
        <div className="px-6 pb-6 pt-2 flex gap-3">
          {loan.status === 'pending' && (
            <button
              onClick={handleCancel}
              disabled={cancelling}
              className="flex-1 bg-red-50 hover:bg-red-100 border border-red-200 text-red-600 text-sm font-bold
                py-3 rounded-xl transition-colors disabled:opacity-60">
              {cancelling ? 'Cancelling…' : 'Cancel Request'}
            </button>
          )}
          {loan.status === 'active' && (
            <div className="flex-1 bg-blue-50 border border-blue-200 text-blue-700 text-xs font-semibold
              py-3 px-4 rounded-xl text-center leading-relaxed">
              To return this book, visit the library desk with your student ID.
            </div>
          )}
          <button onClick={onClose}
            className="flex-1 bg-gray-900 hover:bg-gray-700 text-white text-sm font-bold py-3 rounded-xl transition-colors">
            Close
          </button>
        </div>
      </div>
    </div>
  );
}

/* ── Loan card ───────────────────────────────────────────────── */
function LoanCard({ loan, onSelect, onCancel }) {
  const [cancelling, setCancelling] = useState(false);
  const status = getStatus(loan);
  const cfg    = STATUS_CFG[status];
  const days   = daysUntil(loan.due_date);

  const handleCancel = async (e) => {
    e.stopPropagation();
    setCancelling(true);
    await onCancel(loan.id);
    setCancelling(false);
  };

  return (
    <div
      onClick={() => onSelect(loan)}
      className={`bg-white rounded-2xl border shadow-sm p-4 flex items-center gap-4
        hover:shadow-md hover:-translate-y-0.5 transition-all cursor-pointer
        ${status === 'overdue' ? 'border-red-200' :
          status === 'active'  ? 'border-emerald-100' :
          status === 'pending' ? 'border-amber-100' : 'border-gray-100'}`}
    >
      <BookCover loanId={loan.id} title={loan.title} />

      {/* Info */}
      <div className="flex-1 min-w-0">
        <p className="font-bold text-gray-900 text-sm truncate">{loan.title}</p>
        <p className="text-xs text-gray-400 truncate mt-0.5">{loan.author || 'Unknown Author'}</p>

        {/* Date row */}
        <div className="flex items-center gap-3 mt-2 flex-wrap">
          {loan.borrow_date && (
            <span className="text-[11px] text-gray-400">
              <span className="font-semibold text-gray-600">Borrowed:</span> {fmt(loan.borrow_date)}
            </span>
          )}
          {loan.due_date && loan.status !== 'returned' && (
            <span className={`text-[11px] font-semibold
              ${status === 'overdue' ? 'text-red-500' :
                days !== null && days <= 3 ? 'text-amber-600' : 'text-gray-400'}`}>
              {status === 'overdue' ? `⚠️ ${Math.abs(days || 0)}d overdue` :
               days !== null && days <= 3 ? `⏰ due in ${days}d` : `Due: ${fmt(loan.due_date)}`}
            </span>
          )}
          {loan.return_date && (
            <span className="text-[11px] text-gray-400">
              <span className="font-semibold text-gray-600">Returned:</span> {fmt(loan.return_date)}
            </span>
          )}
          {!loan.borrow_date && !loan.due_date && (
            <span className="text-[11px] text-gray-400">Requested: {fmt(loan.created_at)}</span>
          )}
        </div>
      </div>

      {/* Status + fine */}
      <div className="flex flex-col items-end gap-2 flex-shrink-0">
        <span className={`inline-flex items-center gap-1.5 border text-[11px] font-bold px-2.5 py-1 rounded-full ${cfg.badge}`}>
          <span className={`w-1.5 h-1.5 rounded-full ${cfg.dot}`}/>
          {cfg.label}
        </span>

        {(loan.current_fine > 0) && !loan.fine_paid && (
          <span className="text-[11px] font-bold text-red-500 bg-red-50 border border-red-200 px-2 py-0.5 rounded-full">
            Fine: ${loan.current_fine.toFixed(2)}
          </span>
        )}

        {loan.status === 'pending' && (
          <button
            onClick={handleCancel}
            disabled={cancelling}
            className="text-[11px] font-bold text-red-500 hover:text-red-700 bg-red-50 hover:bg-red-100
              border border-red-200 px-2 py-1 rounded-lg transition-colors disabled:opacity-50"
          >
            {cancelling ? '…' : 'Cancel'}
          </button>
        )}
      </div>

      {/* Chevron */}
      <svg className="w-4 h-4 text-gray-300 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
        <path strokeLinecap="round" d="m8.25 4.5 7.5 7.5-7.5 7.5"/>
      </svg>
    </div>
  );
}

/* ── Main page ───────────────────────────────────────────────── */
export default function BorrowingHistory() {
  const [loans,      setLoans]      = useState([]);
  const [loading,    setLoading]    = useState(true);
  const [filter,     setFilter]     = useState('all');
  const [search,     setSearch]     = useState('');
  const [sortBy,     setSortBy]     = useState('newest');
  const [selected,   setSelected]   = useState(null);
  const [toast,      setToast]      = useState(null);

  const showToast = (msg, type = 'info') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 4000);
  };

  const load = useCallback(() => {
    setLoading(true);
    api.get('/api/loans/my')
      .then(r => setLoans(r.data))
      .catch(() => showToast('Failed to load loans', 'error'))
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => { load(); }, [load]);

  const handleCancel = async (id) => {
    try {
      await api.post(`/api/loans/${id}/cancel`);
      showToast('Request cancelled successfully', 'success');
      load();
    } catch (err) {
      showToast(err.response?.data?.message || 'Failed to cancel request', 'error');
    }
  };

  /* ── Stats ── */
  const total    = loans.length;
  const active   = loans.filter(l => l.status === 'active' && !l.is_overdue).length;
  const overdue  = loans.filter(l => l.is_overdue).length;
  const returned = loans.filter(l => l.status === 'returned').length;
  const pending  = loans.filter(l => l.status === 'pending').length;
  const totalFine = loans.reduce((s, l) => s + (l.current_fine || l.fine_amount || 0), 0);
  const unpaidFine = loans.filter(l => !l.fine_paid).reduce((s, l) => s + (l.current_fine || l.fine_amount || 0), 0);

  /* ── Filter + sort ── */
  const filtered = loans
    .filter(l => {
      const s = getStatus(l);
      const ok =
        filter === 'all'      ? true :
        filter === 'active'   ? s === 'active' :
        filter === 'overdue'  ? s === 'overdue' :
        filter === 'pending'  ? s === 'pending' :
        filter === 'returned' ? s === 'returned' :
        filter === 'rejected' ? s === 'rejected' : true;
      const q = search.toLowerCase();
      const ms = !search || l.title?.toLowerCase().includes(q) || l.author?.toLowerCase().includes(q);
      return ok && ms;
    })
    .sort((a, b) => {
      if (sortBy === 'newest')   return b.id - a.id;
      if (sortBy === 'oldest')   return a.id - b.id;
      if (sortBy === 'due_asc')  return new Date(a.due_date || 0) - new Date(b.due_date || 0);
      if (sortBy === 'due_desc') return new Date(b.due_date || 0) - new Date(a.due_date || 0);
      return 0;
    });

  const FILTERS = [
    { key: 'all',      label: 'All',        count: total    },
    { key: 'active',   label: '📖 Active',  count: active   },
    { key: 'overdue',  label: '⚠️ Overdue', count: overdue  },
    { key: 'pending',  label: '⏳ Pending', count: pending  },
    { key: 'returned', label: '✅ Returned', count: returned },
  ];

  return (
    <div className="max-w-4xl mx-auto">

      {/* ── Toast ── */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type === 'success' ? 'bg-emerald-600 text-white' :
            toast.type === 'error'   ? 'bg-red-600 text-white' : 'bg-slate-900 text-white'}`}>
          {toast.type === 'success' ? '✓' : toast.type === 'error' ? '✕' : 'ℹ️'}
          {toast.msg}
        </div>
      )}

      {/* ── Detail modal ── */}
      {selected && (
        <LoanModal
          loan={selected}
          onClose={() => setSelected(null)}
          onCancel={handleCancel}
        />
      )}

      {/* ── Page header ── */}
      <div className="flex flex-wrap items-start justify-between gap-3 mb-6">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">Borrowing History</h1>
          <p className="text-sm text-gray-400 mt-0.5">Your complete borrowing record</p>
        </div>
        <Link to="/user/catalog"
          className="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-500 text-white text-sm font-bold
            px-5 py-2.5 rounded-xl shadow-md shadow-blue-200 transition-colors">
          + Borrow a Book
        </Link>
      </div>

      {/* ── Stat cards ── */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6">
        <StatCard icon="📚" value={loading ? '…' : total}    label="Total Borrowed" color="bg-blue-50 text-blue-600" />
        <StatCard icon="📖" value={loading ? '…' : active}   label="Active"         color="bg-emerald-50 text-emerald-600" />
        <StatCard icon="⚠️" value={loading ? '…' : overdue}  label="Overdue"
          sub={overdue > 0 ? 'Needs attention' : 'All good!'}
          color="bg-red-50 text-red-500" />
        <StatCard icon="✅" value={loading ? '…' : returned} label="Returned"       color="bg-gray-100 text-gray-500" />
      </div>

      {/* ── Fine warning banner ── */}
      {!loading && unpaidFine > 0 && (
        <div className="flex items-start gap-4 bg-red-50 border border-red-200 rounded-2xl p-4 mb-6">
          <span className="text-2xl">💸</span>
          <div className="flex-1">
            <p className="font-extrabold text-red-700 text-sm">Outstanding Fine: ${unpaidFine.toFixed(2)}</p>
            <p className="text-xs text-red-500 mt-0.5">
              You have unpaid fines on overdue books. Please visit the library desk to settle your balance.
            </p>
          </div>
        </div>
      )}

      {/* ── Controls: filter pills + search + sort ── */}
      <div className="flex flex-wrap items-center gap-3 mb-5">
        {/* Filter pills */}
        <div className="flex gap-1.5 flex-wrap">
          {FILTERS.map(f => (
            <button key={f.key} onClick={() => setFilter(f.key)}
              className={`inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full text-xs font-bold border transition-all
                ${filter === f.key
                  ? 'bg-slate-900 text-white border-slate-900 shadow-sm'
                  : 'bg-white text-gray-500 border-gray-200 hover:border-gray-400 hover:text-gray-700'}`}>
              {f.label}
              {f.count > 0 && (
                <span className={`text-[10px] rounded-full px-1.5 py-0.5 font-extrabold
                  ${filter === f.key ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-500'}`}>
                  {f.count}
                </span>
              )}
            </button>
          ))}
        </div>

        <div className="flex items-center gap-2 ml-auto">
          {/* Search */}
          <div className="flex items-center gap-2 bg-white border border-gray-200 rounded-xl px-3 py-2 shadow-sm
            focus-within:ring-2 focus-within:ring-blue-400 transition-all">
            <svg className="w-3.5 h-3.5 text-gray-400" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input value={search} onChange={e => setSearch(e.target.value)}
              placeholder="Title, author…"
              className="text-xs text-gray-700 placeholder-gray-400 outline-none bg-transparent w-28 sm:w-36"/>
            {search && (
              <button onClick={() => setSearch('')} className="text-gray-300 hover:text-gray-500">✕</button>
            )}
          </div>

          {/* Sort */}
          <select value={sortBy} onChange={e => setSortBy(e.target.value)}
            className="bg-white border border-gray-200 rounded-xl px-3 py-2 text-xs text-gray-600 font-semibold
              shadow-sm outline-none focus:ring-2 focus:ring-blue-400 cursor-pointer">
            <option value="newest">Newest First</option>
            <option value="oldest">Oldest First</option>
            <option value="due_asc">Due Date ↑</option>
            <option value="due_desc">Due Date ↓</option>
          </select>
        </div>
      </div>

      {/* ── Results header ── */}
      <div className="flex items-center justify-between mb-3">
        <p className="text-sm font-bold text-gray-700">
          {loading ? 'Loading…' : `${filtered.length} record${filtered.length !== 1 ? 's' : ''}`}
        </p>
        {(filter !== 'all' || search) && (
          <button onClick={() => { setFilter('all'); setSearch(''); }}
            className="text-xs text-blue-600 hover:text-blue-500 font-semibold transition-colors">
            Clear filters
          </button>
        )}
      </div>

      {/* ── List ── */}
      {loading ? (
        <div className="space-y-3">
          {[1, 2, 3, 4].map(i => (
            <div key={i} className="h-[76px] bg-gray-100 rounded-2xl animate-pulse"/>
          ))}
        </div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 bg-white rounded-2xl border border-gray-100">
          <div className="w-16 h-16 bg-gray-100 rounded-2xl flex items-center justify-center text-3xl mb-3">
            {filter === 'overdue' ? '⚠️' : filter === 'returned' ? '✅' : '📭'}
          </div>
          <p className="font-bold text-gray-700 text-base">No records found</p>
          <p className="text-sm text-gray-400 mt-1">
            {search ? `No loans match "${search}"` :
             filter !== 'all' ? `You have no ${filter} loans` :
             'You have not borrowed any books yet.'}
          </p>
          {filter === 'all' && !search && (
            <Link to="/user/catalog"
              className="mt-5 bg-blue-600 hover:bg-blue-500 text-white text-sm font-bold px-6 py-2.5 rounded-xl shadow-md shadow-blue-200 transition-colors">
              Browse Catalog →
            </Link>
          )}
        </div>
      ) : (
        <div className="space-y-2.5">
          {filtered.map(loan => (
            <LoanCard
              key={loan.id}
              loan={loan}
              onSelect={setSelected}
              onCancel={handleCancel}
            />
          ))}
        </div>
      )}

      {/* ── Summary footer ── */}
      {!loading && loans.length > 0 && (
        <div className="mt-6 bg-white rounded-2xl border border-gray-100 shadow-sm p-5">
          <p className="text-xs font-bold text-gray-400 uppercase tracking-widest mb-4">All-time Summary</p>
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
            {[
              { label: 'Books Borrowed', value: total   },
              { label: 'Books Returned', value: returned },
              { label: 'Active Loans',   value: active + overdue },
              { label: 'Total Fines',    value: `$${totalFine.toFixed(2)}` },
            ].map(s => (
              <div key={s.label} className="bg-gray-50 rounded-xl p-3">
                <p className="text-xl font-extrabold text-gray-900">{s.value}</p>
                <p className="text-xs text-gray-400 mt-0.5">{s.label}</p>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
