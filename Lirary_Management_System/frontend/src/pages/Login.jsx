import { useState, useEffect } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ROLE_HOME = { superadmin: '/superadmin', admin: '/admin', user: '/user' };

const DEMO_ACCOUNTS = [
  { role: 'Superadmin', email: 'superadmin@library.com', pw: 'admin123', badge: 'bg-purple-100 text-purple-700' },
  { role: 'Admin',      email: 'admin@library.com',      pw: 'admin123', badge: 'bg-amber-100 text-amber-700'  },
  { role: 'Student',    email: 'user@library.com',        pw: 'user123',  badge: 'bg-blue-100 text-blue-700'   },
];

export default function Login() {
  const { login, user } = useAuth();
  const navigate        = useNavigate();
  const location        = useLocation();

  const [form, setForm]       = useState({ email: '', password: '' });
  const [showPw, setShowPw]   = useState(false);
  const [error, setError]     = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (user) navigate(ROLE_HOME[user.role] || '/user', { replace: true });
  }, [user, navigate]);

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

  const fill = (email, pw) => {
    setForm({ email, password: pw });
    setError('');
  };

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col items-center justify-center px-4 py-12">

      {/* Logo */}
      <div className="flex items-center gap-2 mb-8">
        <span className="text-2xl">📚</span>
        <span className="font-bold text-gray-900 text-lg">LibraryMS</span>
        <span className="text-xs text-gray-400 ml-1">— RUPP</span>
      </div>

      {/* Card */}
      <div className="w-full max-w-sm bg-white border border-gray-200 rounded-2xl p-8 shadow-sm">

        <h1 className="text-xl font-bold text-gray-900 mb-1">Sign in</h1>
        <p className="text-sm text-gray-500 mb-6">Access your library dashboard</p>

        {/* Success */}
        {successMsg && (
          <div className="mb-4 flex items-center gap-2 p-3 bg-green-50 border border-green-200 rounded-lg text-green-700 text-sm">
            <span>✓</span> {successMsg}
          </div>
        )}

        {/* Error */}
        {error && (
          <div className="mb-4 flex items-center gap-2 p-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">
            <span>✕</span> {error}
          </div>
        )}

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="label">Email</label>
            <input
              type="email"
              className="input"
              placeholder="you@example.com"
              value={form.email}
              onChange={e => setForm({ ...form, email: e.target.value })}
              required
            />
          </div>

          <div>
            <label className="label">Password</label>
            <div className="relative">
              <input
                type={showPw ? 'text' : 'password'}
                className="input pr-10"
                placeholder="••••••••"
                value={form.password}
                onChange={e => setForm({ ...form, password: e.target.value })}
                required
              />
              <button
                type="button"
                onClick={() => setShowPw(v => !v)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 text-sm"
              >
                {showPw ? '🙈' : '👁️'}
              </button>
            </div>
          </div>

          <button
            type="submit"
            disabled={loading}
            className="btn-primary w-full py-2.5"
          >
            {loading ? (
              <>
                <span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                Signing in…
              </>
            ) : 'Sign In →'}
          </button>
        </form>

        <p className="text-center mt-5 text-sm text-gray-500">
          No account?{' '}
          <Link to="/register" className="text-blue-600 font-semibold hover:underline">
            Register free
          </Link>
        </p>

        {/* Demo accounts */}
        <div className="mt-6 pt-6 border-t border-gray-100">
          <p className="text-xs text-gray-400 text-center mb-3">Demo accounts — click to fill</p>
          <div className="space-y-2">
            {DEMO_ACCOUNTS.map(d => (
              <button
                key={d.role}
                type="button"
                onClick={() => fill(d.email, d.pw)}
                className="w-full flex items-center justify-between px-3 py-2.5 rounded-lg border border-gray-200 hover:bg-gray-50 transition text-left"
              >
                <div className="flex items-center gap-2.5">
                  <span className={`badge text-[10px] ${d.badge}`}>{d.role}</span>
                  <span className="text-xs text-gray-500">{d.email}</span>
                </div>
                <span className="text-[11px] font-mono text-gray-400 bg-gray-50 border border-gray-200 px-2 py-0.5 rounded">
                  {d.pw}
                </span>
              </button>
            ))}
          </div>
        </div>
      </div>

      <Link to="/" className="mt-6 text-xs text-gray-400 hover:text-gray-600 transition-colors">
        ← Back to Home
      </Link>
    </div>
  );
}
