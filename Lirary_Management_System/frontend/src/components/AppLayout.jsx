import { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ROLE_BADGE = {
  user:       'bg-blue-100 text-blue-800',
  admin:      'bg-amber-100 text-amber-800',
  superadmin: 'bg-purple-100 text-purple-800',
};

export default function AppLayout({ navItems, children }) {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const isActive = (to) =>
    location.pathname === to ||
    (to.length > 1 && location.pathname.startsWith(to + '/'));

  return (
    <div className="min-h-screen flex bg-gray-50">
      {/* Mobile overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 z-40 bg-black/40 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-50 w-64 bg-blue-900 text-white flex flex-col
          transform transition-transform duration-200 ease-in-out
          ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'}
          lg:relative lg:translate-x-0 lg:flex`}
      >
        {/* Logo */}
        <div className="flex items-center gap-3 p-5 border-b border-blue-800">
          <span className="text-2xl">📚</span>
          <div>
            <p className="text-lg font-bold leading-tight">LibraryMS</p>
            <p className="text-xs text-blue-300">Management System</p>
          </div>
        </div>

        {/* User info */}
        <div className="px-4 py-3 border-b border-blue-800 bg-blue-800/40">
          <p className="text-xs text-blue-300 mb-0.5">Signed in as</p>
          <p className="font-semibold text-sm truncate">{user?.name}</p>
          <span className={`badge mt-1 text-xs ${ROLE_BADGE[user?.role]}`}>
            {user?.role}
          </span>
        </div>

        {/* Primary nav */}
        <nav className="flex-1 px-3 py-4 space-y-0.5 overflow-y-auto">
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
              <span className="text-base w-5 text-center">{item.icon}</span>
              {item.label}
            </Link>
          ))}
        </nav>

        {/* Role switcher */}
        {(user?.role === 'admin' || user?.role === 'superadmin') && (
          <div className="px-3 py-3 border-t border-blue-800">
            <p className="text-xs font-semibold text-blue-400 uppercase tracking-wider px-3 mb-2">
              Switch view
            </p>
            {user?.role === 'superadmin' && (
              <Link
                to="/superadmin"
                onClick={() => setSidebarOpen(false)}
                className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors"
              >
                <span>👑</span> Superadmin
              </Link>
            )}
            {(user?.role === 'admin' || user?.role === 'superadmin') && (
              <Link
                to="/admin"
                onClick={() => setSidebarOpen(false)}
                className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors"
              >
                <span>⚙️</span> Admin Panel
              </Link>
            )}
            <Link
              to="/user"
              onClick={() => setSidebarOpen(false)}
              className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-white/10 hover:text-white transition-colors"
            >
              <span>📖</span> User View
            </Link>
          </div>
        )}

        {/* Logout */}
        <div className="px-3 py-3 border-t border-blue-800">
          <button
            onClick={handleLogout}
            className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm text-blue-200 hover:bg-red-600 hover:text-white transition-colors w-full"
          >
            <span>🚪</span> Sign Out
          </button>
        </div>
      </aside>

      {/* Main content */}
      <div className="flex-1 flex flex-col min-w-0">
        {/* Top bar */}
        <header className="bg-white border-b border-gray-200 px-4 sm:px-6 py-3 flex items-center gap-3 sticky top-0 z-30">
          <button
            className="lg:hidden p-2 rounded-lg text-gray-500 hover:bg-gray-100"
            onClick={() => setSidebarOpen(true)}
            aria-label="Open sidebar"
          >
            ☰
          </button>
          <div className="flex-1" />
          <p className="text-xs text-gray-400 hidden sm:block">
            {new Date().toLocaleDateString('en-US', {
              weekday: 'long', year: 'numeric', month: 'long', day: 'numeric',
            })}
          </p>
        </header>

        <main className="flex-1 p-4 sm:p-6 overflow-auto">
          {children}
        </main>
      </div>
    </div>
  );
}
