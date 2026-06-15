import { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import api from '../../services/api';

/* ── helpers ─────────────────────────────────────────────────── */
const fmt = (d) =>
  d ? new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : '—';

const daysLeft = (due) => {
  if (!due) return null;
  return Math.ceil((new Date(due) - new Date()) / 86400000);
};

/* ── Status config ───────────────────────────────────────────── */
const S = {
  pending:  { label: 'Pending',  dot: 'bg-amber-400',   badge: 'bg-amber-50 border-amber-200 text-amber-700'    },
  active:   { label: 'Active',   dot: 'bg-emerald-500', badge: 'bg-emerald-50 border-emerald-200 text-emerald-700'},
  returned: { label: 'Returned', dot: 'bg-blue-400',    badge: 'bg-blue-50 border-blue-200 text-blue-600'       },
  rejected: { label: 'Rejected', dot: 'bg-gray-300',    badge: 'bg-gray-50 border-gray-200 text-gray-400'       },
  overdue:  { label: 'Overdue',  dot: 'bg-red-500',     badge: 'bg-red-50 border-red-200 text-red-600'          },
};
const getStatus = (loan) => loan.is_overdue ? 'overdue' : loan.status;

/* ── User avatar ─────────────────────────────────────────────── */
const COLORS = ['from-blue-500 to-indigo-600','from-violet-500 to-purple-700',
  'from-emerald-500 to-teal-600','from-amber-400 to-orange-500','from-pink-400 to-rose-600'];
const userColor = (name) => COLORS[(name?.charCodeAt(0) || 0) % COLORS.length];

function Avatar({ name }) {
  const initials = name?.split(' ').map(w => w[0]).join('').slice(0, 2).toUpperCase() || '?';
  return (
    <div className={`w-9 h-9 rounded-xl bg-gradient-to-br ${userColor(name)} flex items-center justify-center
      text-white text-xs font-extrabold flex-shrink-0 shadow-sm`}>
      {initials}
    </div>
  );
}

/* ── Confirm modal ───────────────────────────────────────────── */
function ConfirmModal({ action, loan, onConfirm, onClose, loading }) {
  const cfg = {
    issue:      { title: 'Issue Book',      body: `Issue "${loan.title}" to ${loan.user_name}?`,  color: 'from-emerald-500 to-teal-600', btn: 'Issue',      btnCls: 'bg-emerald-600 hover:bg-emerald-700' },
    reject:     { title: 'Reject Request',  body: `Reject "${loan.user_name}"'s request for "${loan.title}"?`, color: 'from-red-500 to-rose-600', btn: 'Reject', btnCls: 'bg-red-600 hover:bg-red-700' },
    return:     { title: 'Process Return',  body: `Mark "${loan.title}" as returned?`, color: 'from-blue-500 to-indigo-600', btn: 'Confirm Return', btnCls: 'bg-blue-600 hover:bg-blue-700' },
    'pay-fine': { title: 'Mark Fine Paid',  body: `Mark the $${(loan.current_fine||0).toFixed(2)} fine as paid?`, color: 'from-violet-500 to-purple-700', btn: 'Mark Paid', btnCls: 'bg-violet-600 hover:bg-violet-700' },
  }[action];

  if (!cfg) return null;
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
      onClick={onClose}>
      <div className="bg-white rounded-3xl shadow-2xl w-full max-w-sm p-6" onClick={e => e.stopPropagation()}>
        <div className="flex items-center gap-3 mb-4">
          <div className={`w-10 h-10 bg-gradient-to-br ${cfg.color} rounded-2xl flex items-center justify-center text-xl shadow-sm`}>
            {action === 'issue' ? '✓' : action === 'reject' ? '✕' : action === 'return' ? '↩️' : '💰'}
          </div>
          <div>
            <p className="font-extrabold text-gray-900">{cfg.title}</p>
            <p className="text-xs text-gray-400">Loan #{loan.id}</p>
          </div>
        </div>
        <p className="text-sm text-gray-600 bg-gray-50 rounded-xl p-3 mb-5">{cfg.body}</p>
        <div className="flex gap-3">
          <button onClick={onClose}
            className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold py-3 rounded-xl text-sm transition-colors">
            Cancel
          </button>
          <button onClick={onConfirm} disabled={loading}
            className={`flex-1 ${cfg.btnCls} disabled:opacity-60 text-white font-bold py-3 rounded-xl text-sm transition-colors flex items-center justify-center gap-2`}>
            {loading ? <span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/> : null}
            {cfg.btn}
          </button>
        </div>
      </div>
    </div>
  );
}

/* ── Loan row ────────────────────────────────────────────────── */
function LoanRow({ loan, onAction }) {
  const status = getStatus(loan);
  const cfg    = S[status];
  const days   = daysLeft(loan.due_date);

  return (
    <div className={`flex items-center gap-3 px-5 py-3.5 hover:bg-gray-50/70 transition-colors border-b border-gray-50 last:border-0
      ${status === 'overdue' ? 'bg-red-50/30' : ''}`}>

      {/* Avatar */}
      <Avatar name={loan.user_name} />

      {/* User */}
      <div className="w-36 flex-shrink-0 min-w-0 hidden lg:block">
        <p className="text-sm font-bold text-gray-900 truncate">{loan.user_name}</p>
        <p className="text-xs text-gray-400 truncate">{loan.user_email}</p>
      </div>

      {/* Book */}
      <div className="flex-1 min-w-0">
        <p className="text-sm font-bold text-gray-900 truncate">{loan.title}</p>
        <p className="text-xs text-gray-400 truncate">{loan.author}</p>
        {/* Mobile: show user info here */}
        <p className="text-xs text-gray-500 lg:hidden mt-0.5 truncate">{loan.user_name}</p>
      </div>

      {/* Status */}
      <div className="flex-shrink-0 hidden sm:block">
        <span className={`inline-flex items-center gap-1.5 border text-[11px] font-bold px-2.5 py-1 rounded-full ${cfg.badge}`}>
          <span className={`w-1.5 h-1.5 rounded-full ${cfg.dot}`}/>
          {cfg.label}
        </span>
      </div>

      {/* Dates */}
      <div className="flex-shrink-0 text-right hidden xl:block w-28">
        {loan.borrow_date && (
          <p className="text-[11px] text-gray-400">
            <span className="font-semibold text-gray-600">From:</span> {fmt(loan.borrow_date)}
          </p>
        )}
        {loan.due_date && (
          <p className={`text-[11px] font-semibold ${status === 'overdue' ? 'text-red-500' : days !== null && days <= 3 ? 'text-amber-600' : 'text-gray-400'}`}>
            {status === 'overdue' ? `${Math.abs(days || 0)}d overdue` :
             days !== null && days <= 3 ? `Due in ${days}d` : `Due: ${fmt(loan.due_date)}`}
          </p>
        )}
        {loan.return_date && (
          <p className="text-[11px] text-gray-400">
            <span className="font-semibold text-gray-600">Ret:</span> {fmt(loan.return_date)}
          </p>
        )}
      </div>

      {/* Fine */}
      <div className="flex-shrink-0 hidden sm:block w-20 text-right">
        {(loan.current_fine || 0) > 0 ? (
          <span className={`text-xs font-bold ${loan.fine_paid ? 'text-gray-400 line-through' : 'text-red-500'}`}>
            ${(loan.current_fine || 0).toFixed(2)}
          </span>
        ) : <span className="text-gray-300 text-xs">—</span>}
      </div>

      {/* Actions */}
      <div className="flex items-center gap-1.5 flex-shrink-0">
        {loan.status === 'pending' && (
          <>
            <button onClick={() => onAction(loan, 'issue')}
              className="bg-emerald-500 hover:bg-emerald-600 text-white text-[11px] font-bold px-3 py-1.5 rounded-lg transition-colors shadow-sm">
              ✓ Issue
            </button>
            <button onClick={() => onAction(loan, 'reject')}
              className="bg-white hover:bg-red-50 border border-red-200 text-red-500 text-[11px] font-bold px-2.5 py-1.5 rounded-lg transition-colors">
              ✕
            </button>
          </>
        )}
        {loan.status === 'active' && (
          <button onClick={() => onAction(loan, 'return')}
            className="bg-blue-50 hover:bg-blue-100 border border-blue-200 text-blue-700 text-[11px] font-bold px-3 py-1.5 rounded-lg transition-colors">
            ↩ Return
          </button>
        )}
        {loan.status === 'returned' && (loan.current_fine || 0) > 0 && !loan.fine_paid && (
          <button onClick={() => onAction(loan, 'pay-fine')}
            className="bg-violet-50 hover:bg-violet-100 border border-violet-200 text-violet-700 text-[11px] font-bold px-3 py-1.5 rounded-lg transition-colors">
            💰 Paid
          </button>
        )}
        {loan.status === 'returned' && (loan.current_fine === 0 || loan.fine_paid) && (
          <span className="text-[11px] text-gray-300 font-medium px-2">—</span>
        )}
        {loan.status === 'rejected' && (
          <span className="text-[11px] text-gray-300 font-medium px-2">—</span>
        )}
      </div>
    </div>
  );
}

/* ── Main page ───────────────────────────────────────────────── */
export default function LoanManagement() {
  const [searchParams]           = useSearchParams();
  const [loans,     setLoans]    = useState([]);
  const [total,     setTotal]    = useState(0);
  const [pages,     setPages]    = useState(1);
  const [page,      setPage]     = useState(1);
  const [status,    setStatus]   = useState(searchParams.get('status') || '');
  const [counts,    setCounts]   = useState({});
  const [loading,   setLoading]  = useState(true);
  const [confirm,   setConfirm]  = useState(null); // { loan, action }
  const [acting,    setActing]   = useState(false);
  const [toast,     setToast]    = useState(null);

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
      setLoans(data.loans || []);
      setTotal(data.total || 0);
      setPages(data.pages || 1);
    } finally {
      setLoading(false);
    }
  }, [page, status]);

  /* Fetch status counts separately for filter pills */
  const fetchCounts = useCallback(async () => {
    try {
      const results = await Promise.all(
        ['pending', 'active', 'returned', 'rejected'].map(s =>
          api.get('/api/loans', { params: { status: s, limit: 1 } }).then(r => [s, r.data.total || 0])
        )
      );
      const m = Object.fromEntries(results);
      const activeLoans = await api.get('/api/loans', { params: { status: 'active', limit: 200 } });
      m.overdue = (activeLoans.data.loans || []).filter(l => l.is_overdue).length;
      setCounts(m);
    } catch { /* silent */ }
  }, []);

  useEffect(() => { fetchLoans(); }, [fetchLoans]);
  useEffect(() => { fetchCounts(); }, [fetchCounts]);

  const handleAction = async () => {
    if (!confirm) return;
    setActing(true);
    try {
      const { data } = await api.post(`/api/loans/${confirm.loan.id}/${confirm.action}`);
      const msgs = {
        issue:      `Issued! Due: ${data.due_date}`,
        reject:     'Request rejected.',
        return:     `Returned. Fine: $${data.fine_amount?.toFixed(2) ?? '0.00'}`,
        'pay-fine': 'Fine marked as paid.',
      };
      showToast(msgs[confirm.action] || 'Done.');
      setConfirm(null);
      fetchLoans();
      fetchCounts();
    } catch (err) {
      showToast(err.response?.data?.message || 'Action failed', 'error');
    } finally {
      setActing(false);
    }
  };

  const FILTERS = [
    { key: '',         label: 'All',      icon: '📋' },
    { key: 'pending',  label: 'Pending',  icon: '⏳' },
    { key: 'active',   label: 'Active',   icon: '📖' },
    { key: 'returned', label: 'Returned', icon: '✅' },
    { key: 'rejected', label: 'Rejected', icon: '✕'  },
  ];

  const overdueInView = loans.filter(l => l.is_overdue).length;

  return (
    <div className="max-w-7xl mx-auto">

      {/* ── Toast ── */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          {toast.type === 'error' ? '✕' : '✓'} {toast.msg}
        </div>
      )}

      {/* ── Confirm modal ── */}
      {confirm && (
        <ConfirmModal
          action={confirm.action}
          loan={confirm.loan}
          onConfirm={handleAction}
          onClose={() => setConfirm(null)}
          loading={acting}
        />
      )}

      {/* ── Header ── */}
      <div className="flex flex-wrap items-start justify-between gap-3 mb-6">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">Loans & Requests</h1>
          <p className="text-sm text-gray-400 mt-0.5">Manage all borrowing activity</p>
        </div>
        {counts.pending > 0 && (
          <div className="flex items-center gap-2 bg-amber-50 border border-amber-200 rounded-xl px-4 py-2">
            <span className="text-amber-500">⏳</span>
            <span className="text-sm font-bold text-amber-700">{counts.pending} pending</span>
          </div>
        )}
      </div>

      {/* ── Status counts overview ── */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6">
        {[
          { key: 'pending',  label: 'Pending',  icon: '⏳', color: 'bg-amber-50 border-amber-100 text-amber-700'    },
          { key: 'active',   label: 'Active',   icon: '📖', color: 'bg-emerald-50 border-emerald-100 text-emerald-700'},
          { key: 'overdue',  label: 'Overdue',  icon: '⚠️', color: 'bg-red-50 border-red-100 text-red-600'           },
          { key: 'returned', label: 'Returned', icon: '✅', color: 'bg-blue-50 border-blue-100 text-blue-600'         },
        ].map(s => (
          <button key={s.key}
            onClick={() => { setStatus(s.key === 'overdue' ? 'active' : s.key); setPage(1); }}
            className={`${s.color} border rounded-2xl p-4 flex items-center gap-3 text-left hover:opacity-80 transition-opacity`}>
            <span className="text-xl">{s.icon}</span>
            <div>
              <p className="text-lg font-extrabold leading-none">{counts[s.key] ?? '…'}</p>
              <p className="text-xs font-semibold mt-0.5 opacity-80">{s.label}</p>
            </div>
          </button>
        ))}
      </div>

      {/* ── Filter pills ── */}
      <div className="flex flex-wrap items-center gap-2 mb-5">
        {FILTERS.map(f => (
          <button key={f.key}
            onClick={() => { setStatus(f.key); setPage(1); }}
            className={`inline-flex items-center gap-1.5 px-4 py-2 rounded-full text-xs font-bold border transition-all
              ${status === f.key
                ? 'bg-slate-900 text-white border-slate-900 shadow-sm'
                : 'bg-white text-gray-500 border-gray-200 hover:border-gray-400 hover:text-gray-700'}`}>
            <span>{f.icon}</span> {f.label}
            {f.key !== '' && counts[f.key] > 0 && (
              <span className={`text-[10px] rounded-full px-1.5 py-0.5 font-extrabold
                ${status === f.key ? 'bg-white/20 text-white' : 'bg-gray-100 text-gray-500'}`}>
                {counts[f.key]}
              </span>
            )}
          </button>
        ))}

        <span className="ml-auto text-xs text-gray-400 bg-gray-100 px-3 py-1.5 rounded-full font-semibold">
          {loading ? '…' : `${total} record${total !== 1 ? 's' : ''}`}
        </span>
      </div>

      {/* ── Overdue sub-banner ── */}
      {!loading && status === 'active' && overdueInView > 0 && (
        <div className="flex items-center gap-3 bg-red-50 border border-red-200 rounded-xl px-4 py-2.5 mb-4">
          <span>⚠️</span>
          <p className="text-sm font-bold text-red-600">
            {overdueInView} of these loans {overdueInView === 1 ? 'is' : 'are'} overdue — highlighted below
          </p>
        </div>
      )}

      {/* ── Table ── */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
        {/* Column headers */}
        {!loading && loans.length > 0 && (
          <div className="hidden lg:grid grid-cols-[40px_1fr_1fr_100px_100px_80px_140px] gap-3 items-center px-5 py-3 border-b border-gray-100 bg-gray-50/60">
            {['', 'Member', 'Book', 'Status', 'Dates', 'Fine', 'Actions'].map((h, i) => (
              <p key={i} className="text-[11px] font-bold text-gray-400 uppercase tracking-wider">{h}</p>
            ))}
          </div>
        )}

        {loading ? (
          <div className="p-4 space-y-3">
            {[1,2,3,4,5].map(i => <div key={i} className="h-16 bg-gray-100 rounded-xl animate-pulse"/>)}
          </div>
        ) : loans.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-center px-4">
            <div className="w-16 h-16 bg-gray-100 rounded-2xl flex items-center justify-center text-3xl mb-3">📭</div>
            <p className="font-bold text-gray-700">No records found</p>
            <p className="text-sm text-gray-400 mt-1">
              {status ? `No ${status} loans at the moment` : 'No loan records yet'}
            </p>
          </div>
        ) : (
          <div>
            {loans.map(loan => (
              <LoanRow
                key={loan.id}
                loan={loan}
                onAction={(l, a) => setConfirm({ loan: l, action: a })}
              />
            ))}
          </div>
        )}
      </div>

      {/* ── Pagination ── */}
      {pages > 1 && (
        <div className="flex items-center justify-between mt-6">
          <p className="text-sm text-gray-400">
            Page <span className="font-bold text-gray-700">{page}</span> of <span className="font-bold text-gray-700">{pages}</span>
          </p>
          <div className="flex items-center gap-2">
            <button
              onClick={() => setPage(p => Math.max(1, p - 1))}
              disabled={page === 1}
              className="flex items-center gap-1 bg-white border border-gray-200 hover:border-gray-300 disabled:opacity-40
                text-sm font-bold text-gray-600 px-4 py-2 rounded-xl transition-all shadow-sm">
              ← Prev
            </button>
            <div className="flex items-center gap-1">
              {Array.from({ length: Math.min(5, pages) }, (_, i) => {
                const p = page <= 3 ? i + 1 : page + i - 2;
                if (p < 1 || p > pages) return null;
                return (
                  <button key={p} onClick={() => setPage(p)}
                    className={`w-9 h-9 rounded-xl text-sm font-bold transition-all
                      ${page === p ? 'bg-blue-600 text-white shadow-md shadow-blue-200' : 'bg-white border border-gray-200 text-gray-600 hover:border-gray-300'}`}>
                    {p}
                  </button>
                );
              })}
            </div>
            <button
              onClick={() => setPage(p => Math.min(pages, p + 1))}
              disabled={page === pages}
              className="flex items-center gap-1 bg-white border border-gray-200 hover:border-gray-300 disabled:opacity-40
                text-sm font-bold text-gray-600 px-4 py-2 rounded-xl transition-all shadow-sm">
              Next →
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
