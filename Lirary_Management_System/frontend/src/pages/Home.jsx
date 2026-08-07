<<<<<<< HEAD
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ROLE_HOME = { superadmin: '/superadmin', admin: '/admin', user: '/user' };

const NAV_LINKS = ['Features', 'Roles', 'About'];

const FEATURES = [
  { icon: '🔍', title: 'Smart Search',    desc: 'Find books by title, author, ISBN, or category instantly.' },
  { icon: '📖', title: 'Easy Borrowing',  desc: 'Submit a borrow request in one click and track its status.' },
  { icon: '📋', title: 'Loan History',    desc: 'View all your active loans, due dates, and past returns.' },
  { icon: '⚡', title: 'Fast Approvals',  desc: 'Admins approve or reject requests in real-time.' },
  { icon: '💰', title: 'Fine Tracking',   desc: 'Automatic overdue fine calculation with payment tracking.' },
  { icon: '📊', title: 'Analytics',       desc: 'Directors see live stats, popular books, and user activity.' },
];

const ROLES = [
  {
    icon: '🎓', tag: 'Student', tagColor: 'bg-blue-100 text-blue-700',
    title: 'Student Portal',
    desc: 'Browse, borrow, and manage your reading from one dashboard.',
    items: ['Search & browse books', 'Submit borrow requests', 'Track due dates & fines', 'Full borrowing history'],
    cta: '/register', ctaLabel: 'Register as Student',
    roleKey: 'user',
  },
  {
    icon: '📖', tag: 'Librarian', tagColor: 'bg-amber-100 text-amber-700',
    title: 'Admin Panel',
    desc: 'Manage the catalog, approve loans, and keep the library running.',
    items: ['Add & edit books', 'Approve or reject requests', 'Issue & process returns', 'Monitor all loans'],
    cta: '/login', ctaLabel: 'Sign In as Admin',
    roleKey: 'admin',
  },
  {
    icon: '👑', tag: 'Director', tagColor: 'bg-purple-100 text-purple-700',
    title: 'Superadmin View',
    desc: 'Full system control — analytics, users, and library-wide reports.',
    items: ['System-wide statistics', 'Manage all users', 'Overdue & fine reports', 'Most borrowed books'],
    cta: '/login', ctaLabel: 'Sign In as Director',
    roleKey: 'superadmin',
  },
];

/* Book covers from seeded data */
const BOOK_COVERS = [
  { isbn: '9780743273565', title: 'The Great Gatsby' },
  { isbn: '9780451524935', title: '1984' },
  { isbn: '9780132350884', title: 'Clean Code' },
  { isbn: '9780062316097', title: 'Sapiens' },
  { isbn: '9780441013593', title: 'Dune' },
  { isbn: '9780735211292', title: 'Atomic Habits' },
];

export default function Home() {
  const { user } = useAuth();
  const dashPath = user ? (ROLE_HOME[user.role] || '/user') : null;

  return (
    <div className="min-h-screen bg-white font-sans">

      {/* ── Navbar ── */}
      <nav className="bg-white border-b border-gray-100 sticky top-0 z-50">
        <div className="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between gap-6">

          {/* Logo */}
          <div className="flex items-center gap-3 flex-shrink-0">
            <div className="w-10 h-10 rounded-full bg-amber-500 flex items-center justify-center text-white font-extrabold text-sm select-none">
              LMS
            </div>
            <div className="leading-tight">
              <p className="font-extrabold text-gray-900 text-base leading-none">LibraryMS</p>
              <p className="text-[10px] text-amber-600 font-semibold">Excellence in Learning</p>
            </div>
          </div>

          {/* Center nav */}
          <div className="hidden md:flex items-center gap-7">
            {NAV_LINKS.map(n => (
              <a key={n} href={`#${n.toLowerCase()}`}
                className="text-sm text-gray-500 hover:text-gray-900 font-medium transition-colors">
                {n}
              </a>
            ))}
          </div>

          {/* CTA */}
          <div className="flex items-center gap-2 flex-shrink-0">
            {user ? (
              <Link to={dashPath}
                className="bg-amber-500 hover:bg-amber-600 text-white text-sm font-bold px-5 py-2 rounded-full transition-colors">
                Dashboard →
              </Link>
            ) : (
              <>
                <Link to="/login"
                  className="text-sm font-semibold text-gray-600 hover:text-gray-900 px-4 py-2 transition-colors">
                  Sign In
                </Link>
                <Link to="/register"
                  className="bg-amber-500 hover:bg-amber-600 text-white text-sm font-bold px-5 py-2 rounded-full transition-colors">
                  Apply Now
                </Link>
              </>
            )}
          </div>
        </div>
      </nav>

      {/* ── Hero ── */}
      <section className="bg-amber-50">
        <div className="max-w-6xl mx-auto px-6 py-16 lg:py-24 flex flex-col lg:flex-row items-center gap-12">

          {/* Left — text */}
          <div className="flex-1 min-w-0">
            <div className="inline-flex items-center gap-2 bg-amber-100 text-amber-700 text-xs font-semibold px-3 py-1.5 rounded-full mb-6">
              🏫 Royal University of Phnom Penh
            </div>

            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold text-gray-900 leading-[1.1] mb-4">
              We don&apos;t just<br />
              <span className="text-amber-500">read books.</span>
            </h1>

            <p className="text-gray-500 text-lg leading-relaxed max-w-md mb-8">
              At RUPP Library, we shape curious minds, nurture brilliance,
              and build tomorrow's leaders — one book at a time.
            </p>

            <div className="flex flex-wrap gap-3">
              {user ? (
                <Link to={dashPath}
                  className="inline-flex items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white font-bold px-7 py-3.5 rounded-full transition-colors text-sm shadow-lg shadow-amber-200">
                  Open My Dashboard →
                </Link>
              ) : (
                <>
                  <Link to="/register"
                    className="inline-flex items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white font-bold px-7 py-3.5 rounded-full transition-colors text-sm shadow-lg shadow-amber-200">
                    Get Started →
                  </Link>
                  <Link to="/login"
                    className="inline-flex items-center gap-2 border-2 border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white font-bold px-7 py-3.5 rounded-full transition-colors text-sm">
                    📖 Browse Books
                  </Link>
                </>
              )}
            </div>

            {/* Stats */}
            <div className="flex flex-wrap gap-8 mt-12 pt-8 border-t border-amber-200">
              {[
                { v: '10 000+', l: 'Books' },
                { v: '3',       l: 'User Roles' },
                { v: '14 Days', l: 'Loan Period' },
                { v: 'Free',    l: 'For Students' },
              ].map(s => (
                <div key={s.l}>
                  <p className="text-2xl font-extrabold text-gray-900">{s.v}</p>
                  <p className="text-sm text-gray-500">{s.l}</p>
                </div>
              ))}
            </div>
          </div>

          {/* Right — book covers grid */}
          <div className="flex-shrink-0 w-full max-w-sm lg:max-w-md">
            <div className="bg-white rounded-3xl shadow-xl p-6 border border-amber-100">
              <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest mb-4">
                Featured Books
              </p>
              <div className="grid grid-cols-3 gap-3">
                {BOOK_COVERS.map(b => (
                  <div key={b.isbn} className="rounded-xl overflow-hidden bg-gray-100 aspect-[2/3] shadow-sm">
                    <img
                      src={`https://covers.openlibrary.org/b/isbn/${b.isbn}-M.jpg`}
                      alt={b.title}
                      className="w-full h-full object-cover"
                      onError={e => {
                        e.target.style.display = 'none';
                        e.target.parentNode.innerHTML = '<div class="w-full h-full flex items-center justify-center text-3xl bg-amber-50">📖</div>';
                      }}
                    />
                  </div>
                ))}
              </div>
              <div className="mt-4 flex items-center justify-between">
                <p className="text-sm text-gray-500">10,000+ books available</p>
                <Link to="/login" className="text-xs font-bold text-amber-600 hover:underline">View all →</Link>
              </div>
=======
import { useState } from 'react';
import { Link, Navigate, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Library, BookOpen, Search, ArrowDownToLine, Clock, BarChart3, Globe, Phone, Mail, Link2, Send } from 'lucide-react';

/* ── Static data ─────────────────────────────────────────────── */
const BOOKS = [
  { title: 'The Great Gatsby',        author: 'F. Scott Fitzgerald', cover: 'https://covers.openlibrary.org/b/isbn/9780743273565-M.jpg', category: 'Fiction'      },
  { title: '1984',                     author: 'George Orwell',        cover: 'https://covers.openlibrary.org/b/isbn/9780451524935-M.jpg', category: 'Fiction'      },
  { title: 'Clean Code',               author: 'Robert C. Martin',     cover: 'https://covers.openlibrary.org/b/isbn/9780132350884-M.jpg', category: 'CS'           },
  { title: 'Atomic Habits',            author: 'James Clear',           cover: 'https://covers.openlibrary.org/b/isbn/9780735211292-M.jpg', category: 'Self-Help'   },
  { title: 'Dune',                     author: 'Frank Herbert',          cover: 'https://covers.openlibrary.org/b/isbn/9780441013593-M.jpg', category: 'Sci-Fi'     },
  { title: 'The Pragmatic Programmer', author: 'David Thomas',           cover: 'https://covers.openlibrary.org/b/isbn/9780135957059-M.jpg', category: 'CS'         },
];

const EVENTS = [
  { month: 'JUN', day: '10', title: 'Reading Club Meeting',  time: '3:00 PM',  color: 'bg-blue-500'    },
  { month: 'JUN', day: '14', title: 'New Books Showcase',    time: '10:00 AM', color: 'bg-emerald-500' },
  { month: 'JUN', day: '18', title: 'Study Skills Workshop', time: '2:00 PM',  color: 'bg-violet-500'  },
  { month: 'JUN', day: '22', title: 'Digital Library Tour',  time: '11:00 AM', color: 'bg-amber-500'   },
];

const FEATURES = [
  { icon: <Search className="w-6 h-6 text-white" />,          title: 'Smart Search',       desc: 'Find any book instantly by title, author, or ISBN across the entire collection.',  grad: 'from-blue-500 to-cyan-500'     },
  { icon: <ArrowDownToLine className="w-6 h-6 text-white" />, title: 'Easy Borrowing',     desc: 'Request books online in seconds. Get notified the moment your request is approved.', grad: 'from-violet-500 to-purple-500' },
  { icon: <Clock className="w-6 h-6 text-white" />,           title: 'Due Date Tracking',  desc: 'Never miss a return. Clear due-date display with automatic overdue alerts.',         grad: 'from-amber-500 to-orange-500'  },
  { icon: <BarChart3 className="w-6 h-6 text-white" />,       title: 'Personal Dashboard', desc: 'Track all your loans, fines, and history from one clean, unified dashboard.',        grad: 'from-emerald-500 to-teal-500'  },
];

const HOW_IT_WORKS = [
  { step: '01', title: 'Create an Account', desc: 'Register for free in under a minute. No paperwork needed.' },
  { step: '02', title: 'Browse the Catalog', desc: 'Search thousands of books by title, author, category, or ISBN.' },
  { step: '03', title: 'Request a Book', desc: 'Click "Borrow" and a librarian will process your request.' },
  { step: '04', title: 'Pick Up & Return', desc: 'Collect from the library desk and return before your due date.' },
];


/* ── Book cover component ─────────────────────────────────────── */
function Cover({ src, title }) {
  const [err, setErr] = useState(false);
  return (
    <div className="w-full rounded-xl overflow-hidden bg-gradient-to-br from-slate-700 to-slate-900 shadow-lg"
      style={{ paddingTop: '148%', position: 'relative' }}>
      <div className="absolute inset-0">
        {src && !err
          ? <img src={src} alt={title} className="w-full h-full object-cover" onError={() => setErr(true)} />
          : <div className="w-full h-full flex items-center justify-center opacity-20"><BookOpen className="w-8 h-8 text-white" /></div>}
      </div>
    </div>
  );
}

/* ── Public landing page ──────────────────────────────────────── */
function PublicHome() {
  const [search, setSearch] = useState('');
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-white">

      {/* ━━━━━━━━━━━━━━ NAVBAR ━━━━━━━━━━━━━━ */}
      <header className="sticky top-0 z-50 bg-slate-900/95 backdrop-blur border-b border-white/5 shadow-xl">
        <div className="max-w-7xl mx-auto px-4 sm:px-8 h-16 flex items-center gap-4">

          {/* Logo */}
          <Link to="/" className="flex items-center gap-2.5 flex-shrink-0">
            <div className="w-9 h-9 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg shadow-blue-900/50">
              <Library className="w-5 h-5 text-white" />
            </div>
            <div className="leading-tight hidden sm:block">
              <p className="text-white font-extrabold text-sm tracking-tight">LibraryMS</p>
              <p className="text-slate-500 text-[10px] leading-none">RUPP · Central Library</p>
            </div>
          </Link>

          {/* Search */}
          <form
            onSubmit={e => { e.preventDefault(); navigate('/login'); }}
            className="flex-1 max-w-lg mx-6 hidden md:flex items-center gap-2
              bg-white/5 border border-white/10 rounded-xl px-3.5 py-2
              focus-within:bg-white/10 focus-within:border-blue-500/50 transition-all"
          >
            <svg className="w-4 h-4 text-slate-400 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input
              value={search} onChange={e => setSearch(e.target.value)}
              placeholder="Search books, authors, ISBN…"
              className="flex-1 bg-transparent text-white placeholder-slate-500 text-sm outline-none"
            />
          </form>

          {/* Nav links */}
          <nav className="hidden lg:flex items-center gap-1 mr-2">
            {['Features', 'Catalog', 'Events'].map(n => (
              <Link key={n} to="/login"
                className="px-3 py-1.5 text-sm text-slate-400 hover:text-white rounded-lg hover:bg-white/5 transition-colors">
                {n}
              </Link>
            ))}
          </nav>

          {/* CTA */}
          <div className="flex items-center gap-2 ml-auto">
            <Link to="/login"
              className="text-slate-300 hover:text-white text-sm font-medium px-3 py-1.5 rounded-lg hover:bg-white/5 transition-colors">
              Sign in
            </Link>
            <Link to="/register"
              className="bg-blue-600 hover:bg-blue-500 active:bg-blue-700 text-white text-sm font-bold px-4 py-1.5 rounded-xl transition-colors shadow-lg shadow-blue-900/40">
              Get Started
            </Link>
          </div>
        </div>
      </header>

      {/* ━━━━━━━━━━━━━━ HERO ━━━━━━━━━━━━━━ */}
      <section className="relative overflow-hidden"
        style={{ background: 'linear-gradient(135deg, #0f1b4c 0%, #1e1b6e 40%, #0f172a 100%)' }}>

        {/* Background texture */}
        <div className="absolute inset-0 opacity-[0.03] pointer-events-none"
          style={{ backgroundImage: 'radial-gradient(circle at 1px 1px, white 1px, transparent 0)', backgroundSize: '32px 32px' }}/>
        {/* Glow blobs */}
        <div className="absolute top-0 left-1/4 w-96 h-96 bg-blue-600/20 rounded-full blur-3xl pointer-events-none"/>
        <div className="absolute bottom-0 right-1/4 w-80 h-80 bg-violet-600/15 rounded-full blur-3xl pointer-events-none"/>

        <div className="relative max-w-7xl mx-auto px-4 sm:px-8 py-20 lg:py-28">
          <div className="grid grid-cols-1 lg:grid-cols-5 gap-12 items-center">

            {/* Left: headline */}
            <div className="lg:col-span-3 text-white">
              <div className="inline-flex items-center gap-2 bg-blue-500/10 border border-blue-400/20 text-blue-300
                text-xs font-semibold px-3 py-1.5 rounded-full mb-6">
                <span className="w-1.5 h-1.5 rounded-full bg-blue-400 animate-pulse"/>
                Royal University of Phnom Penh — Open to all students
              </div>

              <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold leading-[1.1] tracking-tight mb-5">
                Your Gateway to<br/>
                <span className="bg-gradient-to-r from-blue-400 to-cyan-400 bg-clip-text text-transparent">
                  Endless Knowledge
                </span>
              </h1>

              <p className="text-slate-400 text-lg leading-relaxed mb-8 max-w-xl">
                Discover thousands of books, manage your loans online, and stay on top of due dates —
                all from one modern library platform built for RUPP students.
              </p>

              <div className="flex flex-wrap gap-3 mb-12">
                <Link to="/register"
                  className="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-500 active:scale-95
                    text-white font-bold px-7 py-3.5 rounded-2xl transition-all shadow-xl shadow-blue-900/40">
                  Start for free
                  <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                    <path strokeLinecap="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3"/>
                  </svg>
                </Link>
                <Link to="/login"
                  className="inline-flex items-center gap-2 bg-white/8 hover:bg-white/15 border border-white/10
                    text-white font-bold px-7 py-3.5 rounded-2xl transition-all">
                  Sign in
                </Link>
              </div>

              {/* Stats */}
              <div className="flex flex-wrap gap-8">
                {[
                  { value: '500+', label: 'Books Available' },
                  { value: '14 days', label: 'Loan Period'  },
                  { value: '3',       label: 'Access Levels' },
                  { value: '24/7',    label: 'Online Access' },
                ].map(s => (
                  <div key={s.label}>
                    <p className="text-2xl font-extrabold text-white">{s.value}</p>
                    <p className="text-slate-500 text-xs mt-0.5">{s.label}</p>
                  </div>
                ))}
              </div>
            </div>

            {/* Right: book grid */}
            <div className="lg:col-span-2 hidden lg:grid grid-cols-3 gap-3">
              {BOOKS.map((b, i) => (
                <div key={b.title}
                  className={`hover:-translate-y-2 transition-transform duration-300`}
                  style={{ transitionDelay: `${i * 60}ms` }}>
                  <Cover src={b.cover} title={b.title} />
                </div>
              ))}
>>>>>>> testing
            </div>
          </div>
        </div>
      </section>

<<<<<<< HEAD
      {/* ── Features ── */}
      <section id="features" className="py-20 bg-white">
        <div className="max-w-6xl mx-auto px-6">
          <div className="text-center mb-12">
            <span className="text-xs font-bold text-amber-600 uppercase tracking-widest">Features</span>
            <h2 className="text-3xl font-extrabold text-gray-900 mt-2">Everything you need</h2>
            <p className="text-gray-400 mt-2 text-sm">All the tools for students, librarians, and directors.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {FEATURES.map(f => (
              <div key={f.title} className="group p-6 rounded-2xl border border-gray-100 hover:border-amber-200 hover:bg-amber-50 transition-all">
                <div className="w-12 h-12 rounded-2xl bg-amber-100 flex items-center justify-center text-2xl mb-4 group-hover:bg-amber-200 transition-colors">
                  {f.icon}
                </div>
                <h3 className="font-bold text-gray-900 mb-1">{f.title}</h3>
=======
      {/* ━━━━━━━━━━━━━━ MARQUEE STRIP ━━━━━━━━━━━━━━ */}
      <div className="bg-blue-600 py-3 overflow-hidden">
        <div className="flex gap-8 whitespace-nowrap animate-[marquee_20s_linear_infinite]">
          {Array(3).fill(['Free Access', 'Secure Platform', 'RUPP Students', 'Instant Requests', 'Smart Reminders', 'Online 24/7']).flat().map((t, i) => (
            <span key={i} className="text-blue-100 text-sm font-semibold flex-shrink-0">{t}</span>
          ))}
        </div>
      </div>

      {/* ━━━━━━━━━━━━━━ FEATURES ━━━━━━━━━━━━━━ */}
      <section className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-8">
          <div className="text-center mb-12">
            <span className="text-blue-600 text-sm font-bold uppercase tracking-widest">Features</span>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-gray-900 mt-2">Everything you need</h2>
            <p className="text-gray-400 mt-3 max-w-lg mx-auto">A complete library management experience built for modern students and librarians.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
            {FEATURES.map(f => (
              <div key={f.title}
                className="bg-white rounded-2xl p-6 border border-gray-100 shadow-sm hover:shadow-lg hover:-translate-y-1 transition-all duration-300 group">
                <div className={`w-12 h-12 rounded-2xl bg-gradient-to-br ${f.grad} flex items-center justify-center mb-4 shadow-lg
                  group-hover:scale-110 transition-transform`}>
                  {f.icon}
                </div>
                <h3 className="font-extrabold text-gray-900 mb-2">{f.title}</h3>
>>>>>>> testing
                <p className="text-sm text-gray-500 leading-relaxed">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

<<<<<<< HEAD
      {/* ── Roles ── */}
      <section id="roles" className="py-20 bg-gray-50">
        <div className="max-w-6xl mx-auto px-6">
          <div className="text-center mb-12">
            <span className="text-xs font-bold text-amber-600 uppercase tracking-widest">Roles</span>
            <h2 className="text-3xl font-extrabold text-gray-900 mt-2">Built for every role</h2>
            <p className="text-gray-400 mt-2 text-sm">One platform, three tailored experiences.</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
            {ROLES.map(r => {
              const isMyRole = user?.role === r.roleKey;
              const ctaTo   = user ? dashPath : r.cta;
              const ctaText = user ? (isMyRole ? 'Open My Dashboard →' : 'Go to Dashboard') : r.ctaLabel;

              return (
                <div key={r.tag}
                  className={`bg-white rounded-2xl p-6 flex flex-col gap-4 border transition-all
                    ${isMyRole ? 'border-amber-300 shadow-lg shadow-amber-100' : 'border-gray-200 hover:border-amber-200 hover:shadow-sm'}`}>

                  {isMyRole && (
                    <div className="text-xs font-bold text-amber-600 bg-amber-50 px-2.5 py-1 rounded-full w-fit">
                      ✓ Your Role
                    </div>
                  )}

                  <div className="flex items-center gap-3">
                    <span className="text-3xl">{r.icon}</span>
                    <div>
                      <span className={`badge text-[10px] ${r.tagColor}`}>{r.tag}</span>
                      <p className="font-bold text-gray-900 text-sm mt-0.5">{r.title}</p>
                    </div>
                  </div>

                  <p className="text-sm text-gray-500 leading-relaxed">{r.desc}</p>

                  <ul className="space-y-2 flex-1">
                    {r.items.map(item => (
                      <li key={item} className="flex items-center gap-2 text-sm text-gray-600">
                        <span className="w-4 h-4 rounded-full bg-amber-100 text-amber-600 flex items-center justify-center text-[10px] font-bold flex-shrink-0">✓</span>
                        {item}
                      </li>
                    ))}
                  </ul>

                  <Link to={ctaTo}
                    className={`mt-2 w-full text-center py-2.5 rounded-full text-sm font-bold transition-all
                      ${isMyRole
                        ? 'bg-amber-500 text-white hover:bg-amber-600'
                        : 'bg-gray-100 text-gray-700 hover:bg-amber-50 hover:text-amber-700'}`}>
                    {ctaText}
                  </Link>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* ── CTA Banner ── */}
      <section id="about" className="py-20 bg-amber-500">
        <div className="max-w-2xl mx-auto px-6 text-center">
          <span className="text-4xl">📚</span>
          <h2 className="text-3xl font-extrabold text-white mt-4 mb-3">Ready to get started?</h2>
          <p className="text-amber-100 mb-8 text-sm leading-relaxed">
            Join RUPP students already using LibraryMS to discover, borrow, and manage their reading.
          </p>
          {user ? (
            <Link to={dashPath}
              className="inline-flex items-center gap-2 bg-white text-amber-600 font-extrabold px-8 py-3.5 rounded-full hover:bg-amber-50 transition-colors shadow-lg">
              Open Dashboard →
            </Link>
          ) : (
            <div className="flex flex-col sm:flex-row gap-3 justify-center">
              <Link to="/register"
                className="inline-flex items-center justify-center gap-2 bg-white text-amber-600 font-extrabold px-8 py-3.5 rounded-full hover:bg-amber-50 transition-colors shadow-lg">
                Create Free Account
              </Link>
              <Link to="/login"
                className="inline-flex items-center justify-center gap-2 border-2 border-white text-white font-bold px-8 py-3.5 rounded-full hover:bg-amber-600 transition-colors">
                Sign In
              </Link>
            </div>
          )}
        </div>
      </section>

      {/* ── Footer ── */}
      <footer className="bg-white border-t border-gray-100 py-8">
        <div className="max-w-6xl mx-auto px-6 flex flex-col sm:flex-row items-center justify-between gap-4 text-sm text-gray-400">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-full bg-amber-500 flex items-center justify-center text-white font-extrabold text-xs">
              LMS
            </div>
            <span className="font-semibold text-gray-600">LibraryMS</span>
            <span>· Royal University of Phnom Penh</span>
          </div>
          <div className="flex gap-5">
            <Link to="/login"    className="hover:text-gray-600 transition">Sign In</Link>
            <Link to="/register" className="hover:text-gray-600 transition">Register</Link>
          </div>
          <p>© {new Date().getFullYear()} LibraryMS — RUPP</p>
=======
      {/* ━━━━━━━━━━━━━━ BOOK CATALOG PREVIEW ━━━━━━━━━━━━━━ */}
      <section className="py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-8">
          <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-10">
            <div>
              <span className="text-blue-600 text-sm font-bold uppercase tracking-widest">Collection</span>
              <h2 className="text-3xl sm:text-4xl font-extrabold text-gray-900 mt-1">New Arrivals</h2>
              <p className="text-gray-400 mt-1">Recently added to our library collection</p>
            </div>
            <Link to="/login"
              className="inline-flex items-center gap-2 text-sm font-bold text-blue-600 hover:text-blue-500 transition-colors flex-shrink-0">
              Browse all books
              <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                <path strokeLinecap="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3"/>
              </svg>
            </Link>
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-5">
            {BOOKS.map(b => (
              <Link to="/login" key={b.title}
                className="group hover:-translate-y-2 transition-transform duration-300">
                <Cover src={b.cover} title={b.title} />
                <div className="mt-3">
                  <p className="text-xs font-bold text-gray-800 line-clamp-2 leading-snug">{b.title}</p>
                  <p className="text-[10px] text-gray-400 truncate mt-0.5">{b.author}</p>
                  <span className="inline-block mt-1.5 text-[9px] font-bold px-2 py-0.5 rounded-full bg-blue-100 text-blue-700">
                    {b.category}
                  </span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ━━━━━━━━━━━━━━ HOW IT WORKS ━━━━━━━━━━━━━━ */}
      <section className="py-20 bg-slate-50">
        <div className="max-w-5xl mx-auto px-4 sm:px-8">
          <div className="text-center mb-12">
            <span className="text-blue-600 text-sm font-bold uppercase tracking-widest">Process</span>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-gray-900 mt-2">How it works</h2>
            <p className="text-gray-400 mt-3">Borrowing a book takes less than 2 minutes.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {HOW_IT_WORKS.map((s, i) => (
              <div key={s.step} className="relative">
                {/* Connector line */}
                {i < HOW_IT_WORKS.length - 1 && (
                  <div className="hidden lg:block absolute top-7 left-full w-full h-px bg-gradient-to-r from-blue-200 to-transparent z-0"/>
                )}
                <div className="relative z-10">
                  <div className="w-14 h-14 rounded-2xl bg-white border-2 border-blue-100 shadow-md flex items-center justify-center mb-4">
                    <span className="text-blue-600 font-extrabold text-lg">{s.step}</span>
                  </div>
                  <h3 className="font-extrabold text-gray-900 mb-1">{s.title}</h3>
                  <p className="text-sm text-gray-500 leading-relaxed">{s.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ━━━━━━━━━━━━━━ UPCOMING EVENTS ━━━━━━━━━━━━━━ */}
      <section className="py-20 bg-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-8">
          <div className="text-center mb-10">
            <span className="text-blue-600 text-sm font-bold uppercase tracking-widest">Events</span>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-gray-900 mt-2">Upcoming Library Events</h2>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {EVENTS.map(e => (
              <div key={e.title}
                className="flex items-center gap-4 bg-gray-50 border border-gray-100 rounded-2xl p-4 hover:shadow-md transition-shadow">
                <div className={`${e.color} text-white rounded-xl p-3 flex flex-col items-center flex-shrink-0 min-w-[52px]`}>
                  <span className="text-[10px] font-bold opacity-80">{e.month}</span>
                  <span className="text-xl font-extrabold leading-none">{e.day}</span>
                </div>
                <div>
                  <p className="font-bold text-gray-900">{e.title}</p>
                  <p className="text-sm text-gray-400 mt-0.5">{e.time}</p>
                </div>
                <Link to="/login"
                  className="ml-auto text-xs font-bold text-blue-600 hover:text-blue-500 flex-shrink-0 transition-colors">
                  Register →
                </Link>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ━━━━━━━━━━━━━━ CTA BANNER ━━━━━━━━━━━━━━ */}
      <section className="py-16 bg-blue-600">
        <div className="max-w-3xl mx-auto px-4 text-center">
          <h2 className="text-3xl sm:text-4xl font-extrabold text-white mb-3">
            Ready to start reading?
          </h2>
          <p className="text-blue-200 mb-8">Join thousands of RUPP students already using LibraryMS.</p>
          <div className="flex flex-wrap justify-center gap-3">
            <Link to="/register"
              className="bg-white text-blue-600 hover:bg-blue-50 font-extrabold px-8 py-3.5 rounded-2xl transition-colors shadow-xl">
              Create free account
            </Link>
            <Link to="/login"
              className="bg-blue-700 hover:bg-blue-800 border border-blue-500 text-white font-bold px-8 py-3.5 rounded-2xl transition-colors">
              Sign in
            </Link>
          </div>
        </div>
      </section>

      {/* ━━━━━━━━━━━━━━ FOOTER ━━━━━━━━━━━━━━ */}
      <footer className="bg-slate-900 text-slate-400">
        <div className="max-w-7xl mx-auto px-4 sm:px-8 py-14">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10 mb-10">

            {/* Brand */}
            <div>
              <div className="flex items-center gap-2.5 mb-4">
                <div className="w-9 h-9 bg-blue-600 rounded-xl flex items-center justify-center"><Library className="w-5 h-5 text-white" /></div>
                <span className="text-white font-extrabold text-base">LibraryMS</span>
              </div>
              <p className="text-sm leading-relaxed mb-4">
                The official library management system of the Royal University of Phnom Penh.
              </p>
              <div className="flex gap-2">
                {[<Globe className="w-4 h-4" />, <Link2 className="w-4 h-4" />, <Send className="w-4 h-4" />].map((ic, i) => (
                  <div key={i} className="w-8 h-8 bg-white/5 rounded-lg flex items-center justify-center hover:bg-white/10 cursor-pointer transition-colors text-slate-400">
                    {ic}
                  </div>
                ))}
              </div>
            </div>

            {/* Quick links */}
            <div>
              <h4 className="text-white font-bold mb-4">Quick Links</h4>
              <div className="space-y-2 text-sm">
                {[['Home', '/'], ['Book Catalog', '/login'], ['Sign In', '/login'], ['Register', '/register']].map(([label, to]) => (
                  <Link key={label} to={to}
                    className="block hover:text-white transition-colors">{label}</Link>
                ))}
              </div>
            </div>

            {/* Hours */}
            <div>
              <h4 className="text-white font-bold mb-4">Library Hours</h4>
              <div className="space-y-2 text-sm">
                <div className="flex justify-between">
                  <span>Monday – Friday</span>
                  <span className="text-white">7:00 AM – 6:00 PM</span>
                </div>
                <div className="flex justify-between">
                  <span>Saturday</span>
                  <span className="text-white">8:00 AM – 4:00 PM</span>
                </div>
                <div className="flex justify-between">
                  <span>Sunday</span>
                  <span className="text-red-400">Closed</span>
                </div>
              </div>
            </div>

            {/* Contact */}
            <div>
              <h4 className="text-white font-bold mb-4">Contact</h4>
              <div className="space-y-2 text-sm">
                <p>Royal University of Phnom Penh</p>
                <p>Russian Federation Blvd, Phnom Penh</p>
                <p className="flex items-center gap-1.5"><Phone className="w-3.5 h-3.5 flex-shrink-0" /> +855 23 883 640</p>
                <p className="flex items-center gap-1.5"><Mail className="w-3.5 h-3.5 flex-shrink-0" /> library@rupp.edu.kh</p>
              </div>
            </div>
          </div>

          <div className="border-t border-slate-800 pt-6 flex flex-col sm:flex-row items-center justify-between gap-3">
            <p className="text-sm">© {new Date().getFullYear()} Royal University of Phnom Penh. All rights reserved.</p>
            <div className="flex gap-4 text-xs">
              <Link to="/login" className="hover:text-white transition-colors">Privacy Policy</Link>
              <Link to="/login" className="hover:text-white transition-colors">Terms of Use</Link>
            </div>
          </div>
>>>>>>> testing
        </div>
      </footer>

    </div>
  );
}
<<<<<<< HEAD
=======

/* ── Root export ─────────────────────────────────────────────── */
export default function Home() {
  const { user } = useAuth();
  if (user) {
    const dashboard =
      user.role === 'superadmin' ? '/superadmin' :
      user.role === 'admin'      ? '/admin'       : '/user';
    return <Navigate to={dashboard} replace />;
  }
  return <PublicHome />;
}
>>>>>>> testing
