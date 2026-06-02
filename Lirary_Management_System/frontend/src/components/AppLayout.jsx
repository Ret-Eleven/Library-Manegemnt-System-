import { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ROLE_THEME = {
  user:       { accent: 'bg-blue-500',   activeBg: 'bg-blue-500/20', activeText: 'text-blue-200',   activeBorder: 'border-blue-400',   dot: 'bg-blue-400',   badge: 'bg-blue-500/25 text-blue-300',   icon: '🎓', label: 'Student'   },
  admin:      { accent: 'bg-amber-500',  activeBg: 'bg-amber-500/20',activeText: 'text-amber-200',  activeBorder: 'border-amber-400',  dot: 'bg-amber-400',  badge: 'bg-amber-500/25 text-amber-300',  icon: '📖', label: 'Librarian' },
  superadmin: { accent: 'bg-purple-500', activeBg: 'bg-purple-500/20',activeText: 'text-purple-200', activeBorder: 'border-purple-400', dot: 'bg-purple-400', badge: 'bg-purple-500/25 text-purple-300', icon: '👑', label: 'Director'  },
};

function Avatar({ name, role, size = 'md' }) {
  const initials = name ? name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2) : '?';
  const theme = ROLE_THEME[role] || ROLE_THEME.user;
  const sz = size === 'sm' ? 'w-8 h-8 text-xs' : 'w-11 h-11 text-sm';
  return (
    <div className={`${sz} ${theme.accent} rounded-xl flex items-center justify-center text-white font-bold flex-shrink-0 select-none`}>
      {initials}
    </div>
  );
}

export default function AppLayout({ navItems, children }) {
  const { user, logout } = useAuth();
  const navigate  = useNavigate();
  const location  = useLocation();
  const [open, setOpen] = useState(false);

  const theme    = ROLE_THEME[user?.role] || ROLE_THEME.user;
  const basePath = location.pathname.startsWith('/superadmin') ? '/superadmin'
                 : location.pathname.startsWith('/admin')      ? '/admin'
                 : '/user';

  const handleLogout = () => { logout(); navigate('/login'); };
  const close = () => setOpen(false);

  const isActive = (to) =>
    location.pathname === to ||
    (to.length > 1 && location.pathname.startsWith(to + '/'));

  const navLink = (item) => {
    const active = isActive(item.to);
    return (
      <Link
        key={item.to}
        to={item.to}
        onClick={close}
        className={`flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm font-medium transition-all border-l-2
          ${active
            ? `${theme.activeBg} ${theme.activeText} ${theme.activeBorder}`
            : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200 border-transparent'}`}
      >
        <span className="text-base w-5 text-center flex-shrink-0">{item.icon}</span>
        {item.label}
      </Link>
    );
  };

  return (
    <div className="min-h-screen flex bg-gray-50">

      {/* Mobile overlay */}
      {open && (
        <div className="fixed inset-0 z-40 bg-black/50 lg:hidden" onClick={close} />
      )}

      {/* ── Sidebar ── */}
      <aside className={`
        fixed inset-y-0 left-0 z-50 w-64 bg-slate-900 flex flex-col
        transform transition-transform duration-200 ease-in-out
        ${open ? 'translate-x-0' : '-translate-x-full'}
        lg:relative lg:translate-x-0
      `}>

        {/* Logo */}
        <div className="flex items-center gap-3 px-5 h-16 border-b border-slate-800 flex-shrink-0">
          <div className="w-9 h-9 rounded-xl bg-white/10 border border-white/10 flex items-center justify-center text-xl">
            📚
          </div>
          <div>
            <p className="text-white font-extrabold text-sm leading-tight">LibraryMS</p>
            <p className="text-slate-500 text-[10px]">RUPP · Management System</p>
          </div>
        </div>

        {/* User card */}
        <div className="mx-3 mt-4 rounded-2xl bg-slate-800 p-3.5 flex-shrink-0">
          <div className="flex items-center gap-3">
            <Avatar name={user?.name} role={user?.role} />
            <div className="flex-1 min-w-0">
              <p className="text-white font-semibold text-sm leading-tight truncate">{user?.name}</p>
              <p className="text-slate-400 text-[10px] truncate mt-0.5">{user?.email}</p>
            </div>
          </div>
          <div className="mt-2.5 flex items-center gap-2">
            <span className={`inline-flex items-center gap-1 text-[10px] font-bold px-2 py-0.5 rounded-full ${theme.badge}`}>
              {theme.icon} {theme.label}
            </span>
            <span className={`w-1.5 h-1.5 rounded-full flex-shrink-0 ${theme.dot}`} />
            <span className="text-slate-500 text-[10px]">Online</span>
          </div>
        </div>

        {/* Nav section label */}
        <p className="mt-4 mb-1 px-5 text-[10px] font-bold text-slate-500 uppercase tracking-widest flex-shrink-0">
          Menu
        </p>

        {/* Primary nav */}
        <nav className="flex-1 px-3 space-y-0.5 overflow-y-auto">
          {navItems.map(item => navLink(item))}
        </nav>

        {/* Switch view */}
        {(user?.role === 'admin' || user?.role === 'superadmin') && (
          <div className="mx-3 my-3 flex-shrink-0">
            <p className="px-2 mb-1.5 text-[10px] font-bold text-slate-500 uppercase tracking-widest">
              Switch view
            </p>
            <div className="bg-slate-800 rounded-xl p-1 space-y-0.5">
              {user?.role === 'superadmin' && (
                <Link to="/superadmin" onClick={close}
                  className="flex items-center gap-2 px-3 py-2 rounded-lg text-xs text-slate-400 hover:bg-slate-700 hover:text-white transition-colors">
                  <span>👑</span> Superadmin
                </Link>
              )}
              {(user?.role === 'admin' || user?.role === 'superadmin') && (
                <Link to="/admin" onClick={close}
                  className="flex items-center gap-2 px-3 py-2 rounded-lg text-xs text-slate-400 hover:bg-slate-700 hover:text-white transition-colors">
                  <span>📖</span> Admin Panel
                </Link>
              )}
              <Link to="/user" onClick={close}
                className="flex items-center gap-2 px-3 py-2 rounded-lg text-xs text-slate-400 hover:bg-slate-700 hover:text-white transition-colors">
                <span>🎓</span> Student View
              </Link>
            </div>
          </div>
        )}

        {/* Bottom links */}
        <div className="px-3 pb-4 pt-3 border-t border-slate-800 space-y-0.5 flex-shrink-0">
          <p className="px-3 mb-1.5 text-[10px] font-bold text-slate-500 uppercase tracking-widest">
            Account
          </p>
          {[
            { to: `${basePath}/profile`,  icon: '👤', label: 'My Profile' },
            { to: `${basePath}/settings`, icon: '⚙️', label: 'Settings'   },
          ].map(item => navLink(item))}

          <button
            onClick={handleLogout}
            className="flex items-center gap-3 px-3 py-2.5 rounded-xl text-sm text-slate-400 hover:bg-red-500/15 hover:text-red-300 transition-all w-full border-l-2 border-transparent mt-1"
          >
            <span className="text-base w-5 text-center">🚪</span>
            Sign Out
          </button>
        </div>
      </aside>

      {/* ── Main ── */}
      <div className="flex-1 flex flex-col min-w-0">

        {/* Top bar */}
        <header className="bg-white border-b border-gray-200 px-4 sm:px-6 h-16 flex items-center gap-3 sticky top-0 z-30 flex-shrink-0">
          {/* Hamburger */}
          <button
            className="lg:hidden p-2 rounded-xl text-gray-500 hover:bg-gray-100 transition-colors"
            onClick={() => setOpen(true)}
            aria-label="Open sidebar"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>

          <div className="flex-1" />

          {/* Date */}
          <p className="text-xs text-gray-400 hidden md:block">
            {new Date().toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}
          </p>

          {/* User pill */}
          <div className="flex items-center gap-2.5 bg-gray-50 border border-gray-200 rounded-xl px-3 py-1.5">
            <Avatar name={user?.name} role={user?.role} size="sm" />
            <div className="hidden sm:block leading-tight">
              <p className="text-xs font-bold text-gray-800">{user?.name?.split(' ')[0]}</p>
              <p className="text-[10px] text-gray-400">{theme.label}</p>
            </div>
          </div>
        </header>

        <main className="flex-1 p-4 sm:p-6 overflow-auto">
          {children}
        </main>
      </div>
    </div>
  );
}
