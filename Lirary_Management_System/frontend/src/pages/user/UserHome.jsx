import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';

/* ── status config ── */
const STATUS = {
  active:   { label: 'Active',   bg: 'bg-emerald-100', text: 'text-emerald-700', dot: 'bg-emerald-500' },
  pending:  { label: 'Pending',  bg: 'bg-yellow-100',  text: 'text-yellow-700',  dot: 'bg-yellow-500'  },
  returned: { label: 'Returned', bg: 'bg-gray-100',    text: 'text-gray-500',    dot: 'bg-gray-400'    },
  rejected: { label: 'Rejected', bg: 'bg-red-100',     text: 'text-red-600',     dot: 'bg-red-500'     },
};

/* ── stat card ── */
function StatCard({ icon, label, value, sub, bg, to }) {
  const inner = (
    <div className={`${bg} rounded-2xl p-5 flex items-center gap-4 border border-white/60 hover:shadow-md transition-shadow`}>
      <div className="w-12 h-12 bg-white/70 rounded-xl flex items-center justify-center text-2xl flex-shrink-0 shadow-sm">
        {icon}
      </div>
      <div>
        <p className="text-2xl font-extrabold text-gray-900 leading-none">{value}</p>
        <p className="text-sm font-semibold text-gray-700 mt-0.5">{label}</p>
        {sub && <p className="text-xs text-gray-400 mt-0.5">{sub}</p>}
      </div>
    </div>
  );
  return to ? <Link to={to} className="block">{inner}</Link> : inner;
}

/* ── quick action card ── */
function ActionCard({ icon, label, desc, to, color }) {
  return (
    <Link to={to}
      className={`group ${color} rounded-2xl p-5 border border-white/50 hover:shadow-lg hover:-translate-y-1
        transition-all duration-200 flex flex-col gap-3`}>
      <div className="w-12 h-12 bg-white/60 rounded-xl flex items-center justify-center text-2xl shadow-sm
        group-hover:scale-110 transition-transform">
        {icon}
      </div>
      <div>
        <p className="font-bold text-gray-900 text-sm">{label}</p>
        <p className="text-xs text-gray-500 mt-0.5 leading-relaxed">{desc}</p>
      </div>
      <div className="flex items-center text-xs font-semibold text-gray-600 mt-auto">
        Go <span className="ml-1 group-hover:translate-x-1 transition-transform">→</span>
      </div>
    </Link>
  );
}

/* ── book cover ── */
function Cover({ url, title }) {
  const [err, setErr] = useState(false);
  return (
    <div className="w-12 h-16 rounded-xl overflow-hidden bg-gradient-to-br from-slate-700 to-slate-900 flex-shrink-0 shadow-sm">
      {url && !err
        ? <img src={url} alt={title} className="w-full h-full object-cover" onError={() => setErr(true)} />
        : <div className="w-full h-full flex items-center justify-center text-xl opacity-40">📖</div>}
    </div>
  );
}

/* ── new arrival card ── */
function NewArrivalCard({ book }) {
  const [imgErr, setImgErr] = useState(false);
  return (
    <Link to="/user/catalog" className="group hover:-translate-y-1 transition-transform">
      <div className="rounded-xl overflow-hidden bg-gradient-to-br from-slate-700 to-slate-900 shadow-sm"
        style={{ paddingTop: '140%', position: 'relative' }}>
        <div className="absolute inset-0">
          {book.cover_url && !imgErr ? (
            <img src={book.cover_url} alt={book.title}
              className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
              onError={() => setImgErr(true)} />
          ) : (
            <div className="w-full h-full flex items-center justify-center text-3xl opacity-30">📖</div>
          )}
        </div>
      </div>
      <p className="text-[10px] font-bold text-gray-800 mt-2 line-clamp-2 leading-snug">{book.title}</p>
      <p className="text-[9px] text-gray-400 truncate mt-0.5">{book.author}</p>
    </Link>
  );
}

/* ── main ── */
export default function UserHome() {
  const { user } = useAuth();
  const [loans,  setLoans]  = useState([]);
  const [books,  setBooks]  = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      api.get('/api/loans/my'),
      api.get('/api/books', { params: { limit: 6 } }),
    ]).then(([lr, br]) => {
      setLoans(lr.data);
      setBooks(br.data.books || []);
    }).finally(() => setLoading(false));
  }, []);

  const active   = loans.filter(l => l.status === 'active');
  const pending  = loans.filter(l => l.status === 'pending');
  const overdue  = loans.filter(l => l.is_overdue);
  const totalFine = loans.reduce((s, l) => s + (l.current_fine || 0), 0);

  const recent = [...loans].sort((a, b) => b.id - a.id).slice(0, 5);

  const hour = new Date().getHours();
  const greeting = hour < 12 ? 'Good morning' : hour < 17 ? 'Good afternoon' : 'Good evening';

  return (
    <div className="space-y-7">

      {/* ── Welcome banner ── */}
      <div className="relative overflow-hidden rounded-2xl px-7 py-8"
        style={{ background: 'linear-gradient(135deg, #0f1b4c 0%, #1e1b6e 50%, #2d1b69 100%)' }}>
        {/* texture */}
        <div className="absolute inset-0 opacity-[0.04] pointer-events-none"
          style={{ backgroundImage: 'repeating-linear-gradient(45deg,transparent,transparent 10px,rgba(255,255,255,.8) 10px,rgba(255,255,255,.8) 11px)' }} />
        <div className="absolute -right-10 -top-10 w-64 h-64 bg-indigo-500/20 rounded-full blur-3xl pointer-events-none" />

        <div className="relative flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <p className="text-white/60 text-sm font-medium">{greeting},</p>
            <h1 className="text-2xl sm:text-3xl font-extrabold text-white mt-0.5">
              {user?.name?.split(' ')[0]} 👋
            </h1>
            <p className="text-white/50 text-sm mt-2 max-w-md">
              Welcome back to LibraryMS. You have{' '}
              <span className="text-white font-semibold">{active.length} active loan{active.length !== 1 ? 's' : ''}</span>
              {overdue.length > 0 && (
                <> and <span className="text-red-400 font-semibold">{overdue.length} overdue</span></>
              )}.
            </p>
          </div>
          <Link to="/user/catalog"
            className="flex-shrink-0 bg-white text-slate-900 font-extrabold px-6 py-3 rounded-2xl
              text-sm hover:bg-blue-50 transition-colors shadow-lg self-start sm:self-auto">
            Browse Catalog →
          </Link>
        </div>
      </div>

      {/* ── Stat cards ── */}
      <div>
        <h2 className="text-base font-extrabold text-gray-900 mb-3">My Account Summary</h2>
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
          <StatCard icon="📖" label="Active Loans"    value={loading ? '…' : active.length}
            sub="Currently borrowed" bg="bg-blue-50"    to="/user/history" />
          <StatCard icon="⏳" label="Pending"         value={loading ? '…' : pending.length}
            sub="Awaiting approval"  bg="bg-yellow-50"  to="/user/history" />
          <StatCard icon="⚠️" label="Overdue"         value={loading ? '…' : overdue.length}
            sub="Needs attention"    bg="bg-red-50"     to="/user/history" />
          <StatCard icon="💰" label="Outstanding Fine" value={loading ? '…' : `$${totalFine.toFixed(2)}`}
            sub="Total due"          bg="bg-amber-50" />
        </div>
      </div>

      {/* ── Main two columns ── */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

        {/* Recent loans — 2 cols */}
        <div className="lg:col-span-2 bg-white rounded-2xl border border-gray-100 shadow-sm p-5">
          <div className="flex items-center justify-between mb-5">
            <div>
              <h2 className="font-extrabold text-gray-900">Recent Loans</h2>
              <p className="text-xs text-gray-400 mt-0.5">Your latest borrowing activity</p>
            </div>
            <Link to="/user/history" className="text-xs text-blue-600 font-semibold hover:underline">
              View all →
            </Link>
          </div>

          {loading ? (
            <div className="space-y-3">
              {[1,2,3].map(i => (
                <div key={i} className="h-16 bg-gray-100 rounded-xl animate-pulse" />
              ))}
            </div>
          ) : recent.length === 0 ? (
            <div className="flex flex-col items-center py-10 text-center">
              <div className="text-4xl mb-2">📭</div>
              <p className="font-bold text-gray-700 text-sm">No loans yet</p>
              <p className="text-xs text-gray-400 mt-1">Browse the catalog to borrow your first book</p>
              <Link to="/user/catalog"
                className="mt-4 bg-slate-900 hover:bg-slate-700 text-white text-xs font-bold px-5 py-2 rounded-xl transition-colors">
                Browse Catalog
              </Link>
            </div>
          ) : (
            <div className="space-y-2">
              {recent.map(loan => {
                const s = STATUS[loan.status] || STATUS.returned;
                const ov = !!loan.is_overdue;
                return (
                  <div key={loan.id}
                    className={`flex items-center gap-3 p-3 rounded-xl border transition-colors
                      ${ov ? 'bg-red-50 border-red-100' : 'bg-gray-50 border-gray-100 hover:bg-gray-100'}`}>
                    <Cover url={null} title={loan.title} />
                    <div className="flex-1 min-w-0">
                      <p className="font-semibold text-gray-900 text-sm truncate">{loan.title}</p>
                      <p className="text-xs text-gray-400 truncate mt-0.5">{loan.author}</p>
                    </div>
                    <div className="text-right flex-shrink-0 hidden sm:block">
                      <p className="text-[10px] text-gray-400">Due</p>
                      <p className={`text-xs font-bold ${ov ? 'text-red-600' : 'text-gray-700'}`}>
                        {loan.due_date || '—'}
                      </p>
                    </div>
                    <span className={`inline-flex items-center gap-1 text-[10px] font-bold px-2.5 py-1
                      rounded-full flex-shrink-0 ${s.bg} ${s.text}`}>
                      <span className={`w-1.5 h-1.5 rounded-full ${ov ? 'bg-red-500' : s.dot}`} />
                      {ov ? 'Overdue' : s.label}
                    </span>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        {/* Quick actions — 1 col */}
        <div className="space-y-4">
          <div>
            <h2 className="font-extrabold text-gray-900 mb-3">Quick Actions</h2>
            <div className="grid grid-cols-1 gap-3">
              <ActionCard icon="🔍" label="Browse Catalog"  to="/user/catalog"
                desc="Search and explore all available books"
                color="bg-blue-50" />
              <ActionCard icon="📋" label="My Borrowings"   to="/user/history"
                desc="Track loans, due dates, and fines"
                color="bg-indigo-50" />
              <ActionCard icon="👤" label="My Profile"      to="/user/profile"
                desc="View and update your account info"
                color="bg-purple-50" />
              <ActionCard icon="⚙️" label="Settings"        to="/user/settings"
                desc="Manage your preferences"
                color="bg-gray-50" />
            </div>
          </div>
        </div>
      </div>

      {/* ── New arrivals ── */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-5">
        <div className="flex items-center justify-between mb-5">
          <div>
            <h2 className="font-extrabold text-gray-900">New Arrivals</h2>
            <p className="text-xs text-gray-400 mt-0.5">Recently added to the collection</p>
          </div>
          <Link to="/user/catalog" className="text-xs text-blue-600 font-semibold hover:underline">
            Browse all →
          </Link>
        </div>

        {loading ? (
          <div className="grid grid-cols-3 sm:grid-cols-6 gap-4">
            {Array(6).fill(0).map((_, i) => (
              <div key={i} className="animate-pulse">
                <div className="rounded-xl bg-gray-200 mb-2" style={{ paddingTop: '140%' }} />
                <div className="h-2.5 bg-gray-200 rounded-full w-4/5 mb-1" />
                <div className="h-2 bg-gray-100 rounded-full w-3/5" />
              </div>
            ))}
          </div>
        ) : (
          <div className="grid grid-cols-3 sm:grid-cols-6 gap-4">
            {books.slice(0, 6).map(book => (
              <NewArrivalCard key={book.id} book={book} />
            ))}
          </div>
        )}
      </div>

    </div>
  );
}
