import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import api from '../services/api';
import { Library, GraduationCap, Globe, BookOpen, Bell, BarChart3, Zap, CheckCircle, Clock } from 'lucide-react';

/* ── Password strength ───────────────────────────────────────── */
function calcStrength(pw) {
  if (!pw) return 0;
  let score = 0;
  if (pw.length >= 6)  score++;
  if (pw.length >= 10) score++;
  if (/[A-Z]/.test(pw) && /[a-z]/.test(pw)) score++;
  if (/\d/.test(pw))   score++;
  if (/[^A-Za-z0-9]/.test(pw)) score++;
  return Math.min(score, 4);
}

const STRENGTH_META = [
  { label: 'Too short',    color: 'bg-red-500',    text: 'text-red-500'    },
  { label: 'Weak',         color: 'bg-orange-500', text: 'text-orange-500' },
  { label: 'Fair',         color: 'bg-yellow-500', text: 'text-yellow-600' },
  { label: 'Good',         color: 'bg-blue-500',   text: 'text-blue-600'   },
  { label: 'Strong',       color: 'bg-emerald-500',text: 'text-emerald-600'},
];

function PasswordStrength({ pw }) {
  const score = calcStrength(pw);
  if (!pw) return null;
  const meta = STRENGTH_META[score];
  return (
    <div className="mt-2">
      <div className="flex gap-1 mb-1">
        {[1, 2, 3, 4].map(i => (
          <div key={i}
            className={`h-1 flex-1 rounded-full transition-all duration-300
              ${i <= score ? meta.color : 'bg-gray-200'}`}
          />
        ))}
      </div>
      <p className={`text-[11px] font-semibold ${meta.text}`}>{meta.label}</p>
    </div>
  );
}

/* ── Reusable field ──────────────────────────────────────────── */
function Field({ label, badge, error, children }) {
  return (
    <div>
      <div className="flex items-center gap-2 mb-1.5">
        <label className="block text-xs font-bold text-gray-500 uppercase tracking-wider">{label}</label>
        {badge && (
          <span className="inline-flex items-center gap-1 text-[10px] font-bold px-2 py-0.5 rounded-full bg-emerald-100 text-emerald-700">
            <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"/> {badge}
          </span>
        )}
      </div>
      {children}
      {error && (
        <p className="mt-1 text-[11px] text-red-500 flex items-center gap-1">
          <svg className="w-3 h-3 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clipRule="evenodd"/>
          </svg>
          {error}
        </p>
      )}
    </div>
  );
}

const inputCls = (hasErr) =>
  `w-full bg-white border rounded-xl px-4 py-2.5 text-sm text-gray-900 placeholder-gray-400 outline-none
   focus:ring-2 focus:border-transparent transition-all shadow-sm
   ${hasErr
     ? 'border-red-300 focus:ring-red-400 bg-red-50/30'
     : 'border-gray-200 focus:ring-blue-500'}`;

/* ── Step 1: Choose type ─────────────────────────────────────── */
function ChooseType({ onSelect }) {
  const [hovered, setHovered] = useState(null);

  const cards = [
    {
      type:    'student',
      icon:    <GraduationCap className="w-10 h-10 text-white" />,
      title:   'I am a Student',
      desc:    'Registered at RUPP or a partner institution. Gain full borrowing access with instant email verification.',
      perks:   ['Instant email verification', '5 books at once', 'Extended loan periods', 'Free fines waiver (first offence)'],
      from:    'from-blue-600',
      to:      'to-indigo-700',
      ring:    'ring-blue-500',
      badge:   'bg-blue-500/15 text-blue-300 border-blue-500/20',
      badgeTxt:'Most Common',
    },
    {
      type:    'public',
      icon:    <Globe className="w-10 h-10 text-white" />,
      title:   'General Public / Staff',
      desc:    'Community member, alumni, or staff. Access the library with a standard public membership.',
      perks:   ['Open to all community', '3 books at once', 'Standard loan period', 'Manual ID verification'],
      from:    'from-slate-700',
      to:      'to-slate-800',
      ring:    'ring-slate-500',
      badge:   'bg-slate-500/15 text-slate-300 border-slate-500/20',
      badgeTxt:'Public Access',
    },
  ];

  return (
    <div className="w-full max-w-2xl">
      <div className="text-center mb-10">
        <div className="inline-flex items-center justify-center w-14 h-14 bg-blue-600 rounded-2xl mb-4 shadow-lg shadow-blue-900/30">
          <Library className="w-7 h-7 text-white" />
        </div>
        <h1 className="text-2xl font-extrabold text-gray-900">Create your LibraryOS account</h1>
        <p className="text-gray-400 text-sm mt-2">Choose the option that best describes you to get started.</p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 mb-8">
        {cards.map(c => (
          <button
            key={c.type}
            type="button"
            onClick={() => onSelect(c.type)}
            onMouseEnter={() => setHovered(c.type)}
            onMouseLeave={() => setHovered(null)}
            className={`relative text-left overflow-hidden rounded-2xl p-6 border-2 transition-all duration-200
              bg-gradient-to-br ${c.from} ${c.to}
              ${hovered === c.type ? `ring-2 ${c.ring} scale-[1.02] shadow-2xl` : 'border-white/10 shadow-lg'}`}
          >
            {/* Dot texture */}
            <div className="absolute inset-0 opacity-[0.04] pointer-events-none"
              style={{ backgroundImage: 'radial-gradient(circle at 1px 1px,white 1px,transparent 0)', backgroundSize: '20px 20px' }}/>

            <div className="relative">
              {/* Badge */}
              <span className={`inline-block text-[10px] font-bold px-2.5 py-1 rounded-full border mb-4 ${c.badge}`}>
                {c.badgeTxt}
              </span>

              <div className="mb-3 flex-shrink-0">{c.icon}</div>
              <h3 className="text-white font-extrabold text-lg mb-2">{c.title}</h3>
              <p className="text-white/50 text-sm leading-relaxed mb-5">{c.desc}</p>

              <ul className="space-y-1.5">
                {c.perks.map(p => (
                  <li key={p} className="flex items-center gap-2 text-white/70 text-xs">
                    <svg className="w-3.5 h-3.5 text-white/40 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                      <path strokeLinecap="round" d="m4.5 12.75 6 6 9-13.5"/>
                    </svg>
                    {p}
                  </li>
                ))}
              </ul>

              <div className="mt-6 flex items-center gap-1.5 text-white font-bold text-sm">
                Select
                <svg className={`w-4 h-4 transition-transform ${hovered === c.type ? 'translate-x-1' : ''}`}
                  fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path strokeLinecap="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3"/>
                </svg>
              </div>
            </div>
          </button>
        ))}
      </div>

      <p className="text-center text-sm text-gray-400">
        Already have an account?{' '}
        <Link to="/login" className="text-blue-600 font-semibold hover:text-blue-500 transition-colors">Sign in</Link>
      </p>
    </div>
  );
}

/* ── Step 2a: Student form ───────────────────────────────────── */
function StudentForm({ onBack, onSuccess, onError, loading, setLoading }) {
  const [form, setForm] = useState({ name: '', email: '', studentId: '', department: '', password: '', confirm: '' });
  const [errors, setErrors] = useState({});
  const [showPw, setShowPw] = useState(false);

  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));

  const isEduEmail = (e) => /\.(edu|edu\.kh|ac\.kh|rupp\.edu\.kh)$/i.test(e) || e.includes('@rupp');

  const validate = () => {
    const errs = {};
    if (!form.name.trim())       errs.name       = 'Full name is required';
    if (!form.email)             errs.email      = 'Email is required';
    if (!form.studentId.trim())  errs.studentId  = 'Student ID is required';
    if (!form.department.trim()) errs.department = 'Department is required';
    if (form.password.length < 6) errs.password  = 'Password must be at least 6 characters';
    if (form.password !== form.confirm) errs.confirm = 'Passwords do not match';
    setErrors(errs);
    return Object.keys(errs).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;
    setLoading(true);
    try {
      await api.post('/api/auth/register', { name: form.name, email: form.email, password: form.password });
      onSuccess();
    } catch (err) {
      onError(err.response?.data?.message || 'Registration failed.');
    } finally {
      setLoading(false);
    }
  };

  const DEPTS = ['Computer Science', 'Information Technology', 'Engineering', 'Business Administration',
    'Economics', 'Law', 'Medicine', 'Natural Science', 'Social Science', 'Education', 'Tourism', 'Other'];

  return (
    <form onSubmit={handleSubmit} className="w-full max-w-md space-y-4">

      {/* Back + title */}
      <div className="mb-6">
        <button type="button" onClick={onBack}
          className="flex items-center gap-1.5 text-xs text-gray-400 hover:text-gray-700 transition-colors mb-4">
          <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
            <path strokeLinecap="round" d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18"/>
          </svg>
          Back
        </button>
        <div className="flex items-center gap-3 mb-1">
          <GraduationCap className="w-6 h-6 text-blue-600" />
          <h2 className="text-xl font-extrabold text-gray-900">Student Registration</h2>
        </div>
        <div className="flex items-center gap-2 mt-2">
          <span className="inline-flex items-center gap-1.5 text-xs font-semibold px-3 py-1 rounded-full bg-emerald-50 border border-emerald-200 text-emerald-700">
            <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"/>
            Instant verification via school email
          </span>
        </div>
      </div>

      {/* Full name */}
      <Field label="Full Name" error={errors.name}>
        <input type="text" value={form.name} onChange={set('name')} placeholder="e.g. Sophea Chan"
          className={inputCls(errors.name)} required />
      </Field>

      {/* Institutional email */}
      <Field
        label="Institutional Email"
        badge={form.email && isEduEmail(form.email) ? 'Verified domain' : null}
        error={errors.email}
      >
        <div className="relative">
          <input type="email" value={form.email} onChange={set('email')} placeholder="you@rupp.edu.kh"
            className={inputCls(errors.email)} required />
          {form.email && isEduEmail(form.email) && (
            <div className="absolute right-3 top-1/2 -translate-y-1/2">
              <svg className="w-4 h-4 text-emerald-500" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd"/>
              </svg>
            </div>
          )}
        </div>
        <p className="mt-1 text-[11px] text-gray-400">Use your official school or university email address.</p>
      </Field>

      {/* Student ID + Department (side by side) */}
      <div className="grid grid-cols-2 gap-3">
        <Field label="Student ID" error={errors.studentId}>
          <input type="text" value={form.studentId} onChange={set('studentId')} placeholder="e.g. 2023-CS-001"
            className={inputCls(errors.studentId)} required />
        </Field>
        <Field label="Department / Major" error={errors.department}>
          <select value={form.department} onChange={set('department')} className={inputCls(errors.department)} required>
            <option value="">Select…</option>
            {DEPTS.map(d => <option key={d} value={d}>{d}</option>)}
          </select>
        </Field>
      </div>

      {/* Password */}
      <Field label="Password" error={errors.password}>
        <div className="relative">
          <input type={showPw ? 'text' : 'password'} value={form.password} onChange={set('password')}
            placeholder="Create a strong password" className={inputCls(errors.password)} required minLength={6} />
          <button type="button" onClick={() => setShowPw(v => !v)} tabIndex={-1}
            className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 transition-colors">
            {showPw
              ? <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88"/></svg>
              : <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path strokeLinecap="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/></svg>
            }
          </button>
        </div>
        <PasswordStrength pw={form.password} />
      </Field>

      {/* Confirm password */}
      <Field label="Confirm Password" error={errors.confirm}>
        <div className="relative">
          <input type={showPw ? 'text' : 'password'} value={form.confirm} onChange={set('confirm')}
            placeholder="Repeat your password" className={inputCls(errors.confirm)} required />
          {form.confirm && form.password === form.confirm && (
            <svg className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-emerald-500" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd"/>
            </svg>
          )}
        </div>
      </Field>

      {/* Terms */}
      <p className="text-xs text-gray-400 leading-relaxed">
        By creating an account you agree to our{' '}
        <span className="text-blue-600 cursor-pointer hover:underline">Terms of Service</span>{' '}and{' '}
        <span className="text-blue-600 cursor-pointer hover:underline">Privacy Policy</span>.
      </p>

      {/* Submit */}
      <button type="submit" disabled={loading}
        className="w-full bg-blue-600 hover:bg-blue-500 active:bg-blue-700 disabled:opacity-60 text-white
          font-bold py-3 rounded-xl transition-all shadow-lg shadow-blue-200 text-sm flex items-center justify-center gap-2">
        {loading
          ? <><span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/>Creating account…</>
          : <>Create Student Account <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24"><path strokeLinecap="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3"/></svg></>}
      </button>

      <p className="text-center text-sm text-gray-400 pt-1">
        Already have an account?{' '}
        <Link to="/login" className="text-blue-600 font-semibold hover:text-blue-500 transition-colors">Sign in</Link>
      </p>
    </form>
  );
}

/* ── Step 2b: Public / Staff form ────────────────────────────── */
function PublicForm({ onBack, onSuccess, onError, loading, setLoading }) {
  const [form, setForm] = useState({ name: '', email: '', phone: '', nationalId: '', idExpiry: '', address: '', password: '', confirm: '' });
  const [errors, setErrors] = useState({});
  const [showPw, setShowPw] = useState(false);

  const set = k => e => setForm(f => ({ ...f, [k]: e.target.value }));

  const validate = () => {
    const errs = {};
    if (!form.name.trim())      errs.name      = 'Full name is required';
    if (!form.email)            errs.email     = 'Email is required';
    if (!form.phone.trim())     errs.phone     = 'Phone number is required';
    if (!form.nationalId.trim()) errs.nationalId = 'National ID or Passport is required';
    if (!form.idExpiry)         errs.idExpiry  = 'Expiry date is required';
    else if (new Date(form.idExpiry) <= new Date()) errs.idExpiry = 'ID must not be expired';
    if (!form.address.trim())   errs.address   = 'Home address is required';
    if (form.password.length < 6) errs.password = 'Password must be at least 6 characters';
    if (form.password !== form.confirm) errs.confirm = 'Passwords do not match';
    setErrors(errs);
    return Object.keys(errs).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;
    setLoading(true);
    try {
      await api.post('/api/auth/register', { name: form.name, email: form.email, password: form.password });
      onSuccess();
    } catch (err) {
      onError(err.response?.data?.message || 'Registration failed.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="w-full max-w-md space-y-4">

      {/* Back + title */}
      <div className="mb-6">
        <button type="button" onClick={onBack}
          className="flex items-center gap-1.5 text-xs text-gray-400 hover:text-gray-700 transition-colors mb-4">
          <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
            <path strokeLinecap="round" d="M10.5 19.5 3 12m0 0 7.5-7.5M3 12h18"/>
          </svg>
          Back
        </button>
        <div className="flex items-center gap-3 mb-1">
          <Globe className="w-6 h-6 text-slate-600" />
          <h2 className="text-xl font-extrabold text-gray-900">Public / Staff Registration</h2>
        </div>
        <div className="flex items-center gap-2 mt-2">
          <span className="inline-flex items-center gap-1.5 text-xs font-semibold px-3 py-1 rounded-full bg-amber-50 border border-amber-200 text-amber-700">
            <svg className="w-3 h-3" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <path strokeLinecap="round" d="M15 9h3.75M15 12h3.75M15 15h3.75M4.5 19.5h15a2.25 2.25 0 0 0 2.25-2.25V6.75A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25v10.5A2.25 2.25 0 0 0 4.5 19.5Zm6-10.125a1.875 1.875 0 1 1-3.75 0 1.875 1.875 0 0 1 3.75 0Zm1.294 6.336a6.721 6.721 0 0 1-3.17.789 6.721 6.721 0 0 1-3.168-.789 3.376 3.376 0 0 1 6.338 0Z"/>
            </svg>
            Manual ID verification within 24h
          </span>
        </div>
      </div>

      {/* Full name */}
      <Field label="Full Name" error={errors.name}>
        <input type="text" value={form.name} onChange={set('name')} placeholder="e.g. Dara Pech"
          className={inputCls(errors.name)} required />
      </Field>

      {/* Personal email */}
      <Field label="Personal Email" error={errors.email}>
        <input type="email" value={form.email} onChange={set('email')} placeholder="you@gmail.com"
          className={inputCls(errors.email)} required />
      </Field>

      {/* Phone */}
      <Field label="Phone Number" error={errors.phone}>
        <input type="tel" value={form.phone} onChange={set('phone')} placeholder="+855 12 345 678"
          className={inputCls(errors.phone)} required />
      </Field>

      {/* National ID + Expiry (side by side) */}
      <div className="grid grid-cols-2 gap-3">
        <Field label="National ID / Passport" error={errors.nationalId}>
          <input type="text" value={form.nationalId} onChange={set('nationalId')} placeholder="ID or Passport No."
            className={inputCls(errors.nationalId)} required />
        </Field>
        <Field label="ID / Passport Expiry" error={errors.idExpiry}>
          <input type="date" value={form.idExpiry} onChange={set('idExpiry')}
            min={new Date().toISOString().split('T')[0]}
            className={inputCls(errors.idExpiry)} required />
        </Field>
      </div>

      {/* Home address */}
      <Field label="Home Address" error={errors.address}>
        <textarea value={form.address} onChange={set('address')} placeholder="Street, District, Province, Cambodia"
          rows={2}
          className={inputCls(errors.address) + ' resize-none'} required />
      </Field>

      {/* Password */}
      <Field label="Password" error={errors.password}>
        <div className="relative">
          <input type={showPw ? 'text' : 'password'} value={form.password} onChange={set('password')}
            placeholder="Create a strong password" className={inputCls(errors.password)} required minLength={6} />
          <button type="button" onClick={() => setShowPw(v => !v)} tabIndex={-1}
            className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 transition-colors">
            {showPw
              ? <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88"/></svg>
              : <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24"><path strokeLinecap="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"/><path strokeLinecap="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/></svg>
            }
          </button>
        </div>
        <PasswordStrength pw={form.password} />
      </Field>

      {/* Confirm password */}
      <Field label="Confirm Password" error={errors.confirm}>
        <div className="relative">
          <input type={showPw ? 'text' : 'password'} value={form.confirm} onChange={set('confirm')}
            placeholder="Repeat your password" className={inputCls(errors.confirm)} required />
          {form.confirm && form.password === form.confirm && (
            <svg className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-emerald-500" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd"/>
            </svg>
          )}
        </div>
      </Field>

      {/* ID verification notice */}
      <div className="flex items-start gap-2.5 p-3 bg-amber-50 border border-amber-200 rounded-xl">
        <svg className="w-4 h-4 text-amber-500 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
          <path strokeLinecap="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z"/>
        </svg>
        <p className="text-xs text-amber-700 leading-relaxed">
          Your National ID or Passport will be manually verified by library staff within <strong>24 hours</strong> before full access is granted.
        </p>
      </div>

      {/* Terms */}
      <p className="text-xs text-gray-400 leading-relaxed">
        By creating an account you agree to our{' '}
        <span className="text-blue-600 cursor-pointer hover:underline">Terms of Service</span>{' '}and{' '}
        <span className="text-blue-600 cursor-pointer hover:underline">Privacy Policy</span>.
      </p>

      {/* Submit */}
      <button type="submit" disabled={loading}
        className="w-full bg-slate-800 hover:bg-slate-700 active:bg-slate-900 disabled:opacity-60 text-white
          font-bold py-3 rounded-xl transition-all shadow-lg text-sm flex items-center justify-center gap-2">
        {loading
          ? <><span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/>Creating account…</>
          : <>Create Account <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24"><path strokeLinecap="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3"/></svg></>}
      </button>

      <p className="text-center text-sm text-gray-400 pt-1">
        Already have an account?{' '}
        <Link to="/login" className="text-blue-600 font-semibold hover:text-blue-500 transition-colors">Sign in</Link>
      </p>
    </form>
  );
}

/* ── Step 3: Success screen ──────────────────────────────────── */
function SuccessScreen({ type }) {
  const navigate = useNavigate();
  const isStudent = type === 'student';

  return (
    <div className="w-full max-w-sm text-center">
      {/* Animated checkmark circle */}
      <div className="relative mx-auto mb-6 w-24 h-24">
        <div className="absolute inset-0 rounded-full bg-emerald-100 animate-ping opacity-30"/>
        <div className="relative w-24 h-24 bg-emerald-500 rounded-full flex items-center justify-center shadow-xl shadow-emerald-200">
          <svg className="w-12 h-12 text-white" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
            <path strokeLinecap="round" d="m4.5 12.75 6 6 9-13.5"/>
          </svg>
        </div>
      </div>

      <h2 className="text-2xl font-extrabold text-gray-900 mb-2">Account created!</h2>
      <p className="text-gray-400 text-sm leading-relaxed mb-6">
        {isStudent
          ? 'Your student account is ready. Sign in to start borrowing books from the RUPP library.'
          : 'Your account has been submitted. A librarian will verify your ID within 24 hours before granting full access.'}
      </p>

      {/* Status card */}
      <div className={`rounded-2xl border p-4 mb-8 text-left ${isStudent
        ? 'bg-emerald-50 border-emerald-200'
        : 'bg-amber-50 border-amber-200'}`}>
        <div className="flex items-center gap-2 mb-2">
          {isStudent ? <CheckCircle className="w-4 h-4 text-emerald-600" /> : <Clock className="w-4 h-4 text-amber-600" />}
          <p className={`text-xs font-bold ${isStudent ? 'text-emerald-700' : 'text-amber-700'}`}>
            {isStudent ? 'Instantly Active' : 'Pending Verification'}
          </p>
        </div>
        <p className={`text-xs leading-relaxed ${isStudent ? 'text-emerald-600' : 'text-amber-600'}`}>
          {isStudent
            ? 'Your school email was verified automatically. You have full borrowing access.'
            : 'You can sign in now but full borrowing access will be enabled after ID verification.'}
        </p>
      </div>

      <button
        onClick={() => navigate('/login', { state: { message: 'Account created! You can now sign in.' } })}
        className="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold py-3 rounded-xl transition-all shadow-lg shadow-blue-200 text-sm mb-3"
      >
        Go to Sign In
      </button>
      <Link to="/" className="block text-xs text-gray-400 hover:text-gray-600 transition-colors">
        ← Back to home
      </Link>
    </div>
  );
}

/* ── Progress indicator ──────────────────────────────────────── */
function Progress({ step, type }) {
  const steps = ['Choose', type === 'student' ? 'Student Info' : 'Personal Info', 'Done'];
  const idx   = step === 'choose' ? 0 : step === 'form' ? 1 : 2;

  return (
    <div className="flex items-center gap-2 mb-8">
      {steps.map((s, i) => (
        <div key={s} className="flex items-center gap-2">
          <div className={`flex items-center gap-1.5 text-xs font-semibold transition-colors
            ${i <= idx ? 'text-blue-600' : 'text-gray-300'}`}>
            <div className={`w-5 h-5 rounded-full flex items-center justify-center text-[10px] font-bold flex-shrink-0
              ${i < idx ? 'bg-blue-600 text-white' : i === idx ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-400'}`}>
              {i < idx
                ? <svg className="w-3 h-3" fill="none" stroke="currentColor" strokeWidth={3} viewBox="0 0 24 24"><path strokeLinecap="round" d="m4.5 12.75 6 6 9-13.5"/></svg>
                : i + 1}
            </div>
            <span className="hidden sm:block">{s}</span>
          </div>
          {i < steps.length - 1 && (
            <div className={`h-px w-8 sm:w-12 transition-colors ${i < idx ? 'bg-blue-400' : 'bg-gray-200'}`}/>
          )}
        </div>
      ))}
    </div>
  );
}

/* ── Root component ──────────────────────────────────────────── */
export default function Register() {
  const [step,    setStep]    = useState('choose'); // 'choose' | 'form' | 'success'
  const [type,    setType]    = useState(null);     // 'student' | 'public'
  const [error,   setError]   = useState('');
  const [loading, setLoading] = useState(false);

  const handleSelect = (t) => { setType(t); setStep('form'); setError(''); };
  const handleBack   = ()  => { setStep('choose'); setError(''); };
  const handleSuccess = () => setStep('success');
  const handleError   = (msg) => setError(msg);

  return (
    <div className="min-h-screen flex">

      {/* ── Left branding panel ─────────────────────────────── */}
      <div className="hidden lg:flex w-[38%] xl:w-[36%] flex-col relative overflow-hidden sticky top-0 h-screen"
        style={{ background: 'linear-gradient(145deg, #0f1b4c 0%, #1e1b6e 50%, #0f172a 100%)' }}>
        <div className="absolute inset-0 opacity-[0.04] pointer-events-none"
          style={{ backgroundImage: 'radial-gradient(circle at 1px 1px,white 1px,transparent 0)', backgroundSize: '28px 28px' }}/>
        <div className="absolute top-1/3 -left-16 w-72 h-72 bg-blue-600/20 rounded-full blur-3xl pointer-events-none"/>

        <div className="relative flex flex-col h-full px-10 py-10">
          <Link to="/" className="flex items-center gap-3 mb-auto">
            <div className="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg shadow-blue-900/50"><Library className="w-5 h-5 text-white" /></div>
            <div>
              <p className="text-white font-extrabold text-base leading-tight">LibraryOS</p>
              <p className="text-slate-500 text-[11px]">RUPP · Central Library</p>
            </div>
          </Link>

          <div className="my-auto">
            <h2 className="text-3xl font-extrabold text-white leading-tight mb-3">
              Join thousands of<br/>
              <span className="bg-gradient-to-r from-blue-400 to-cyan-400 bg-clip-text text-transparent">
                RUPP readers
              </span>
            </h2>
            <p className="text-slate-400 text-sm leading-relaxed mb-8 max-w-xs">
              Create your free account and get instant access to the university's entire book collection.
            </p>

            {/* Benefit list */}
            {[
              { icon: <BookOpen className="w-4 h-4 text-white" />, text: 'Borrow up to 5 books at once'        },
              { icon: <Bell className="w-4 h-4 text-white" />,     text: 'Smart due-date reminders'             },
              { icon: <BarChart3 className="w-4 h-4 text-white" />,text: 'Full loan history dashboard'          },
              { icon: <Zap className="w-4 h-4 text-white" />,      text: 'Instant online book requests'         },
              { icon: <Globe className="w-4 h-4 text-white" />,    text: 'Access from anywhere, anytime'        },
            ].map(f => (
              <div key={f.text} className="flex items-center gap-3 mb-3">
                <div className="w-7 h-7 bg-white/8 rounded-lg flex items-center justify-center flex-shrink-0">{f.icon}</div>
                <span className="text-slate-300 text-sm">{f.text}</span>
              </div>
            ))}
          </div>

          <p className="text-slate-600 text-xs">© {new Date().getFullYear()} Royal University of Phnom Penh</p>
        </div>
      </div>

      {/* ── Right: form area ────────────────────────────────── */}
      <div className="flex-1 flex flex-col items-center justify-center bg-gray-50 px-6 py-12 overflow-y-auto">

        {/* Mobile logo */}
        <Link to="/" className="flex items-center gap-2 mb-6 lg:hidden">
          <div className="w-8 h-8 bg-blue-600 rounded-xl flex items-center justify-center"><Library className="w-4 h-4 text-white" /></div>
          <span className="text-gray-900 font-extrabold">LibraryOS</span>
        </Link>

        {/* Progress */}
        {step !== 'success' && <Progress step={step} type={type} />}

        {/* Error banner */}
        {error && (
          <div className="w-full max-w-md mb-4 flex items-start gap-2.5 px-4 py-3 bg-red-50 border border-red-200 rounded-xl text-red-600 text-sm">
            <svg className="w-4 h-4 flex-shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clipRule="evenodd"/>
            </svg>
            {error}
          </div>
        )}

        {/* Step content */}
        {step === 'choose' && <ChooseType onSelect={handleSelect} />}
        {step === 'form' && type === 'student' && (
          <StudentForm
            onBack={handleBack}
            onSuccess={handleSuccess}
            onError={handleError}
            loading={loading}
            setLoading={setLoading}
          />
        )}
        {step === 'form' && type === 'public' && (
          <PublicForm
            onBack={handleBack}
            onSuccess={handleSuccess}
            onError={handleError}
            loading={loading}
            setLoading={setLoading}
          />
        )}
        {step === 'success' && <SuccessScreen type={type} />}
      </div>
    </div>
  );
}
