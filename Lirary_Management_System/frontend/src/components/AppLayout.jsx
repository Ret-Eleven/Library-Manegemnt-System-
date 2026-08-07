import { useState, useEffect, useRef } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useNotifications } from '../context/NotificationContext';
import { Library, Crown, Settings as SettingsIcon, BookOpen, LogOut, Bell } from 'lucide-react';

const ROLE_BADGE = {
  user:       'bg-blue-100 text-blue-800',
  admin:      'bg-amber-100 text-amber-800',
  superadmin: 'bg-purple-100 text-purple-800',
};

/* ── Notification dropdown ───────────────────────────────────── */
function NotificationPanel({ onClose }) {
  const { notifications, unreadCount, loading, markAllRead } = useNotifications();
  const navigate = useNavigate();

  const handleClick = (notif) => {
    markAllRead();
    onClose();
    navigate(notif.link);
  };

  return (
    <div className="absolute right-0 top-full mt-2 w-80 bg-white rounded-2xl shadow-2xl border border-gray-100 z-50 overflow-hidden">

      {/* Header */}
      <div className="flex items-center justify-between px-4 py-3 border-b border-gray-100 bg-gray-50/80">
        <div className="flex items-center gap-2">
          <span className="text-sm font-extrabold text-gray-900">Notifications</span>
          {unreadCount > 0 && (
            <span className="inline-flex items-center justify-center w-5 h-5 rounded-full bg-red-500 text-white text-[10px] font-bold">
              {unreadCount > 9 ? '9+' : unreadCount}
            </span>
          )}
        </div>
        {notifications.length > 0 && (
          <button
            onClick={markAllRead}
            className="text-[11px] text-blue-600 hover:text-blue-500 font-semibold transition-colors"
          >
            Mark all read
          </button>
        )}
      </div>

      {/* List */}
      <div className="max-h-[360px] overflow-y-auto divide-y divide-gray-50">
        {loading && notifications.length === 0 ? (
          <div className="flex items-center justify-center py-10">
            <span className="w-5 h-5 border-2 border-gray-200 border-t-blue-500 rounded-full animate-spin"/>
          </div>
        ) : notifications.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 px-4 text-center">
            <div className="w-12 h-12 bg-gray-100 rounded-2xl flex items-center justify-center mb-3">
              <Bell className="w-6 h-6 text-gray-300" />
            </div>
            <p className="text-sm font-semibold text-gray-700">All caught up!</p>
            <p className="text-xs text-gray-400 mt-0.5">No new notifications right now.</p>
          </div>
        ) : (
          notifications.map(n => (
            <button
              key={n.id}
              onClick={() => handleClick(n)}
              className="w-full flex items-start gap-3 px-4 py-3.5 hover:bg-gray-50 transition-colors text-left group"
            >
              {/* Icon */}
              <div className={`w-9 h-9 rounded-xl flex items-center justify-center flex-shrink-0 text-base
                ${n.ringCls} mt-0.5`}>
                {n.icon}
              </div>

              {/* Content */}
              <div className="flex-1 min-w-0">
                <p className="text-sm font-bold text-gray-900 leading-tight">{n.title}</p>
                <p className="text-xs text-gray-500 mt-0.5 leading-relaxed">{n.body}</p>
              </div>

              {/* Unread dot */}
              <div className="flex-shrink-0 mt-1.5">
                <div className={`w-2 h-2 rounded-full ${n.dotCls}`}/>
              </div>
            </button>
          ))
        )}
      </div>

      {/* Footer */}
      {notifications.length > 0 && (
        <div className="border-t border-gray-100 px-4 py-2.5 bg-gray-50/60">
          <p className="text-[11px] text-gray-400 text-center">
            Auto-refreshes every minute
          </p>
        </div>
      )}
    </div>
  );
}

/* ── Bell button ─────────────────────────────────────────────── */
function NotificationBell() {
  const { unreadCount, refresh } = useNotifications();
  const [open, setOpen] = useState(false);
  const ref = useRef(null);

  /* Close on outside click */
  useEffect(() => {
    const handler = (e) => { if (ref.current && !ref.current.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, []);

  const toggle = () => {
    if (!open) refresh();
    setOpen(v => !v);
  };

  return (
    <div ref={ref} className="relative">
      <button
        onClick={toggle}
        aria-label="Notifications"
        className={`relative p-2 rounded-xl transition-colors
          ${open ? 'bg-blue-50 text-blue-600' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-700'}`}
      >
        {/* Bell SVG */}
        <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={1.8} viewBox="0 0 24 24">
          <path strokeLinecap="round" d="M14.857 17.082a23.848 23.848 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0"/>
        </svg>

        {/* Badge */}
        {unreadCount > 0 && (
          <span className="absolute -top-0.5 -right-0.5 min-w-[18px] h-[18px] px-1
            bg-red-500 text-white text-[10px] font-extrabold rounded-full
            flex items-center justify-center shadow-sm animate-pulse">
            {unreadCount > 9 ? '9+' : unreadCount}
          </span>
        )}
      </button>

      {open && <NotificationPanel onClose={() => setOpen(false)} />}
    </div>
  );
}

/* ── Main layout ─────────────────────────────────────────────── */
export default function AppLayout({ navItems, children }) {
  const { user, logout } = useAuth();
  const navigate  = useNavigate();
  const location  = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const handleLogout = () => { logout(); navigate('/login'); };
  const isActive = (to) => location.pathname === to;

  /* Derive dashboard root for profile/settings links */
  const dashboard =
    user?.role === 'superadmin' ? '/superadmin' :
    user?.role === 'admin'      ? '/admin'       : '/user';

  return (
    <div className="h-screen overflow-hidden flex bg-gray-50">

      {/* Mobile overlay */}
      {sidebarOpen && (
        <div className="fixed inset-0 z-40 bg-black/40 lg:hidden" onClick={() => setSidebarOpen(false)} />
      )}

      {/* ── Sidebar ── */}
      <aside className={`fixed inset-y-0 left-0 z-50 w-64 bg-blue-900 text-white flex flex-col
        transform transition-transform duration-200 ease-in-out
        ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'}
        lg:relative lg:translate-x-0 lg:flex`}>

        {/* Logo */}
        <div className="flex items-center gap-3 p-5 border-b border-blue-800">
          <Library className="w-7 h-7 text-blue-200 flex-shrink-0" />
          <div>
            <p className="text-lg font-bold leading-tight">LibraryMS</p>
            <p className="text-xs text-blue-300">Management System</p>
          </div>
        </div>

        {/* User info */}
        <div className="px-4 py-3 border-b border-blue-800 bg-blue-800/40">
          <p className="text-xs text-blue-300 mb-0.5">Signed in as</p>
          <p className="font-semibold text-sm truncate">{user?.name}</p>
          <span className={`badge mt-1 text-xs ${ROLE_BADGE[user?.role]}`}>{user?.role}</span>
        </div>

        {/* Primary nav */}
        <nav className="flex-1 px-3 py-4 space-y-0.5 overflow-y-auto scrollbar-sidebar">
          {navItems.map(item => (
            <Link
              key={item.to}
              to={item.to}
              onClick={() => setSidebarOpen(false)}
              className={`flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-colors
                ${isActive(item.to)
                  ? 'bg-white/15 text-white shadow-sm'
                  : 'text-blue-200 hover:bg-white/10 hover:text-white'}`}
            >
              <item.icon className="w-5 h-5 flex-shrink-0" />
              {item.label}
            </Link>
          ))}
        </nav>

        {/* Role switcher */}
        {(user?.role === 'admin' || user?.role === 'superadmin') && (
          <div className="px-3 py-3 border-t border-blue-800">
            <p className="text-xs font-semibold text-blue-400 uppercase tracking-wider px-3 mb-2">Switch view</p>
            {user?.role === 'superadmin' && (
              <Link to="/superadmin" onClick={() => setSidebarOpen(false)}
                className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors">
                <Crown className="w-4 h-4" /> Superadmin
              </Link>
            )}
            {(user?.role === 'admin' || user?.role === 'superadmin') && (
              <Link to="/admin" onClick={() => setSidebarOpen(false)}
                className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors">
                <SettingsIcon className="w-4 h-4" /> Admin Panel
              </Link>
            )}
            <Link to="/user" onClick={() => setSidebarOpen(false)}
              className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors">
              <BookOpen className="w-4 h-4" /> User View
            </Link>
          </div>
        )}

        {/* Logout */}
        <div className="px-3 py-3 border-t border-blue-800">
          <button onClick={handleLogout}
            className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-red-600 hover:text-white transition-colors w-full">
            <LogOut className="w-4 h-4" /> Sign Out
          </button>
        </div>
      </aside>

      {/* ── Main content ── */}
      <div className="flex-1 flex flex-col min-w-0 overflow-y-auto scrollbar-main">

        {/* Top bar */}
        <header className="bg-white border-b border-gray-200 px-4 sm:px-6 py-3 flex items-center gap-3 sticky top-0 z-30 flex-shrink-0">

          {/* Hamburger */}
          <button className="lg:hidden p-2 rounded-lg text-gray-500 hover:bg-gray-100"
            onClick={() => setSidebarOpen(true)} aria-label="Open sidebar">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <path strokeLinecap="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"/>
            </svg>
          </button>

          <div className="flex-1" />

          {/* Date — hidden on small screens */}
          <p className="text-xs text-gray-400 hidden md:block">
            {new Date().toLocaleDateString('en-US', {
              weekday: 'long', year: 'numeric', month: 'long', day: 'numeric',
            })}
          </p>

          {/* Right actions */}
          <div className="flex items-center gap-1">

            {/* Notification bell */}
            <NotificationBell />

            {/* Profile shortcut */}
            <Link
              to={`${dashboard}/profile`}
              className="flex items-center gap-2 pl-2 ml-1 border-l border-gray-200 hover:opacity-80 transition-opacity"
              title="My Profile"
            >
              <div className="w-8 h-8 rounded-xl overflow-hidden bg-blue-600 flex items-center justify-center text-white text-xs font-extrabold shadow-sm flex-shrink-0">
                {user?.avatar
                  ? <img src={user.avatar} alt={user.name} className="w-full h-full object-cover" />
                  : user?.name?.split(' ').map(w => w[0]).join('').slice(0, 2).toUpperCase()}
              </div>
              <div className="hidden sm:block text-right">
                <p className="text-xs font-semibold text-gray-800 leading-tight truncate max-w-[100px]">{user?.name?.split(' ')[0]}</p>
                <p className="text-[10px] text-gray-400 capitalize">{user?.role}</p>
              </div>
            </Link>
          </div>
        </header>

        <main className="flex-1 p-4 sm:p-6">
          {children}
        </main>
      </div>
    </div>
  );
}
