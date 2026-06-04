import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';

const MAX_LOANS = 5;

/* ── SVG Icons ── */
const IBook  = () => <svg className="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" strokeWidth={1.8} viewBox="0 0 24 24"><path strokeLinecap="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>;
const IWarn  = () => <svg className="w-5 h-5 text-red-400"  fill="none" stroke="currentColor" strokeWidth={2}   viewBox="0 0 24 24"><path strokeLinecap="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/></svg>;
const ICheck = () => <svg className="w-5 h-5 text-emerald-500" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24"><path strokeLinecap="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>;
const ISearch= () => <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/></svg>;
const IUser  = () => <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>;

/* ── Stat card ── */
function StatCard({ bg, icon, value, label, sub }) {
  return (
    <div className="flex-1 bg-white rounded-2xl border border-gray-100 shadow-sm p-5 flex items-center gap-4 min-w-0">
      <div className={`w-12 h-12 ${bg} rounded-xl flex items-center justify-center flex-shrink-0`}>{icon}</div>
      <div className="min-w-0">
        <p className="text-2xl font-extrabold text-gray-900 leading-none">{value}</p>
        <p className="text-sm font-semibold text-gray-800 mt-0.5 truncate">{label}</p>
        <p className="text-xs text-gray-400 mt-0.5 truncate">{sub}</p>
      </div>
    </div>
  );
}

/* ── Loan row ── */
function LoanRow({ loan, onInfo }) {
  const ov = !!loan.is_overdue;
  return (
    <div className={`bg-white rounded-2xl border shadow-sm p-4 flex items-center gap-4 hover:shadow-md transition-shadow
      ${ov ? 'border-red-100' : 'border-gray-100'}`}>

      {/* Book icon */}
      <div className="w-12 h-16 bg-blue-50 border border-blue-100 rounded-xl flex items-center justify-center flex-shrink-0">
        <IBook />
      </div>

      {/* Info */}
      <div className="flex-1 min-w-0">
        <p className="font-bold text-gray-900 text-sm sm:text-base truncate">{loan.title}</p>
        <p className="text-sm text-gray-400 truncate mt-0.5">{loan.author}</p>
      </div>

      {/* Due date */}
      <div className="text-right flex-shrink-0 hidden sm:block">
        <p className="text-xs text-gray-400 font-medium">Due Date</p>
        <p className={`text-sm font-bold mt-0.5 ${ov ? 'text-red-500' : 'text-gray-800'}`}>
          {loan.due_date || '—'}
        </p>
      </div>

      {/* Status */}
      <div className="flex-shrink-0">
        {ov ? (
          <span className="inline-flex items-center gap-1.5 bg-red-50 border border-red-200 text-red-600 text-xs font-bold px-3 py-1.5 rounded-full">
            <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24"><path strokeLinecap="round" d="M12 9v3.75m0 3.75h.007v.008H12v-.008z"/><path strokeLinecap="round" d="M10.363 3.591l-8.106 13.534a1.914 1.914 0 001.636 2.871h16.214a1.914 1.914 0 001.636-2.87L13.637 3.59a1.914 1.914 0 00-3.274 0z"/></svg>
            Overdue
          </span>
        ) : loan.status === 'active' ? (
          <span className="inline-flex items-center gap-1.5 bg-emerald-50 border border-emerald-200 text-emerald-700 text-xs font-bold px-3 py-1.5 rounded-full">
            <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24"><path strokeLinecap="round" d="m4.5 12.75 6 6 9-13.5"/></svg>
            Active
          </span>
        ) : loan.status === 'pending' ? (
          <span className="inline-flex items-center gap-1.5 bg-yellow-50 border border-yellow-200 text-yellow-700 text-xs font-bold px-3 py-1.5 rounded-full">
            ⏳ Pending
          </span>
        ) : loan.status === 'returned' ? (
          <span className="inline-flex items-center gap-1.5 bg-gray-50 border border-gray-200 text-gray-500 text-xs font-bold px-3 py-1.5 rounded-full">
            ✓ Returned
          </span>
        ) : (
          <span className="inline-flex items-center gap-1.5 bg-red-50 border border-red-100 text-red-400 text-xs font-bold px-3 py-1.5 rounded-full">
            ✕ Rejected
          </span>
        )}
      </div>

      {/* Request Return button — active loans */}
      {loan.status === 'active' && (
        <button
          onClick={() => onInfo('Please visit the library desk to return this book.')}
          className="flex-shrink-0 bg-slate-900 hover:bg-slate-700 active:scale-95 text-white text-xs font-bold px-4 py-2.5 rounded-xl transition-all whitespace-nowrap shadow-sm">
          Request Return
        </button>
      )}
    </div>
  );
}

/* ── Main page ── */
export default function BorrowingHistory() {
  const { user } = useAuth();
  const [loans, setLoans]     = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter]   = useState('all');
  const [search, setSearch]   = useState('');
  const [toast, setToast]     = useState(null);

  const showToast = msg => { setToast(msg); setTimeout(() => setToast(null), 4000); };

  useEffect(() => {
    api.get('/api/loans/my').then(r => setLoans(r.data)).finally(() => setLoading(false));
  }, []);

  const active  = loans.filter(l => l.status === 'active');
  const overdue = loans.filter(l => l.is_overdue);
  const onTime  = active.filter(l => !l.is_overdue);

  const filtered = loans.filter(l => {
    const ok =
      filter === 'all'      ? true :
      filter === 'active'   ? l.status === 'active' && !l.is_overdue :
      filter === 'overdue'  ? !!l.is_overdue :
      filter === 'pending'  ? l.status === 'pending' :
      filter === 'returned' ? l.status === 'returned' : true;
    const s = search.toLowerCase();
    const ms = !search || l.title?.toLowerCase().includes(s) || l.author?.toLowerCase().includes(s);
    return ok && ms;
  });

  const dashboard =
    user?.role === 'superadmin' ? '/superadmin' :
    user?.role === 'admin'      ? '/admin'      : '/user';

  return (
    <div>

      {/* ── Toast ── */}
      {toast && (
        <div className="fixed top-5 right-5 z-50 bg-slate-900 text-white text-sm font-semibold px-5 py-3 rounded-2xl shadow-2xl animate-fade-in">
          ℹ️ {toast}
        </div>
      )}

      {/* ── Top bar ── */}
      <div className="flex flex-wrap items-center justify-between gap-3 mb-6">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">My Books</h1>
          <p className="text-sm text-gray-400 mt-0.5">Track and manage your borrowed books</p>
        </div>

        <div className="flex items-center gap-2 flex-wrap">
          {/* Search */}
          <div className="flex items-center gap-2 bg-white border border-gray-200 rounded-xl px-3 py-2 shadow-sm focus-within:ring-2 focus-within:ring-blue-400 transition-all">
            <ISearch />
            <input
              value={search} onChange={e => setSearch(e.target.value)}
              placeholder="Quick search…"
              className="text-sm text-gray-700 placeholder-gray-400 outline-none bg-transparent w-36 sm:w-44"
            />
          </div>

          {/* Notification bell */}
          <button className="relative w-9 h-9 bg-white border border-gray-200 rounded-xl flex items-center justify-center text-gray-500 hover:bg-gray-50 shadow-sm transition-colors">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <path strokeLinecap="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
            </svg>
            {overdue.length > 0 && (
              <span className="absolute -top-1.5 -right-1.5 w-4 h-4 bg-red-500 text-white text-[9px] font-bold rounded-full flex items-center justify-center">
                {overdue.length}
              </span>
            )}
          </button>

          {/* User icon */}
          <Link to={`${dashboard}/profile`}
            className="w-9 h-9 bg-white border border-gray-200 rounded-xl flex items-center justify-center text-gray-500 hover:bg-gray-50 shadow-sm transition-colors">
            <IUser />
          </Link>

          {/* Member / Admin toggle */}
          <div className="flex bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden text-xs font-bold">
            <span className="px-4 py-2 bg-slate-900 text-white">Member</span>
            {user?.role !== 'user' && (
              <Link to={dashboard} className="px-4 py-2 text-gray-500 hover:bg-gray-50 transition-colors">Admin</Link>
            )}
          </div>
        </div>
      </div>

      {/* ── Stat cards ── */}
      <div className="flex gap-4 flex-wrap sm:flex-nowrap mb-6">
        <StatCard
          bg="bg-blue-50"
          icon={<IBook />}
          value={loading ? '…' : active.length}
          label="Currently Borrowed"
          sub={`of ${MAX_LOANS} allowed`}
        />
        <StatCard
          bg="bg-red-50"
          icon={<IWarn />}
          value={loading ? '…' : overdue.length}
          label="Overdue Items"
          sub={overdue.length > 0 ? 'Needs attention' : 'All good!'}
        />
        <StatCard
          bg="bg-emerald-50"
          icon={<ICheck />}
          value={loading ? '…' : onTime.length}
          label="On Time"
          sub="items in good standing"
        />
      </div>

      {/* ── Filter pills ── */}
      <div className="flex gap-2 flex-wrap mb-5">
        {[
          { key:'all',      label:'All'        },
          { key:'active',   label:'📖 Active'  },
          { key:'overdue',  label:'⚠️ Overdue' },
          { key:'pending',  label:'⏳ Pending' },
          { key:'returned', label:'✅ Returned'},
        ].map(f => (
          <button key={f.key} onClick={() => setFilter(f.key)}
            className={`px-4 py-1.5 rounded-full text-xs font-semibold border transition-all
              ${filter === f.key
                ? 'bg-slate-900 text-white border-slate-900 shadow-sm'
                : 'bg-white text-gray-500 border-gray-200 hover:border-slate-400 hover:text-slate-700'}`}>
            {f.label}
          </button>
        ))}
      </div>

      {/* ── List header ── */}
      <div className="flex items-end justify-between mb-4">
        <div>
          <h2 className="text-lg font-extrabold text-gray-900">My Borrowed Books</h2>
          <p className="text-sm text-gray-400 mt-0.5">Manage your current loans</p>
        </div>
        <span className="text-xs text-gray-400 bg-gray-100 px-3 py-1 rounded-full">
          {filtered.length} record{filtered.length !== 1 ? 's' : ''}
        </span>
      </div>

      {/* ── Loan rows ── */}
      {loading ? (
        <div className="space-y-3">
          {[1,2,3].map(i => <div key={i} className="h-20 bg-gray-100 rounded-2xl animate-pulse" />)}
        </div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 bg-white rounded-2xl border border-gray-100">
          <div className="w-16 h-16 bg-gray-100 rounded-2xl flex items-center justify-center text-3xl mb-3">📭</div>
          <p className="font-bold text-gray-700 text-base">No records found</p>
          <p className="text-sm text-gray-400 mt-1">
            {filter !== 'all' ? 'Try switching to "All"' : 'You have not borrowed any books yet'}
          </p>
          {filter === 'all' && (
            <Link to="/user" className="mt-4 bg-slate-900 hover:bg-slate-700 text-white text-sm font-bold px-6 py-2.5 rounded-xl transition-colors">
              Browse Catalog →
            </Link>
          )}
        </div>
      ) : (
        <div className="space-y-3">
          {filtered.map(loan => (
            <LoanRow key={loan.id} loan={loan} onInfo={showToast} />
          ))}
        </div>
      )}

    </div>
  );
}
