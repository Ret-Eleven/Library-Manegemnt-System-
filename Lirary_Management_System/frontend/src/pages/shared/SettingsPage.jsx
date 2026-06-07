import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';

const PREF_KEY = 'lms_prefs';

const DEFAULTS = {
  emailNotifications: true,
  dueDateReminders:   true,
  overdueAlerts:      true,
  newArrivalsDigest:  false,
  compactView:        false,
  showBookCovers:     true,
};

function loadPrefs() {
  try { return { ...DEFAULTS, ...JSON.parse(localStorage.getItem(PREF_KEY) || '{}') }; }
  catch { return { ...DEFAULTS }; }
}

function Toggle({ label, desc, checked, onChange }) {
  return (
    <div className="flex items-center justify-between py-3.5 border-b border-gray-50 last:border-0">
      <div className="flex-1 min-w-0 pr-4">
        <p className="text-sm font-semibold text-gray-800">{label}</p>
        {desc && <p className="text-xs text-gray-400 mt-0.5">{desc}</p>}
      </div>
      <button
        type="button"
        onClick={onChange}
        className={`relative inline-flex h-6 w-11 flex-shrink-0 items-center rounded-full transition-colors
          ${checked ? 'bg-blue-600' : 'bg-gray-200'}`}
      >
        <span className={`inline-block h-4 w-4 transform rounded-full bg-white shadow transition-transform
          ${checked ? 'translate-x-6' : 'translate-x-1'}`} />
      </button>
    </div>
  );
}

export default function SettingsPage() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const [prefs, setPrefs] = useState(loadPrefs);
  const [saved,  setSaved]  = useState(false);

  const toggle = key => {
    setPrefs(p => ({ ...p, [key]: !p[key] }));
    setSaved(false);
  };

  const savePrefs = () => {
    localStorage.setItem(PREF_KEY, JSON.stringify(prefs));
    setSaved(true);
    setTimeout(() => setSaved(false), 2500);
  };

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <div className="max-w-2xl space-y-6">

      {/* Header */}
      <div>
        <h1 className="text-2xl font-extrabold text-gray-900">Settings</h1>
        <p className="text-sm text-gray-400 mt-0.5">Manage your preferences and account settings</p>
      </div>

      {/* Notifications */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6">
        <div className="flex items-center gap-2 mb-2">
          <span className="text-lg">🔔</span>
          <h3 className="font-extrabold text-gray-900">Notifications</h3>
        </div>
        <Toggle label="Email Notifications"  desc="Receive updates and alerts via email"            checked={prefs.emailNotifications} onChange={() => toggle('emailNotifications')} />
        <Toggle label="Due Date Reminders"   desc="Get reminded 2 days before books are due"       checked={prefs.dueDateReminders}   onChange={() => toggle('dueDateReminders')} />
        <Toggle label="Overdue Alerts"       desc="Be notified when a book becomes overdue"         checked={prefs.overdueAlerts}      onChange={() => toggle('overdueAlerts')} />
        <Toggle label="New Arrivals Digest"  desc="Weekly digest about newly added books"           checked={prefs.newArrivalsDigest}  onChange={() => toggle('newArrivalsDigest')} />
      </div>

      {/* Display */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6">
        <div className="flex items-center gap-2 mb-2">
          <span className="text-lg">🖥️</span>
          <h3 className="font-extrabold text-gray-900">Display</h3>
        </div>
        <Toggle label="Compact View"    desc="Show more items with less spacing"            checked={prefs.compactView}    onChange={() => toggle('compactView')} />
        <Toggle label="Show Book Covers" desc="Display cover images in the book catalog"   checked={prefs.showBookCovers} onChange={() => toggle('showBookCovers')} />
      </div>

      {/* Account info */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6">
        <div className="flex items-center gap-2 mb-4">
          <span className="text-lg">👤</span>
          <h3 className="font-extrabold text-gray-900">Account</h3>
        </div>
        <div className="space-y-0 text-sm divide-y divide-gray-50">
          {[
            { label: 'Name',  value: user?.name },
            { label: 'Email', value: user?.email },
            { label: 'Role',  value: user?.role === 'superadmin' ? 'Director' : user?.role === 'admin' ? 'Librarian' : 'Student' },
          ].map(row => (
            <div key={row.label} className="flex justify-between py-3">
              <span className="text-gray-400">{row.label}</span>
              <span className="font-semibold text-gray-900">{row.value}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Save button */}
      <div>
        <button
          onClick={savePrefs}
          className={`px-6 py-2.5 rounded-xl text-sm font-bold transition-all
            ${saved ? 'bg-emerald-600 text-white' : 'bg-slate-900 hover:bg-slate-700 text-white'}`}
        >
          {saved ? '✓ Saved!' : 'Save Preferences'}
        </button>
      </div>

      {/* Danger zone */}
      <div className="bg-red-50 border border-red-100 rounded-2xl p-6">
        <div className="flex items-center gap-2 mb-2">
          <span className="text-lg">⚠️</span>
          <h3 className="font-extrabold text-red-700">Danger Zone</h3>
        </div>
        <p className="text-sm text-red-600 mb-4">Sign out of your account on this device.</p>
        <button
          onClick={handleLogout}
          className="bg-red-600 hover:bg-red-700 text-white text-sm font-bold px-5 py-2.5 rounded-xl transition-colors"
        >
          Sign Out
        </button>
      </div>

    </div>
  );
}
