import { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import { useNavigate, Link } from 'react-router-dom';

const STORAGE_KEY = 'library_settings';
const DEFAULTS = {
  emailNotifications: true,
  dueDateReminders:   true,
  approvalAlerts:     true,
  compactView:        false,
  language:           'en',
};

function load() {
  try { return { ...DEFAULTS, ...JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}') }; }
  catch { return DEFAULTS; }
}

const ROLE_HOME = { superadmin: '/superadmin', admin: '/admin', user: '/user' };

const ROLE_STYLE = {
  superadmin: { badge: 'bg-purple-100 text-purple-700', icon: '👑', label: 'Superadmin' },
  admin:      { badge: 'bg-amber-100 text-amber-700',   icon: '📖', label: 'Admin'      },
  user:       { badge: 'bg-blue-100 text-blue-700',     icon: '🎓', label: 'Student'    },
};

const TABS = [
  { id: 'preferences', icon: '⚙️',  label: 'Preferences' },
  { id: 'account',     icon: '👤',  label: 'Account'     },
  { id: 'system',      icon: 'ℹ️',  label: 'System'      },
];

/* ── Sub-components ── */

function Avatar({ name, size = 'lg' }) {
  const initials = name
    ? name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2)
    : '?';
  const colors = ['bg-blue-500','bg-purple-500','bg-emerald-500','bg-amber-500','bg-rose-500','bg-indigo-500'];
  const color  = colors[(name?.charCodeAt(0) || 0) % colors.length];
  const sz = size === 'lg' ? 'w-16 h-16 text-xl' : 'w-10 h-10 text-sm';
  return (
    <div className={`${sz} ${color} rounded-2xl flex items-center justify-center text-white font-extrabold flex-shrink-0`}>
      {initials}
    </div>
  );
}

function Toggle({ checked, onChange }) {
  return (
    <button
      type="button"
      role="switch"
      aria-checked={checked}
      onClick={() => onChange(!checked)}
      className={`relative inline-flex h-6 w-11 flex-shrink-0 rounded-full border-2 border-transparent
        transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-1
        ${checked ? 'bg-blue-600' : 'bg-gray-200'}`}
    >
      <span className={`pointer-events-none inline-block h-5 w-5 rounded-full bg-white shadow
        transform transition duration-200 ${checked ? 'translate-x-5' : 'translate-x-0'}`} />
    </button>
  );
}

function Row({ icon, label, desc, children, iconBg = 'bg-gray-100' }) {
  return (
    <div className="flex items-center justify-between gap-4 py-4 border-b border-gray-50 last:border-0">
      <div className="flex items-center gap-3.5 min-w-0">
        <div className={`w-9 h-9 rounded-xl ${iconBg} flex items-center justify-center text-base flex-shrink-0`}>
          {icon}
        </div>
        <div className="min-w-0">
          <p className="text-sm font-semibold text-gray-800">{label}</p>
          {desc && <p className="text-xs text-gray-400 mt-0.5 leading-relaxed">{desc}</p>}
        </div>
      </div>
      <div className="flex-shrink-0">{children}</div>
    </div>
  );
}

function Section({ title, children }) {
  return (
    <div className="bg-white rounded-2xl border border-gray-200 overflow-hidden mb-4">
      <div className="px-5 py-3.5 border-b border-gray-100 bg-gray-50">
        <h3 className="text-xs font-bold text-gray-500 uppercase tracking-widest">{title}</h3>
      </div>
      <div className="px-5">{children}</div>
    </div>
  );
}

/* ── Main component ── */

export default function Settings() {
  const { user, logout } = useAuth();
  const navigate         = useNavigate();
  const [settings, set]  = useState(load);
  const [saved, setSaved] = useState(false);
  const [tab, setTab]    = useState('preferences');

  const update = (key, val) => set(prev => ({ ...prev, [key]: val }));

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(settings));
    setSaved(true);
    const t = setTimeout(() => setSaved(false), 1800);
    return () => clearTimeout(t);
  }, [settings]);

  const basePath  = ROLE_HOME[user?.role] || '/user';
  const roleStyle = ROLE_STYLE[user?.role] || ROLE_STYLE.user;

  return (
    <div className="max-w-2xl mx-auto space-y-5">

      {/* ── Page header ── */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">Settings</h1>
          <p className="text-sm text-gray-400 mt-0.5">Manage your preferences and account</p>
        </div>
        <span className={`flex items-center gap-1.5 text-xs font-semibold text-emerald-600 transition-opacity duration-300 ${saved ? 'opacity-100' : 'opacity-0'}`}>
          <span className="w-2 h-2 bg-emerald-500 rounded-full" />
          Auto-saved
        </span>
      </div>

      {/* ── Profile card ── */}
      <div className="bg-white rounded-2xl border border-gray-200 p-5">
        <div className="flex items-center gap-4">
          <Avatar name={user?.name} />
          <div className="flex-1 min-w-0">
            <p className="font-extrabold text-gray-900 text-lg leading-tight truncate">{user?.name}</p>
            <p className="text-sm text-gray-400 truncate">{user?.email}</p>
            <div className="flex items-center gap-2 mt-2">
              <span className={`badge text-xs ${roleStyle.badge}`}>
                {roleStyle.icon} {roleStyle.label}
              </span>
              <span className="text-xs text-gray-300">·</span>
              <span className="text-xs text-gray-400">LibraryMS — RUPP</span>
            </div>
          </div>
          <Link to={`${basePath}/profile`} className="btn-secondary btn-sm flex-shrink-0">
            Edit Profile →
          </Link>
        </div>
      </div>

      {/* ── Tabs ── */}
      <div className="flex gap-1 bg-gray-100 p-1 rounded-xl">
        {TABS.map(t => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            className={`flex-1 flex items-center justify-center gap-2 py-2.5 rounded-lg text-sm font-semibold transition-all
              ${tab === t.id
                ? 'bg-white text-gray-900 shadow-sm'
                : 'text-gray-500 hover:text-gray-700'}`}
          >
            <span>{t.icon}</span>
            <span className="hidden sm:inline">{t.label}</span>
          </button>
        ))}
      </div>

      {/* ── Preferences tab ── */}
      {tab === 'preferences' && (
        <div>
          <Section title="Notifications">
            <Row icon="📧" label="Email Notifications" desc="Receive account updates and alerts by email" iconBg="bg-blue-50">
              <Toggle checked={settings.emailNotifications} onChange={v => update('emailNotifications', v)} />
            </Row>
            <Row icon="📅" label="Due Date Reminders" desc="Get reminded before a book return is due" iconBg="bg-amber-50">
              <Toggle checked={settings.dueDateReminders} onChange={v => update('dueDateReminders', v)} />
            </Row>
            <Row icon="✅" label="Approval Alerts" desc="Notify me when a borrow request is approved or rejected" iconBg="bg-emerald-50">
              <Toggle checked={settings.approvalAlerts} onChange={v => update('approvalAlerts', v)} />
            </Row>
          </Section>

          <Section title="Display">
            <Row icon="📋" label="Compact View" desc="Reduce spacing to show more content per page" iconBg="bg-purple-50">
              <Toggle checked={settings.compactView} onChange={v => update('compactView', v)} />
            </Row>
            <Row icon="🌐" label="Language" desc="Choose your preferred display language" iconBg="bg-indigo-50">
              <select
                className="input text-sm w-36 py-2"
                value={settings.language}
                onChange={e => update('language', e.target.value)}
              >
                <option value="en">🇺🇸 English</option>
                <option value="km">🇰🇭 ខ្មែរ (Khmer)</option>
              </select>
            </Row>
          </Section>
        </div>
      )}

      {/* ── Account tab ── */}
      {tab === 'account' && (
        <div>
          <Section title="Your Account">
            <Row icon="🪪" label="Role" desc="Access level assigned by the administrator" iconBg="bg-gray-100">
              <span className={`badge ${roleStyle.badge}`}>
                {roleStyle.icon} {roleStyle.label}
              </span>
            </Row>
            <Row icon="✏️" label="Edit Profile" desc="Update your name and email address" iconBg="bg-blue-50">
              <Link to={`${basePath}/profile`} className="btn-secondary btn-sm">Edit →</Link>
            </Row>
            <Row icon="🔒" label="Change Password" desc="Update your login credentials" iconBg="bg-amber-50">
              <Link to={`${basePath}/profile`} className="btn-secondary btn-sm">Change →</Link>
            </Row>
          </Section>

          {/* Danger zone */}
          <div className="bg-red-50 border border-red-200 rounded-2xl p-5">
            <div className="flex items-center gap-2 mb-1">
              <span>⚠️</span>
              <h3 className="text-xs font-bold text-red-700 uppercase tracking-widest">Danger Zone</h3>
            </div>
            <p className="text-xs text-red-400 mb-4 leading-relaxed">
              Signing out will end your current session immediately.
            </p>
            <button
              onClick={() => { logout(); navigate('/login'); }}
              className="btn-danger btn-sm"
            >
              🚪 Sign Out
            </button>
          </div>
        </div>
      )}

      {/* ── System tab ── */}
      {tab === 'system' && (
        <div>
          <Section title="Application">
            <Row icon="📚" label="LibraryMS" desc="RUPP Library Management System — Y2S2" iconBg="bg-blue-50">
              <span className="text-xs font-mono text-gray-400 bg-gray-100 px-2.5 py-1 rounded-lg border border-gray-200">
                v1.0.0
              </span>
            </Row>
            <Row icon="⚛️" label="Frontend" desc="React 18 + Vite 5 + Tailwind CSS 3" iconBg="bg-cyan-50">
              <span className="badge bg-cyan-100 text-cyan-700">Running</span>
            </Row>
          </Section>

          <Section title="Backend & Database">
            <Row icon="🗄️" label="Database" desc="SQLite · better-sqlite3 (file-based)" iconBg="bg-emerald-50">
              <span className="badge bg-emerald-100 text-emerald-700">● Connected</span>
            </Row>
            <Row icon="⚡" label="Backend API" desc="Express.js on port 5000" iconBg="bg-purple-50">
              <span className="badge bg-emerald-100 text-emerald-700">● Online</span>
            </Row>
            <Row icon="🔑" label="Auth" desc="JWT · bcrypt password hashing" iconBg="bg-amber-50">
              <span className="badge bg-amber-100 text-amber-700">Secured</span>
            </Row>
          </Section>

          <Section title="About">
            <Row icon="🏫" label="Institution" desc="Royal University of Phnom Penh" iconBg="bg-gray-100">
              <span className="text-xs text-gray-400">RUPP</span>
            </Row>
            <Row icon="📅" label="Academic Year" desc="Year 2 · Semester 2" iconBg="bg-gray-100">
              <span className="text-xs text-gray-400">2025 – 2026</span>
            </Row>
          </Section>
        </div>
      )}

    </div>
  );
}
