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
            </div>
          </div>
        </div>
      </section>

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
                <p className="text-sm text-gray-500 leading-relaxed">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

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
        </div>
      </footer>

    </div>
  );
}
