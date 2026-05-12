import { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ROLE_HOME = { superadmin: '/superadmin', admin: '/admin', user: '/user' };

export default function Login() {
  const { login, user } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const [form, setForm] = useState({ email: '', password: '' });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

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
      setError(err.response?.data?.message || 'Login failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const fill = (email, password) => setForm({ email, password });

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-900 via-blue-800 to-blue-600 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-8">
        <div className="text-center mb-8">
          <div className="text-5xl mb-3">📚</div>
          <h1 className="text-3xl font-bold text-gray-900">LibraryMS</h1>
          <p className="text-gray-500 mt-1 text-sm">Library Management System</p>
        </div>

        {successMsg && (
          <div className="mb-4 p-3 bg-green-50 border border-green-200 rounded-lg text-green-700 text-sm">
            {successMsg}
          </div>
        )}

        {error && (
          <div className="mb-4 p-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="label">Email address</label>
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
            <input
              type="password"
              className="input"
              placeholder="••••••••"
              value={form.password}
              onChange={e => setForm({ ...form, password: e.target.value })}
              required
            />
          </div>
          <button type="submit" className="btn-primary w-full py-2.5" disabled={loading}>
            {loading ? 'Signing in…' : 'Sign In'}
          </button>
        </form>

        <p className="text-center mt-5 text-sm text-gray-600">
          Don't have an account?{' '}
          <Link to="/register" className="text-blue-700 font-medium hover:underline">
            Register
          </Link>
        </p>

        <div className="mt-6 p-4 bg-gray-50 rounded-xl border border-gray-200">
          <p className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Demo accounts</p>
          <div className="space-y-1">
            {[
              { role: 'Superadmin', email: 'superadmin@library.com', pw: 'admin123', badgeClass: 'bg-purple-100 text-purple-700' },
              { role: 'Admin',      email: 'admin@library.com',      pw: 'admin123', badgeClass: 'bg-amber-100 text-amber-700'   },
              { role: 'User',       email: 'user@library.com',       pw: 'user123',  badgeClass: 'bg-blue-100 text-blue-700'     },
            ].map(d => (
              <button
                key={d.role}
                type="button"
                onClick={() => fill(d.email, d.pw)}
                className="w-full text-left text-xs p-2 rounded-lg hover:bg-gray-100 transition-colors flex items-center gap-2"
              >
                <span className={`badge ${d.badgeClass}`}>{d.role}</span>
                <span className="text-gray-600">{d.email}</span>
                <span className="text-gray-400 ml-auto">{d.pw}</span>
              </button>
            ))}
            <p className="text-xs text-gray-400 mt-1 pl-2">Click any row to auto-fill</p>
          </div>
        </div>
      </div>
    </div>
  );
}
