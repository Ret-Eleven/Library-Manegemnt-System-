import { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import api from '../services/api';

/* ─────────────────────────────────────────────
   STATIC DATA (used when not logged in)
───────────────────────────────────────────── */
const NEW_ARRIVALS = [
  { title: 'The Great Gatsby',         author: 'F. Scott Fitzgerald', cover: 'https://covers.openlibrary.org/b/isbn/9780743273565-M.jpg', category: 'Fiction' },
  { title: '1984',                      author: 'George Orwell',        cover: 'https://covers.openlibrary.org/b/isbn/9780451524935-M.jpg', category: 'Fiction' },
  { title: 'Clean Code',                author: 'Robert C. Martin',     cover: 'https://covers.openlibrary.org/b/isbn/9780132350884-M.jpg', category: 'CS' },
  { title: 'Atomic Habits',             author: 'James Clear',          cover: 'https://covers.openlibrary.org/b/isbn/9780735211292-M.jpg', category: 'Self-Help' },
  { title: 'Dune',                      author: 'Frank Herbert',         cover: 'https://covers.openlibrary.org/b/isbn/9780441013593-M.jpg', category: 'Sci-Fi' },
  { title: 'The Pragmatic Programmer',  author: 'David Thomas',          cover: 'https://covers.openlibrary.org/b/isbn/9780135957059-M.jpg', category: 'CS' },
];

const LIBRARY_EVENTS = [
  { date: 'Jun 10', title: 'Reading Club Meeting',   time: '3:00 PM', color: 'bg-blue-100 text-blue-700' },
  { date: 'Jun 14', title: 'New Books Showcase',     time: '10:00 AM', color: 'bg-emerald-100 text-emerald-700' },
  { date: 'Jun 18', title: 'Study Skills Workshop',  time: '2:00 PM', color: 'bg-purple-100 text-purple-700' },
  { date: 'Jun 22', title: 'Digital Library Tour',   time: '11:00 AM', color: 'bg-amber-100 text-amber-700' },
];

const STATUS_COLOR = {
  active:   'bg-green-100 text-green-700',
  pending:  'bg-yellow-100 text-yellow-700',
  returned: 'bg-gray-100 text-gray-600',
  rejected: 'bg-red-100 text-red-600',
};

/* ─────────────────────────────────────────────
   SUB-COMPONENTS
───────────────────────────────────────────── */
function BookCover({ cover, title, size = 'md' }) {
  const [err, setErr] = useState(false);
  const h = size === 'sm' ? 'h-20' : 'h-28';
  return (
    <div className={`${h} w-full rounded-lg overflow-hidden bg-gray-100 flex-shrink-0`}>
      {cover && !err
        ? <img src={cover} alt={title} className="w-full h-full object-cover" onError={() => setErr(true)} />
        : <div className="w-full h-full flex items-center justify-center text-3xl text-gray-300">📖</div>
      }
    </div>
  );
}

function StatWidget({ icon, label, value, color, to }) {
  const inner = (
    <div className={`flex items-center gap-3 p-4 rounded-2xl border ${color} hover:shadow-md transition-shadow`}>
      <span className="text-3xl">{icon}</span>
      <div>
        <p className="text-2xl font-extrabold leading-none">{value}</p>
        <p className="text-xs font-medium mt-0.5 opacity-70">{label}</p>
      </div>
    </div>
  );
  return to ? <Link to={to}>{inner}</Link> : inner;
}

/* ─────────────────────────────────────────────
   PUBLIC LANDING (not logged in)
───────────────────────────────────────────── */
function PublicHome() {
  const [search, setSearch] = useState('');
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-slate-50">

      {/* ── Header ── */}
      <header className="bg-slate-900 shadow-lg">
        <div className="max-w-7xl mx-auto px-4 sm:px-8 py-4 flex items-center gap-4">
          {/* Logo */}
          <div className="flex items-center gap-3 flex-shrink-0">
            <div className="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center text-white text-xl shadow shadow-blue-900">📚</div>
            <div className="leading-none">
              <p className="text-white font-extrabold text-base">LibraryMS</p>
              <p className="text-slate-400 text-[10px]">RUPP · Management System</p>
            </div>
          </div>

          {/* Search */}
          <form onSubmit={e => { e.preventDefault(); navigate('/login'); }}
            className="flex-1 max-w-xl mx-4 hidden sm:flex items-center gap-2 bg-white/10 border border-white/20 rounded-xl px-4 py-2">
            <svg className="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input value={search} onChange={e => setSearch(e.target.value)}
              placeholder="Search books by title, author, or ISBN…"
              className="flex-1 bg-transparent text-white placeholder-slate-400 text-sm outline-none" />
          </form>

          {/* Auth */}
          <div className="flex items-center gap-3 ml-auto">
            <Link to="/login"    className="text-slate-300 hover:text-white text-sm font-medium transition-colors">Sign in</Link>
            <Link to="/register" className="bg-blue-600 hover:bg-blue-500 text-white text-sm font-bold px-5 py-2 rounded-xl transition-colors">Register</Link>
          </div>
        </div>

        {/* ── Nav bar ── */}
        <nav className="border-t border-white/10">
          <div className="max-w-7xl mx-auto px-4 sm:px-8 flex items-center gap-1 overflow-x-auto">
            {[
              { label: 'Home',          to: '/',        active: true  },
              { label: 'Catalog',       to: '/login'                  },
              { label: 'My Account',    to: '/login'                  },
              { label: 'Borrowed Books',to: '/login'                  },
              { label: 'History',       to: '/login'                  },
              { label: 'New Arrivals',  to: '/login'                  },
              { label: 'Help',          to: '/login'                  },
            ].map(n => (
              <Link key={n.label} to={n.to}
                className={`px-4 py-3 text-sm font-medium whitespace-nowrap border-b-2 transition-colors
                  ${n.active ? 'text-white border-blue-400' : 'text-slate-400 border-transparent hover:text-white hover:border-slate-500'}`}>
                {n.label}
              </Link>
            ))}
          </div>
        </nav>
      </header>

      {/* ── Hero ── */}
      <section className="bg-gradient-to-br from-slate-900 via-blue-950 to-slate-900 py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">

            {/* Main hero text */}
            <div className="lg:col-span-2 text-white">
              <span className="inline-flex items-center gap-2 bg-blue-500/20 border border-blue-400/30 text-blue-300 text-xs font-semibold px-3 py-1.5 rounded-full mb-5">
                <span className="w-1.5 h-1.5 rounded-full bg-blue-400 animate-pulse" />
                RUPP Library — Open to all students
              </span>
              <h1 className="text-4xl sm:text-5xl font-extrabold leading-tight mb-4">
                Welcome to<br/><span className="text-blue-400">Central Library</span>
              </h1>
              <p className="text-slate-300 text-lg mb-8 max-w-lg">
                Discover thousands of books, manage your loans, and explore new knowledge —
                all from one smart platform.
              </p>
              <div className="flex flex-wrap gap-3">
                <Link to="/register" className="bg-blue-600 hover:bg-blue-500 text-white font-bold px-8 py-3.5 rounded-2xl transition-all shadow-lg shadow-blue-900 hover:-translate-y-0.5">
                  Get started free →
                </Link>
                <Link to="/login" className="bg-white/10 hover:bg-white/20 border border-white/20 text-white font-bold px-8 py-3.5 rounded-2xl transition-all hover:-translate-y-0.5">
                  Sign in
                </Link>
              </div>

              {/* Stats */}
              <div className="flex flex-wrap gap-6 mt-10">
                {[{ v:'10+', l:'Books' }, { v:'3', l:'User Roles' }, { v:'14 days', l:'Loan Period' }, { v:'$0.50/day', l:'Fine Rate' }].map(s => (
                  <div key={s.l}>
                    <p className="text-2xl font-extrabold text-white">{s.v}</p>
                    <p className="text-slate-400 text-xs">{s.l}</p>
                  </div>
                ))}
              </div>
            </div>

            {/* Sidebar panel */}
            <div className="space-y-4">
              {/* Quick links */}
              <div className="bg-white/10 border border-white/10 rounded-2xl p-5">
                <h3 className="text-white font-bold mb-3">⚡ Quick Links</h3>
                <div className="space-y-2">
                  {[
                    { icon:'🔍', label:'Search Catalog',      to:'/login' },
                    { icon:'📥', label:'Reserve a Book',      to:'/login' },
                    { icon:'📋', label:'My Borrowing History',to:'/login' },
                    { icon:'📚', label:'New Arrivals',        to:'/login' },
                    { icon:'🏛️', label:'Reserve Study Room',  to:'/login' },
                    { icon:'💡', label:'Suggest a Book',      to:'/login' },
                  ].map(l => (
                    <Link key={l.label} to={l.to}
                      className="flex items-center gap-2.5 px-3 py-2 rounded-xl text-slate-300 hover:bg-white/10 hover:text-white transition-colors text-sm">
                      <span>{l.icon}</span>{l.label}
                    </Link>
                  ))}
                </div>
              </div>

              {/* Library events */}
              <div className="bg-white/10 border border-white/10 rounded-2xl p-5">
                <h3 className="text-white font-bold mb-3">📅 Upcoming Events</h3>
                <div className="space-y-3">
                  {LIBRARY_EVENTS.map(e => (
                    <div key={e.title} className="flex items-start gap-3">
                      <div className="bg-blue-600 text-white text-[10px] font-bold px-2 py-1 rounded-lg text-center flex-shrink-0 leading-tight">
                        {e.date.split(' ')[0]}<br/>{e.date.split(' ')[1]}
                      </div>
                      <div>
                        <p className="text-white text-xs font-semibold">{e.title}</p>
                        <p className="text-slate-400 text-[10px] mt-0.5">{e.time}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── New Arrivals ── */}
      <section className="py-12 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-8">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-2xl font-extrabold text-gray-900">📚 New Arrivals</h2>
              <p className="text-gray-400 text-sm mt-0.5">Recently added to the collection</p>
            </div>
            <Link to="/login" className="text-sm text-blue-600 font-semibold hover:underline">View all →</Link>
          </div>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-4">
            {NEW_ARRIVALS.map(b => (
              <Link to="/login" key={b.title}
                className="group bg-gray-50 rounded-2xl p-3 border border-gray-100 hover:shadow-lg hover:-translate-y-1 transition-all">
                <BookCover cover={b.cover} title={b.title} />
                <div className="mt-2">
                  <p className="text-xs font-bold text-gray-800 line-clamp-2 leading-snug">{b.title}</p>
                  <p className="text-[10px] text-gray-400 mt-0.5 truncate">{b.author}</p>
                  <span className="inline-block mt-1.5 text-[9px] font-bold px-2 py-0.5 rounded-full bg-blue-100 text-blue-700">{b.category}</span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ── Features ── */}
      <section className="py-12 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-8">
          <h2 className="text-2xl font-extrabold text-gray-900 text-center mb-8">Everything you need</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {[
              { icon:'🔍', title:'Smart Search',      desc:'Find any book by title, author, or ISBN instantly.' },
              { icon:'📥', title:'Easy Borrowing',    desc:'Request books online. Get notified when approved.' },
              { icon:'⏰', title:'Due Date Tracking', desc:'Never miss a return date with clear due date display.' },
              { icon:'📊', title:'Full Dashboard',    desc:'Track loans, fines, and history in one place.' },
            ].map(f => (
              <div key={f.title} className="bg-white rounded-2xl border border-gray-100 p-5 hover:shadow-md transition-shadow">
                <div className="text-3xl mb-3">{f.icon}</div>
                <h3 className="font-bold text-gray-900 mb-1">{f.title}</h3>
                <p className="text-sm text-gray-400">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── Demo accounts ── */}
      <section className="py-12 bg-blue-600">
        <div className="max-w-3xl mx-auto px-4 text-center">
          <h2 className="text-2xl font-extrabold text-white mb-2">Try a demo account</h2>
          <p className="text-blue-200 text-sm mb-6">Sign in instantly with one of these accounts</p>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-6">
            {[
              { role:'👑 Superadmin', email:'superadmin@library.com', pw:'admin123', bg:'bg-purple-500/30 border-purple-400/40' },
              { role:'📖 Librarian',  email:'admin@library.com',      pw:'admin123', bg:'bg-amber-500/30 border-amber-400/40'  },
              { role:'🎓 Student',    email:'user@library.com',        pw:'user123',  bg:'bg-blue-500/30 border-blue-400/40'   },
            ].map(d => (
              <Link key={d.role} to="/login"
                className={`border ${d.bg} rounded-2xl p-4 text-left hover:brightness-110 transition-all`}>
                <p className="text-white font-bold text-sm mb-2">{d.role}</p>
                <p className="text-blue-100 text-xs font-mono truncate">{d.email}</p>
                <p className="text-blue-200 text-xs font-mono mt-0.5">{d.pw}</p>
              </Link>
            ))}
          </div>
          <Link to="/register" className="inline-block bg-white text-blue-600 font-bold px-8 py-3 rounded-2xl text-sm hover:bg-blue-50 transition-colors">
            Or create your own account →
          </Link>
        </div>
      </section>

      <Footer />
    </div>
  );
}

/* ─────────────────────────────────────────────
   LOGGED-IN DASHBOARD
───────────────────────────────────────────── */
function LoggedInHome({ user }) {
  const { logout } = useAuth();
  const navigate   = useNavigate();
  const [loans, setLoans]       = useState([]);
  const [books, setBooks]       = useState([]);
  const [loading, setLoading]   = useState(true);
  const [search, setSearch]     = useState('');
  const [notifOpen, setNotifOpen] = useState(false);

  useEffect(() => {
    Promise.all([
      api.get('/api/loans/my'),
      api.get('/api/books', { params: { limit: 6 } }),
    ]).then(([lr, br]) => {
      setLoans(lr.data);
      setBooks(br.data.books || []);
    }).finally(() => setLoading(false));
  }, []);

  const activeLoans   = loans.filter(l => l.status === 'active');
  const pendingLoans  = loans.filter(l => l.status === 'pending');
  const overdueLoans  = loans.filter(l => l.is_overdue);

  const dashboard =
    user.role === 'superadmin' ? '/superadmin' :
    user.role === 'admin'      ? '/admin'      : '/user';

  const handleSearch = e => {
    e.preventDefault();
    navigate(`/user?search=${encodeURIComponent(search)}`);
  };

  return (
    <div className="min-h-screen bg-slate-50">

      {/* ── Header ── */}
      <header className="bg-slate-900 shadow-lg sticky top-0 z-40">
        <div className="max-w-7xl mx-auto px-4 sm:px-8 py-3 flex items-center gap-4">
          {/* Logo */}
          <Link to="/" className="flex items-center gap-2.5 flex-shrink-0">
            <div className="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center text-xl">📚</div>
            <div className="leading-none hidden sm:block">
              <p className="text-white font-extrabold text-sm">LibraryMS</p>
              <p className="text-slate-400 text-[10px]">RUPP</p>
            </div>
          </Link>

          {/* Search */}
          <form onSubmit={handleSearch}
            className="flex-1 max-w-xl mx-4 flex items-center gap-2 bg-white/10 border border-white/20 rounded-xl px-4 py-2 focus-within:border-blue-400 transition-colors">
            <svg className="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input value={search} onChange={e => setSearch(e.target.value)}
              placeholder="Search books by title, author, or ISBN…"
              className="flex-1 bg-transparent text-white placeholder-slate-400 text-sm outline-none" />
            <button type="submit" className="text-slate-400 hover:text-white transition-colors text-xs font-semibold flex-shrink-0">Search</button>
          </form>

          {/* Right: welcome + icons */}
          <div className="flex items-center gap-3 ml-auto flex-shrink-0">
            <p className="text-slate-300 text-sm hidden md:block">
              Welcome, <span className="text-white font-bold">{user.name?.split(' ')[0]}</span>
            </p>

            {/* Notifications */}
            <div className="relative">
              <button onClick={() => setNotifOpen(v => !v)}
                className="relative w-9 h-9 bg-white/10 hover:bg-white/20 rounded-xl flex items-center justify-center text-slate-300 transition-colors">
                🔔
                {(overdueLoans.length + pendingLoans.length) > 0 && (
                  <span className="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full text-[9px] font-bold text-white flex items-center justify-center">
                    {overdueLoans.length + pendingLoans.length}
                  </span>
                )}
              </button>
              {notifOpen && (
                <div className="absolute right-0 top-12 w-72 bg-white rounded-2xl shadow-2xl border border-gray-100 z-50 overflow-hidden">
                  <div className="px-4 py-3 border-b border-gray-100 font-bold text-gray-900 text-sm">Notifications</div>
                  <div className="divide-y divide-gray-50 max-h-64 overflow-y-auto">
                    {overdueLoans.length === 0 && pendingLoans.length === 0 ? (
                      <p className="px-4 py-4 text-sm text-gray-400 text-center">No new notifications</p>
                    ) : (
                      <>
                        {overdueLoans.map(l => (
                          <div key={l.id} className="px-4 py-3 flex items-start gap-2.5">
                            <span className="text-red-500">⚠️</span>
                            <div>
                              <p className="text-xs font-semibold text-gray-800">{l.title}</p>
                              <p className="text-[10px] text-red-500">Overdue — due {l.due_date}</p>
                            </div>
                          </div>
                        ))}
                        {pendingLoans.map(l => (
                          <div key={l.id} className="px-4 py-3 flex items-start gap-2.5">
                            <span>⏳</span>
                            <div>
                              <p className="text-xs font-semibold text-gray-800">{l.title}</p>
                              <p className="text-[10px] text-gray-400">Awaiting approval</p>
                            </div>
                          </div>
                        ))}
                      </>
                    )}
                  </div>
                </div>
              )}
            </div>

            {/* Settings */}
            <Link to={`${dashboard}/settings`}
              className="w-9 h-9 bg-white/10 hover:bg-white/20 rounded-xl flex items-center justify-center text-slate-300 transition-colors">
              ⚙️
            </Link>

            {/* Avatar */}
            <div className="w-9 h-9 bg-blue-600 rounded-xl flex items-center justify-center text-white font-bold text-sm flex-shrink-0">
              {user.name?.split(' ').map(w => w[0]).join('').slice(0,2).toUpperCase()}
            </div>
          </div>
        </div>

        {/* ── Nav bar ── */}
        <nav className="border-t border-white/10">
          <div className="max-w-7xl mx-auto px-4 sm:px-8 flex items-center gap-1 overflow-x-auto">
            {[
              { label: 'Home',           to: '/',            active: true },
              { label: 'Catalog',        to: '/user'                      },
              { label: 'My Account',     to: `${dashboard}/profile`       },
              { label: 'Borrowed Books', to: '/user/history'              },
              { label: 'History',        to: '/user/history'              },
              { label: 'New Arrivals',   to: '/user'                      },
              ...(user.role !== 'user' ? [{ label: 'Admin Panel', to: dashboard }] : []),
              { label: 'Help',           to: '/'                          },
            ].map(n => (
              <Link key={n.label} to={n.to}
                className={`px-4 py-3 text-sm font-medium whitespace-nowrap border-b-2 transition-colors
                  ${n.active ? 'text-white border-blue-400' : 'text-slate-400 border-transparent hover:text-white hover:border-slate-500'}`}>
                {n.label}
              </Link>
            ))}
            <button onClick={() => { logout(); navigate('/login'); }}
              className="ml-auto px-4 py-3 text-sm font-medium text-slate-400 border-b-2 border-transparent hover:text-red-400 whitespace-nowrap transition-colors">
              Sign out 🚪
            </button>
          </div>
        </nav>
      </header>

      {/* ── Main content ── */}
      <div className="max-w-7xl mx-auto px-4 sm:px-8 py-8">
        <div className="flex gap-7">

          {/* ── Left: main area ── */}
          <main className="flex-1 min-w-0 space-y-6">

            {/* Account summary */}
            <div>
              <h2 className="text-lg font-extrabold text-gray-900 mb-3">📋 My Account Summary</h2>
              <div className="grid grid-cols-3 gap-3">
                <StatWidget icon="📖" label="Active Loans"  value={loading ? '…' : activeLoans.length}  color="bg-blue-50 border-blue-200 text-blue-800"    to="/user/history" />
                <StatWidget icon="⏳" label="Reservations"  value={loading ? '…' : pendingLoans.length} color="bg-yellow-50 border-yellow-200 text-yellow-800" to="/user/history" />
                <StatWidget icon="⚠️" label="Overdue"       value={loading ? '…' : overdueLoans.length} color="bg-red-50 border-red-200 text-red-800"         to="/user/history" />
              </div>
            </div>

            {/* Current loans */}
            <div className="bg-white rounded-2xl border border-gray-200 p-5">
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-base font-extrabold text-gray-900">📚 Current Loans</h2>
                <Link to="/user/history" className="text-sm text-blue-600 hover:underline font-semibold">View all →</Link>
              </div>
              {loading ? (
                <div className="flex justify-center py-8"><div className="w-8 h-8 border-2 border-blue-200 border-t-blue-600 rounded-full animate-spin" /></div>
              ) : activeLoans.length === 0 ? (
                <div className="text-center py-8">
                  <p className="text-4xl mb-2">📭</p>
                  <p className="text-gray-400 text-sm">No active loans</p>
                  <Link to="/user" className="inline-block mt-3 btn-primary btn-sm rounded-xl">Browse books</Link>
                </div>
              ) : (
                <div className="space-y-3">
                  {activeLoans.slice(0,4).map(loan => (
                    <div key={loan.id} className={`flex items-center gap-4 p-3 rounded-xl border transition-colors
                      ${loan.is_overdue ? 'bg-red-50 border-red-200' : 'bg-gray-50 border-gray-100'}`}>
                      <div className="w-12 h-14 rounded-lg bg-gray-200 flex items-center justify-center text-2xl flex-shrink-0">📖</div>
                      <div className="flex-1 min-w-0">
                        <p className="font-semibold text-gray-900 text-sm truncate">{loan.title}</p>
                        <p className="text-xs text-gray-400 truncate">{loan.author}</p>
                        <div className="flex items-center gap-2 mt-1">
                          <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${STATUS_COLOR[loan.status]}`}>{loan.status}</span>
                          {loan.is_overdue && <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-red-100 text-red-600">⚠️ Overdue</span>}
                        </div>
                      </div>
                      <div className="text-right flex-shrink-0">
                        <p className="text-xs text-gray-400">Due</p>
                        <p className={`text-xs font-bold ${loan.is_overdue ? 'text-red-600' : 'text-gray-700'}`}>{loan.due_date || '—'}</p>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* New arrivals */}
            <div className="bg-white rounded-2xl border border-gray-200 p-5">
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-base font-extrabold text-gray-900">✨ New Arrivals</h2>
                <Link to="/user" className="text-sm text-blue-600 hover:underline font-semibold">Browse all →</Link>
              </div>
              {loading ? (
                <div className="grid grid-cols-3 sm:grid-cols-6 gap-3">
                  {Array(6).fill(0).map((_,i) => (
                    <div key={i} className="animate-pulse">
                      <div className="h-24 bg-gray-200 rounded-xl mb-2" />
                      <div className="h-3 bg-gray-100 rounded-full w-3/4" />
                    </div>
                  ))}
                </div>
              ) : (
                <div className="grid grid-cols-3 sm:grid-cols-6 gap-3">
                  {(books.length > 0 ? books : NEW_ARRIVALS).slice(0,6).map((b,i) => (
                    <Link to="/user" key={b.id || i}
                      className="group text-center hover:-translate-y-1 transition-transform">
                      <BookCover cover={b.cover_url || NEW_ARRIVALS[i]?.cover} title={b.title} />
                      <p className="text-[10px] font-semibold text-gray-700 mt-1.5 line-clamp-2 leading-snug">{b.title}</p>
                      <p className="text-[9px] text-gray-400 truncate">{b.author}</p>
                    </Link>
                  ))}
                </div>
              )}
            </div>

            {/* Activity feed */}
            <div className="bg-white rounded-2xl border border-gray-200 p-5">
              <h2 className="text-base font-extrabold text-gray-900 mb-4">🕐 Activity Feed</h2>
              {loading ? (
                <div className="space-y-3">{Array(3).fill(0).map((_,i) => <div key={i} className="h-10 bg-gray-100 rounded-xl animate-pulse" />)}</div>
              ) : loans.length === 0 ? (
                <p className="text-sm text-gray-400 text-center py-6">No recent activity</p>
              ) : (
                <div className="space-y-2">
                  {loans.slice(0,6).map(l => (
                    <div key={l.id} className="flex items-center gap-3 py-2.5 border-b border-gray-50 last:border-0">
                      <span className="text-lg flex-shrink-0">
                        {l.status==='active' ? '📖' : l.status==='returned' ? '✅' : l.status==='pending' ? '⏳' : '❌'}
                      </span>
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium text-gray-800 truncate">{l.title}</p>
                        <p className="text-xs text-gray-400">
                          {l.status==='active' ? `Borrowed on ${l.borrow_date}` :
                           l.status==='returned' ? `Returned on ${l.return_date}` :
                           l.status==='pending' ? 'Awaiting approval' : 'Request rejected'}
                        </p>
                      </div>
                      <span className={`text-[10px] font-bold px-2 py-0.5 rounded-full flex-shrink-0 ${STATUS_COLOR[l.status]}`}>{l.status}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </main>

          {/* ── Right: Sidebar ── */}
          <aside className="w-64 flex-shrink-0 hidden lg:block space-y-5">

            {/* User card */}
            <div className="bg-slate-900 rounded-2xl p-4 text-white">
              <div className="w-14 h-14 bg-blue-600 rounded-2xl flex items-center justify-center text-2xl font-bold mx-auto mb-3">
                {user.name?.split(' ').map(w=>w[0]).join('').slice(0,2).toUpperCase()}
              </div>
              <p className="text-center font-bold truncate">{user.name}</p>
              <p className="text-center text-slate-400 text-xs truncate mt-0.5">{user.email}</p>
              <div className="mt-3 text-center">
                <span className={`text-xs font-bold px-3 py-1 rounded-full
                  ${user.role==='superadmin' ? 'bg-purple-500/30 text-purple-300' :
                    user.role==='admin'      ? 'bg-amber-500/30 text-amber-300' :
                                               'bg-blue-500/30 text-blue-300'}`}>
                  {user.role==='superadmin' ? '👑 Director' : user.role==='admin' ? '📖 Librarian' : '🎓 Student'}
                </span>
              </div>
              <Link to={`${dashboard}/profile`}
                className="block mt-3 text-center bg-white/10 hover:bg-white/20 text-white text-xs font-semibold py-2 rounded-xl transition-colors">
                View Profile
              </Link>
            </div>

            {/* Quick links */}
            <div className="bg-white rounded-2xl border border-gray-200 p-4">
              <h3 className="font-bold text-gray-900 text-sm mb-3">⚡ Quick Links</h3>
              <div className="space-y-1">
                {[
                  { icon:'🔍', label:'Browse Catalog',    to:'/user'            },
                  { icon:'📋', label:'My Borrowings',     to:'/user/history'    },
                  { icon:'👤', label:'My Profile',        to:`${dashboard}/profile` },
                  { icon:'⚙️', label:'Settings',          to:`${dashboard}/settings` },
                  ...(user.role!=='user' ? [{ icon:'📊', label:'Admin Dashboard', to:dashboard }] : []),
                ].map(l => (
                  <Link key={l.label} to={l.to}
                    className="flex items-center gap-2.5 px-3 py-2 rounded-xl text-gray-600 hover:bg-blue-50 hover:text-blue-700 text-sm transition-colors">
                    <span>{l.icon}</span>{l.label}
                  </Link>
                ))}
              </div>
            </div>

            {/* Library events */}
            <div className="bg-white rounded-2xl border border-gray-200 p-4">
              <h3 className="font-bold text-gray-900 text-sm mb-3">📅 Upcoming Events</h3>
              <div className="space-y-3">
                {LIBRARY_EVENTS.map(e => (
                  <div key={e.title} className="flex items-start gap-3">
                    <div className="bg-blue-600 text-white text-[10px] font-bold px-2 py-1 rounded-lg text-center flex-shrink-0 leading-tight min-w-[36px]">
                      <span className="block">{e.date.split(' ')[0]}</span>
                      <span className="block">{e.date.split(' ')[1]}</span>
                    </div>
                    <div>
                      <p className="text-xs font-semibold text-gray-800">{e.title}</p>
                      <p className="text-[10px] text-gray-400">{e.time}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>

          </aside>
        </div>
      </div>

      <Footer />
    </div>
  );
}

/* ─────────────────────────────────────────────
   FOOTER
───────────────────────────────────────────── */
function Footer() {
  return (
    <footer className="bg-slate-900 text-slate-400 py-10 mt-8">
      <div className="max-w-7xl mx-auto px-4 sm:px-8">
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-8 mb-8">
          {/* Contact */}
          <div>
            <h4 className="text-white font-bold mb-3">📍 Contact Info</h4>
            <div className="space-y-1.5 text-sm">
              <p>Royal University of Phnom Penh</p>
              <p>Russian Federation Blvd, Phnom Penh</p>
              <p>📞 +855 23 883 640</p>
              <p>✉️ library@rupp.edu.kh</p>
            </div>
          </div>
          {/* Hours */}
          <div>
            <h4 className="text-white font-bold mb-3">🕐 Hours of Operation</h4>
            <div className="space-y-1.5 text-sm">
              <div className="flex justify-between"><span>Monday – Friday</span><span className="text-white">7:00 AM – 6:00 PM</span></div>
              <div className="flex justify-between"><span>Saturday</span><span className="text-white">8:00 AM – 4:00 PM</span></div>
              <div className="flex justify-between"><span>Sunday</span><span className="text-red-400">Closed</span></div>
            </div>
          </div>
          {/* Quick nav */}
          <div>
            <h4 className="text-white font-bold mb-3">🔗 Quick Navigation</h4>
            <div className="space-y-1.5 text-sm">
              {[['Home','/'],['Book Catalog','/user'],['Sign In','/login'],['Register','/register']].map(([l,t]) => (
                <Link key={l} to={t} className="block hover:text-white transition-colors">{l}</Link>
              ))}
            </div>
          </div>
        </div>
        <div className="border-t border-slate-800 pt-6 flex flex-col sm:flex-row items-center justify-between gap-2">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center text-sm">📚</div>
            <span className="text-white font-bold text-sm">LibraryMS</span>
            <span className="text-slate-500 text-xs">— RUPP Library Management System</span>
          </div>
          <p className="text-slate-600 text-xs">© {new Date().getFullYear()} Royal University of Phnom Penh. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
}

/* ─────────────────────────────────────────────
   ROOT
───────────────────────────────────────────── */
export default function Home() {
  const { user } = useAuth();
  return user ? <LoggedInHome user={user} /> : <PublicHome />;
}
