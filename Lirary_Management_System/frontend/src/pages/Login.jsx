import { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ROLE_HOME = { superadmin: '/superadmin', admin: '/admin', user: '/user' };

const FEATURES = [
  { icon: '📚', text: 'Access thousands of books online'     },
  { icon: '⚡', text: 'Request and manage loans instantly'   },
  { icon: '🔔', text: 'Get due-date reminders automatically' },
  { icon: '📊', text: 'Track your full borrowing history'    },
];

export default function Login() {
  const { login, user } = useAuth();
  const navigate        = useNavigate();
  const location        = useLocation();

  const [form,     setForm]     = useState({ email: '', password: '' });
  const [error,    setError]    = useState('');
  const [loading,  setLoading]  = useState(false);
  const [showPw,   setShowPw]   = useState(false);

  if (user) navigate(ROLE_HOME[user.role] || '/user', { replace: true });

  const successMsg = location.state?.message;

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      const u = await login(form.email, form.password);
      navigate(ROLE_HOME[u.role] || '/user', { replace: true });
    } catch (err) {
      setError(err.response?.data?.message || 'Invalid email or password.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex">

      {/* ── Left panel ─────────────────────────────────────────── */}
      <div className="hidden lg:flex lg:w-[46%] xl:w-[42%] flex-col relative overflow-hidden"
        style={{ background: 'linear-gradient(145deg, #0f1b4c 0%, #1e1b6e 45%, #0f172a 100%)' }}>

        {/* Grid texture */}
        <div className="absolute inset-0 opacity-[0.04] pointer-events-none"
          style={{ backgroundImage: 'radial-gradient(circle at 1px 1px,white 1px,transparent 0)', backgroundSize: '28px 28px' }}/>
        {/* Glow */}
        <div className="absolute top-1/4 -left-20 w-80 h-80 bg-blue-600/20 rounded-full blur-3xl pointer-events-none"/>
        <div className="absolute bottom-1/4 right-0 w-64 h-64 bg-violet-600/15 rounded-full blur-3xl pointer-events-none"/>

        <div className="relative flex flex-col h-full px-10 py-10">

          {/* Logo */}
          <Link to="/" className="flex items-center gap-3 mb-auto">
            <div className="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center text-xl shadow-lg shadow-blue-900/50">
              📚
            </div>
            <div>
              <p className="text-white font-extrabold text-base leading-tight">LibraryMS</p>
              <p className="text-slate-500 text-[11px]">RUPP · Central Library</p>
            </div>
          </Link>

          {/* Main copy */}
          <div className="my-auto">
            <h2 className="text-3xl xl:text-4xl font-extrabold text-white leading-tight mb-4">
              Welcome back<br/>
              <span className="bg-gradient-to-r from-blue-400 to-cyan-400 bg-clip-text text-transparent">
                to LibraryMS
              </span>
            </h2>
            <p className="text-slate-400 text-sm leading-relaxed mb-8 max-w-xs">
              Sign in to access your personal library dashboard, track your loans, and discover new books.
            </p>

            {/* Feature list */}
            <ul className="space-y-3 mb-10">
              {FEATURES.map(f => (
                <li key={f.text} className="flex items-center gap-3">
                  <span className="w-8 h-8 bg-white/8 rounded-lg flex items-center justify-center text-base flex-shrink-0">
                    {f.icon}
                  </span>
                  <span className="text-slate-300 text-sm">{f.text}</span>
                </li>
              ))}
            </ul>

          </div>

          {/* Bottom */}
          <p className="text-slate-600 text-xs">
            © {new Date().getFullYear()} Royal University of Phnom Penh
          </p>
        </div>
      </div>

      {/* ── Right panel: form ───────────────────────────────────── */}
      <div className="flex-1 flex flex-col items-center justify-center bg-gray-50 px-6 py-12">

        {/* Mobile logo */}
        <Link to="/" className="flex items-center gap-2.5 mb-8 lg:hidden">
          <div className="w-9 h-9 bg-blue-600 rounded-xl flex items-center justify-center text-lg">📚</div>
          <span className="text-gray-900 font-extrabold text-lg">LibraryMS</span>
        </Link>

        <div className="w-full max-w-sm">

          {/* Heading */}
          <div className="mb-8">
            <h1 className="text-2xl font-extrabold text-gray-900">Sign in to your account</h1>
            <p className="text-gray-400 text-sm mt-1">
              Don't have one?{' '}
              <Link to="/register" className="text-blue-600 font-semibold hover:text-blue-500 transition-colors">
                Create account
              </Link>
            </p>
          </div>

          {/* Success message */}
          {successMsg && (
            <div className="mb-5 flex items-start gap-2.5 px-4 py-3 bg-emerald-50 border border-emerald-200 rounded-xl text-emerald-700 text-sm">
              <span className="mt-0.5 flex-shrink-0">✓</span>
              {successMsg}
            </div>
          )}

          {/* Error message */}
          {error && (
            <div className="mb-5 flex items-start gap-2.5 px-4 py-3 bg-red-50 border border-red-200 rounded-xl text-red-600 text-sm">
              <span className="mt-0.5 flex-shrink-0">✕</span>
              {error}
            </div>
          )}

          {/* Form */}
          <form onSubmit={handleSubmit} className="space-y-4">

            {/* Email */}
            <div>
              <label className="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1.5">
                Email address
              </label>
              <input
                type="email"
                autoComplete="email"
                placeholder="you@example.com"
                value={form.email}
                onChange={e => setForm(f => ({ ...f, email: e.target.value }))}
                required
                className="w-full bg-white border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-900
                  placeholder-gray-400 outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent
                  transition-all shadow-sm"
              />
            </div>

            {/* Password */}
            <div>
              <label className="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1.5">
                Password
              </label>
              <div className="relative">
                <input
                  type={showPw ? 'text' : 'password'}
                  autoComplete="current-password"
                  placeholder="••••••••"
                  value={form.password}
                  onChange={e => setForm(f => ({ ...f, password: e.target.value }))}
                  required
                  className="w-full bg-white border border-gray-200 rounded-xl px-4 py-3 pr-11 text-sm text-gray-900
                    placeholder-gray-400 outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent
                    transition-all shadow-sm"
                />
                <button
                  type="button"
                  onClick={() => setShowPw(v => !v)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 transition-colors p-1"
                  tabIndex={-1}
                >
                  {showPw
                    ? <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88"/></svg>
                    : <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path strokeLinecap="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/></svg>
                  }
                </button>
              </div>
            </div>

            {/* Submit */}
            <button
              type="submit"
              disabled={loading}
              className="w-full bg-blue-600 hover:bg-blue-500 active:bg-blue-700 disabled:opacity-60
                text-white font-bold py-3 rounded-xl transition-all shadow-lg shadow-blue-200 text-sm
                flex items-center justify-center gap-2 mt-2"
            >
              {loading ? (
                <>
                  <span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/>
                  Signing in…
                </>
              ) : 'Sign In'}
            </button>
          </form>

          {/* Back to home */}
          <p className="text-center mt-8 text-xs text-gray-400">
            <Link to="/" className="hover:text-gray-600 transition-colors">← Back to home</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
