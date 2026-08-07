import { useState, useEffect, useCallback, useRef } from 'react';
import api from '../../services/api';
import { Library, BookOpen, CheckCircle, AlertTriangle, Plus, Pencil, Trash2, Inbox, X, Check } from 'lucide-react';

const EMPTY = { title: '', author: '', isbn: '', category: '', total_copies: 1, published_year: '', description: '', cover_url: '' };

const CATEGORIES = ['Fiction', 'Non-Fiction', 'Science', 'Technology', 'History', 'Biography', 'Art', 'Philosophy', 'Religion', 'Law', 'Medicine', 'Other'];

/* ── Cover placeholder ───────────────────────────────────────── */
const GRADIENTS = [
  'from-blue-500 to-indigo-600',   'from-violet-500 to-purple-700',
  'from-emerald-500 to-teal-600',  'from-orange-400 to-red-500',
  'from-pink-400 to-rose-600',     'from-cyan-400 to-blue-600',
  'from-amber-400 to-orange-500',  'from-teal-500 to-green-600',
];
const gradient = (id) => GRADIENTS[id % GRADIENTS.length];

function BookCover({ id, title, isbn, cover_url, size = 'md' }) {
  const [olFailed, setOlFailed] = useState(false);
  const initials = title?.split(' ').map(w => w[0]).join('').slice(0, 2).toUpperCase() || '??';
  const cls = size === 'sm' ? 'w-9 h-12 text-xs' : 'w-11 h-14 text-sm';

  if (cover_url) {
    return <img src={cover_url} alt={title} className={`${cls} rounded-lg object-cover flex-shrink-0 shadow-sm`} />;
  }
  if (isbn && !olFailed) {
    return (
      <img
        src={`https://covers.openlibrary.org/b/isbn/${isbn}-M.jpg`}
        alt={title}
        onError={() => setOlFailed(true)}
        className={`${cls} rounded-lg object-cover flex-shrink-0 shadow-sm`}
      />
    );
  }
  return (
    <div className={`${cls} bg-gradient-to-br ${gradient(id)} rounded-lg flex items-center justify-center
      text-white font-extrabold flex-shrink-0 shadow-sm`}>
      {initials}
    </div>
  );
}

/* ── Availability bar ────────────────────────────────────────── */
function AvailBar({ available, total }) {
  const pct = total > 0 ? Math.round((available / total) * 100) : 0;
  const color = pct === 0 ? 'bg-red-500' : pct < 40 ? 'bg-amber-500' : 'bg-emerald-500';
  return (
    <div className="flex flex-col gap-1 min-w-[64px]">
      <div className="flex items-center justify-between">
        <span className={`text-xs font-bold ${pct === 0 ? 'text-red-500' : pct < 40 ? 'text-amber-600' : 'text-emerald-600'}`}>
          {available}/{total}
        </span>
      </div>
      <div className="w-full h-1.5 bg-gray-100 rounded-full overflow-hidden">
        <div className={`h-full ${color} rounded-full transition-all`} style={{ width: `${pct}%` }}/>
      </div>
    </div>
  );
}

/* ── Field component ─────────────────────────────────────────── */
function Field({ label, children, span2 = false }) {
  return (
    <div className={span2 ? 'sm:col-span-2' : ''}>
      <label className="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1.5">{label}</label>
      {children}
    </div>
  );
}

const inputCls = `w-full bg-gray-50 border border-gray-200 rounded-xl px-3.5 py-2.5 text-sm text-gray-900
  placeholder-gray-400 outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all`;

/* ── Add / Edit modal ────────────────────────────────────────── */
function BookModal({ mode, form, onChange, onSave, onClose, saving, imgError, setImgError }) {
  const f        = (k) => (e) => onChange(k, e.target.value);
  const fileRef  = useRef(null);

  const [olFailed, setOlFailed] = useState(false);

  useEffect(() => { setOlFailed(false); }, [form.isbn]);

  const handleUpload = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (file.size > 2 * 1024 * 1024) { setImgError('Image must be under 2 MB'); return; }
    setImgError('');
    const reader = new FileReader();
    reader.onload = () => onChange('cover_url', reader.result);
    reader.readAsDataURL(file);
    e.target.value = '';
  };

  const removeCover = () => { onChange('cover_url', ''); setOlFailed(false); };

  /* What to show in the preview */
  const previewSrc = form.cover_url
    ? form.cover_url
    : (form.isbn && !olFailed)
      ? `https://covers.openlibrary.org/b/isbn/${form.isbn.replace(/[-\s]/g, '')}-M.jpg`
      : null;

  const isCustom = !!form.cover_url;
  const initials = form.title?.split(' ').filter(Boolean).map(w => w[0]).join('').slice(0, 2).toUpperCase() || '??';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
      onClick={onClose}>
      <div className="bg-white rounded-3xl shadow-2xl w-full max-w-lg max-h-[92vh] overflow-y-auto"
        onClick={e => e.stopPropagation()}>

        {/* Header */}
        <div className="flex items-center justify-between px-6 py-5 border-b border-gray-100">
          <div className="flex items-center gap-3">
            <div className={`w-9 h-9 bg-gradient-to-br ${mode === 'add' ? 'from-blue-500 to-indigo-600' : 'from-amber-400 to-orange-500'} rounded-xl flex items-center justify-center shadow-sm`}>
              {mode === 'add' ? <Plus className="w-5 h-5 text-white" /> : <Pencil className="w-5 h-5 text-white" />}
            </div>
            <div>
              <p className="font-extrabold text-gray-900">{mode === 'add' ? 'Add New Book' : 'Edit Book'}</p>
              <p className="text-xs text-gray-400">{mode === 'add' ? 'Fill in the book details below' : 'Update the book information'}</p>
            </div>
          </div>
          <button onClick={onClose}
            className="w-8 h-8 rounded-full bg-gray-100 hover:bg-gray-200 flex items-center justify-center text-gray-500 transition-colors">
            ✕
          </button>
        </div>

        <form onSubmit={onSave} className="p-6 space-y-5">

          {/* ── Cover upload zone ── */}
          <div className="flex items-start gap-5 p-4 bg-gray-50 rounded-2xl border border-gray-100">

            {/* Clickable cover */}
            <div className="flex flex-col items-center gap-2 flex-shrink-0">
              <input ref={fileRef} type="file" accept="image/*" className="hidden" onChange={handleUpload} />

              <div className="relative group">
                <button
                  type="button"
                  onClick={() => fileRef.current?.click()}
                  className="w-20 h-28 rounded-xl overflow-hidden shadow-md focus:outline-none focus:ring-2 focus:ring-blue-400 block"
                  title="Upload cover image"
                >
                  {previewSrc ? (
                    <img
                      src={previewSrc}
                      alt="Cover"
                      onError={() => { if (!isCustom) setOlFailed(true); }}
                      className="w-full h-full object-cover"
                    />
                  ) : (
                    <div className={`w-full h-full flex items-center justify-center font-extrabold text-lg text-white
                      ${form.title ? 'bg-gradient-to-br from-blue-500 to-indigo-600' : 'bg-gradient-to-br from-slate-300 to-slate-400'}`}>
                      {form.title ? initials : <BookOpen className="w-8 h-8 text-white opacity-50" />}
                    </div>
                  )}
                  {/* hover overlay */}
                  <div className="absolute inset-0 bg-black/50 flex flex-col items-center justify-center
                    opacity-0 group-hover:opacity-100 transition-opacity rounded-xl">
                    <svg className="w-6 h-6 text-white" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
                      <path strokeLinecap="round" d="M6.827 6.175A2.31 2.31 0 0 1 5.186 7.23c-.38.054-.757.112-1.134.175C2.999 7.58 2.25 8.507 2.25 9.574V18a2.25 2.25 0 0 0 2.25 2.25h15A2.25 2.25 0 0 0 21.75 18V9.574c0-1.067-.75-1.994-1.802-2.169a47.865 47.865 0 0 0-1.134-.175 2.31 2.31 0 0 1-1.64-1.055l-.822-1.316a2.192 2.192 0 0 0-1.736-1.039 48.774 48.774 0 0 0-5.232 0 2.192 2.192 0 0 0-1.736 1.039l-.821 1.316Z"/>
                      <path strokeLinecap="round" d="M16.5 12.75a4.5 4.5 0 1 1-9 0 4.5 4.5 0 0 1 9 0ZM18.75 10.5h.008v.008h-.008V10.5Z"/>
                    </svg>
                    <span className="text-white text-[11px] font-bold mt-1">Upload</span>
                  </div>
                </button>

                {/* Remove button — only when custom image is set */}
                {isCustom && (
                  <button
                    type="button"
                    onClick={removeCover}
                    title="Remove custom image"
                    className="absolute -top-1.5 -right-1.5 w-5 h-5 bg-red-500 hover:bg-red-600 text-white rounded-full
                      flex items-center justify-center text-[10px] font-bold shadow transition-colors z-10"
                  >✕</button>
                )}
              </div>

              {/* Status label */}
              <p className="text-[10px] text-gray-400 text-center leading-snug max-w-[80px]">
                {isCustom
                  ? 'Custom image'
                  : (form.isbn && !olFailed)
                    ? 'Open Library'
                    : 'Click to upload'}
              </p>

              {imgError && (
                <p className="text-[10px] text-red-500 font-semibold text-center max-w-[80px]">{imgError}</p>
              )}
            </div>

            {/* Live text preview */}
            <div className="flex-1 min-w-0 pt-1">
              <p className="text-sm font-bold text-gray-900 line-clamp-2 leading-snug">
                {form.title || <span className="text-gray-300 font-normal italic">Book title…</span>}
              </p>
              <p className="text-xs text-gray-400 mt-1 truncate">
                {form.author || <span className="text-gray-300 italic">Author…</span>}
              </p>
              {form.isbn && <p className="text-[11px] text-gray-400 font-mono mt-1 truncate">{form.isbn}</p>}
              {form.category && (
                <span className="inline-block mt-2 text-[10px] font-bold px-2 py-0.5 rounded-full bg-blue-100 text-blue-700">
                  {form.category}
                </span>
              )}
              <button
                type="button"
                onClick={() => fileRef.current?.click()}
                className="mt-3 flex items-center gap-1.5 text-[11px] font-bold text-blue-600 hover:text-blue-500 transition-colors"
              >
                <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path strokeLinecap="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5m-13.5-9L12 3m0 0 4.5 4.5M12 3v13.5"/>
                </svg>
                {isCustom ? 'Replace image' : 'Upload cover image'}
              </button>
              {isCustom && (
                <button
                  type="button"
                  onClick={removeCover}
                  className="mt-1 flex items-center gap-1.5 text-[11px] font-bold text-red-400 hover:text-red-500 transition-colors"
                >
                  <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                    <path strokeLinecap="round" d="M6 18 18 6M6 6l12 12"/>
                  </svg>
                  Remove image
                </button>
              )}
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Field label="Title *" span2>
              <input className={inputCls} value={form.title} onChange={f('title')} placeholder="Book title" required />
            </Field>
            <Field label="Author *" span2>
              <input className={inputCls} value={form.author} onChange={f('author')} placeholder="Author name" required />
            </Field>
            <Field label="ISBN">
              <input className={inputCls} value={form.isbn} onChange={f('isbn')} placeholder="e.g. 978-0-00-000000-0" />
            </Field>
            <Field label="Category">
              <select className={inputCls} value={form.category} onChange={f('category')}>
                <option value="">— Select —</option>
                {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
              </select>
            </Field>
            <Field label="Total Copies">
              <input type="number" min={1} max={999} className={inputCls} value={form.total_copies} onChange={f('total_copies')} />
            </Field>
            <Field label="Published Year">
              <input type="number" min={1000} max={2099} className={inputCls} value={form.published_year} onChange={f('published_year')} placeholder="e.g. 2023" />
            </Field>
            <Field label="Description" span2>
              <textarea rows={3} className={`${inputCls} resize-none`} value={form.description} onChange={f('description')} placeholder="Short description (optional)" />
            </Field>
          </div>

          <div className="flex gap-3 pt-2">
            <button type="button" onClick={onClose}
              className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold py-3 rounded-xl text-sm transition-colors">
              Cancel
            </button>
            <button type="submit" disabled={saving}
              className="flex-1 bg-blue-600 hover:bg-blue-500 disabled:opacity-60 text-white font-bold py-3 rounded-xl text-sm transition-colors shadow-md shadow-blue-200 flex items-center justify-center gap-2">
              {saving
                ? <><span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/> Saving…</>
                : mode === 'add' ? 'Add Book' : 'Save Changes'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

/* ── Delete modal ────────────────────────────────────────────── */
function DeleteModal({ book, onConfirm, onClose, saving }) {
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
      onClick={onClose}>
      <div className="bg-white rounded-3xl shadow-2xl w-full max-w-sm p-6" onClick={e => e.stopPropagation()}>
        <div className="flex items-center gap-3 mb-4">
          <div className="w-10 h-10 bg-red-100 rounded-2xl flex items-center justify-center">
            <Trash2 className="w-5 h-5 text-red-500" />
          </div>
          <div>
            <p className="font-extrabold text-gray-900">Delete Book</p>
            <p className="text-xs text-gray-400">This action cannot be undone</p>
          </div>
        </div>
        <p className="text-sm text-gray-600 bg-gray-50 rounded-xl p-3 mb-5">
          Are you sure you want to delete <span className="font-bold text-gray-900">"{book.title}"</span>?
          Books with active loans cannot be deleted.
        </p>
        <div className="flex gap-3">
          <button onClick={onClose}
            className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold py-3 rounded-xl text-sm transition-colors">
            Cancel
          </button>
          <button onClick={onConfirm} disabled={saving}
            className="flex-1 bg-red-600 hover:bg-red-700 disabled:opacity-60 text-white font-bold py-3 rounded-xl text-sm transition-colors flex items-center justify-center gap-2">
            {saving ? <><span className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"/> Deleting…</> : <><Trash2 className="w-4 h-4" /> Delete</>}
          </button>
        </div>
      </div>
    </div>
  );
}

/* ── Main page ───────────────────────────────────────────────── */
export default function BookManagement() {
  const [books,    setBooks]    = useState([]);
  const [total,    setTotal]    = useState(0);
  const [pages,    setPages]    = useState(1);
  const [page,     setPage]     = useState(1);
  const [search,   setSearch]   = useState('');
  const [catFilter,setCatFilter]= useState('');
  const [loading,  setLoading]  = useState(true);
  const [modal,    setModal]    = useState(null);
  const [selected, setSelected] = useState(null);
  const [form,     setForm]     = useState(EMPTY);
  const [saving,   setSaving]   = useState(false);
  const [toast,    setToast]    = useState(null);
  const [imgError, setImgError] = useState('');

  const LIMIT = 15;

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchBooks = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: LIMIT };
      if (search)    params.search   = search;
      if (catFilter) params.category = catFilter;
      const { data } = await api.get('/api/books', { params });
      setBooks(data.books);
      setTotal(data.total);
      setPages(data.pages);
    } finally {
      setLoading(false);
    }
  }, [page, search, catFilter]);

  useEffect(() => { fetchBooks(); }, [fetchBooks]);

  const openAdd = () => { setForm(EMPTY); setSelected(null); setImgError(''); setModal('add'); };
  const openEdit = (b) => {
    setForm({ title: b.title, author: b.author, isbn: b.isbn || '', category: b.category || '',
      total_copies: b.total_copies, published_year: b.published_year || '', description: b.description || '',
      cover_url: b.cover_url || '' });
    setSelected(b); setImgError(''); setModal('edit');
  };
  const openDelete = (b) => { setSelected(b); setModal('delete'); };
  const closeModal = () => { setModal(null); setSelected(null); };

  const onChange = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const handleSave = async (e) => {
    e.preventDefault();
    setSaving(true);
    try {
      if (modal === 'add') {
        await api.post('/api/books', form);
        showToast('Book added successfully!');
      } else {
        await api.put(`/api/books/${selected.id}`, form);
        showToast('Book updated successfully!');
      }
      closeModal();
      fetchBooks();
    } catch (err) {
      showToast(err.response?.data?.message || 'Save failed', 'error');
    } finally {
      setSaving(false);
    }
  };

  const handleDelete = async () => {
    setSaving(true);
    try {
      await api.delete(`/api/books/${selected.id}`);
      showToast('Book deleted.');
      closeModal();
      fetchBooks();
    } catch (err) {
      showToast(err.response?.data?.message || 'Delete failed', 'error');
    } finally {
      setSaving(false);
    }
  };

  /* Count available / out-of-stock */
  const available = books.filter(b => b.available_copies > 0).length;
  const outOfStock = books.filter(b => b.available_copies === 0).length;

  return (
    <div className="max-w-6xl mx-auto">

      {/* ── Toast ── */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          {toast.type === 'error' ? <X className="w-4 h-4" /> : <Check className="w-4 h-4" />} {toast.msg}
        </div>
      )}

      {/* ── Modals ── */}
      {(modal === 'add' || modal === 'edit') && (
        <BookModal mode={modal} form={form} onChange={onChange} onSave={handleSave} onClose={closeModal} saving={saving}
          imgError={imgError} setImgError={setImgError} />
      )}
      {modal === 'delete' && selected && (
        <DeleteModal book={selected} onConfirm={handleDelete} onClose={closeModal} saving={saving} />
      )}

      {/* ── Page header ── */}
      <div className="flex flex-wrap items-start justify-between gap-4 mb-6">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">Book Management</h1>
          <p className="text-sm text-gray-400 mt-0.5">Manage your library catalog</p>
        </div>
        <button onClick={openAdd}
          className="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-500 text-white text-sm font-bold
            px-5 py-2.5 rounded-xl shadow-md shadow-blue-200 transition-colors">
          <Plus className="w-4 h-4" /> Add Book
        </button>
      </div>

      {/* ── Mini stats ── */}
      <div className="grid grid-cols-3 gap-4 mb-6">
        {[
          { label: 'Total Books',   value: total,      color: 'bg-blue-50 text-blue-600',     icon: <Library className="w-5 h-5" /> },
          { label: 'Available',     value: available,  color: 'bg-emerald-50 text-emerald-600',icon: <CheckCircle className="w-5 h-5" /> },
          { label: 'Out of Stock',  value: outOfStock, color: 'bg-red-50 text-red-500',        icon: <AlertTriangle className="w-5 h-5" /> },
        ].map(s => (
          <div key={s.label} className={`${s.color} rounded-2xl p-4 flex items-center gap-3`}>
            <span className="flex-shrink-0">{s.icon}</span>
            <div>
              <p className="text-lg font-extrabold leading-none">{loading ? '…' : s.value}</p>
              <p className="text-xs font-semibold mt-0.5 opacity-80">{s.label}</p>
            </div>
          </div>
        ))}
      </div>

      {/* ── Filters ── */}
      <div className="flex flex-wrap items-center gap-3 mb-5">
        {/* Search */}
        <div className="flex items-center gap-2 bg-white border border-gray-200 rounded-xl px-3.5 py-2.5 shadow-sm
          focus-within:ring-2 focus-within:ring-blue-400 transition-all flex-1 min-w-[160px] max-w-xs">
          <svg className="w-4 h-4 text-gray-400 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
            <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
          </svg>
          <input
            value={search} onChange={e => { setSearch(e.target.value); setPage(1); }}
            placeholder="Search title, author, ISBN…"
            className="text-sm text-gray-700 placeholder-gray-400 outline-none bg-transparent w-full"
          />
          {search && (
            <button onClick={() => setSearch('')} className="text-gray-300 hover:text-gray-500 flex-shrink-0">✕</button>
          )}
        </div>

        {/* Category filter */}
        <select
          value={catFilter} onChange={e => { setCatFilter(e.target.value); setPage(1); }}
          className="bg-white border border-gray-200 rounded-xl px-3.5 py-2.5 text-sm text-gray-600 font-semibold
            shadow-sm outline-none focus:ring-2 focus:ring-blue-400 cursor-pointer">
          <option value="">All Categories</option>
          {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
        </select>

        {(search || catFilter) && (
          <button onClick={() => { setSearch(''); setCatFilter(''); setPage(1); }}
            className="text-sm text-blue-600 hover:text-blue-500 font-semibold transition-colors">
            Clear filters
          </button>
        )}

        <p className="ml-auto text-xs text-gray-400 bg-gray-100 px-3 py-1.5 rounded-full font-semibold">
          {loading ? '…' : `${total} result${total !== 1 ? 's' : ''}`}
        </p>
      </div>

      {/* ── Book list ── */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
        {loading ? (
          <div className="p-4 space-y-3">
            {[1,2,3,4,5].map(i => <div key={i} className="h-16 bg-gray-100 rounded-xl animate-pulse"/>)}
          </div>
        ) : books.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-center px-4">
            <div className="w-16 h-16 bg-gray-100 rounded-2xl flex items-center justify-center mb-3">
              <Inbox className="w-7 h-7 text-gray-400" />
            </div>
            <p className="font-bold text-gray-700">No books found</p>
            <p className="text-sm text-gray-400 mt-1">
              {search || catFilter ? 'Try adjusting your filters' : 'Add your first book to get started'}
            </p>
            {!search && !catFilter && (
              <button onClick={openAdd}
                className="mt-4 inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-500 text-white text-sm font-bold px-6 py-2.5 rounded-xl shadow-md shadow-blue-200 transition-colors">
                <Plus className="w-4 h-4" /> Add First Book
              </button>
            )}
          </div>
        ) : (
          <>
            {/* Table header */}
            <div className="hidden md:grid grid-cols-[1fr_100px_100px_120px_100px] gap-4 px-5 py-3 border-b border-gray-100 bg-gray-50/60">
              {['Book', 'Category', 'ISBN', 'Availability', 'Actions'].map(h => (
                <p key={h} className="text-[11px] font-bold text-gray-400 uppercase tracking-wider">{h}</p>
              ))}
            </div>

            <div className="divide-y divide-gray-50">
              {books.map(book => (
                <div key={book.id}
                  className="flex items-center gap-4 px-5 py-3.5 hover:bg-gray-50/60 transition-colors group">

                  {/* Book info */}
                  <div className="flex items-center gap-3 flex-1 min-w-0">
                    <BookCover id={book.id} title={book.title} isbn={book.isbn} cover_url={book.cover_url} />
                    <div className="min-w-0">
                      <p className="font-bold text-gray-900 text-sm truncate">{book.title}</p>
                      <p className="text-xs text-gray-400 truncate">{book.author}</p>
                      {book.published_year && (
                        <p className="text-[11px] text-gray-300">{book.published_year}</p>
                      )}
                    </div>
                  </div>

                  {/* Category */}
                  <div className="hidden md:block w-[100px] flex-shrink-0">
                    {book.category ? (
                      <span className="inline-block bg-blue-50 text-blue-700 text-[11px] font-bold px-2.5 py-1 rounded-full border border-blue-100 truncate max-w-full">
                        {book.category}
                      </span>
                    ) : <span className="text-gray-300 text-xs">—</span>}
                  </div>

                  {/* ISBN */}
                  <div className="hidden md:block w-[100px] flex-shrink-0">
                    <p className="text-[11px] text-gray-400 font-mono truncate">{book.isbn || '—'}</p>
                  </div>

                  {/* Availability */}
                  <div className="hidden md:block w-[120px] flex-shrink-0">
                    <AvailBar available={book.available_copies} total={book.total_copies} />
                  </div>

                  {/* Actions */}
                  <div className="flex items-center gap-2 flex-shrink-0 w-[100px]">
                    <button onClick={() => openEdit(book)}
                      className="flex items-center gap-1 bg-gray-100 hover:bg-blue-50 hover:text-blue-600
                        border border-transparent hover:border-blue-200 text-gray-600 text-xs font-bold
                        px-3 py-1.5 rounded-lg transition-all">
                      <Pencil className="w-3.5 h-3.5" /> Edit
                    </button>
                    <button onClick={() => openDelete(book)}
                      className="flex items-center gap-1 bg-gray-100 hover:bg-red-50 hover:text-red-500
                        border border-transparent hover:border-red-200 text-gray-400 text-xs font-bold
                        px-2 py-1.5 rounded-lg transition-all">
                      <Trash2 className="w-3.5 h-3.5" />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>

      {/* ── Pagination ── */}
      {pages > 1 && (
        <div className="flex items-center justify-between mt-6">
          <p className="text-sm text-gray-400">
            Page <span className="font-bold text-gray-700">{page}</span> of <span className="font-bold text-gray-700">{pages}</span>
          </p>
          <div className="flex items-center gap-2">
            <button
              onClick={() => setPage(p => Math.max(1, p - 1))}
              disabled={page === 1}
              className="flex items-center gap-1 bg-white border border-gray-200 hover:border-gray-300 disabled:opacity-40
                text-sm font-bold text-gray-600 px-4 py-2 rounded-xl transition-all shadow-sm">
              ← Prev
            </button>
            {/* Page numbers */}
            <div className="flex items-center gap-1">
              {Array.from({ length: Math.min(5, pages) }, (_, i) => {
                const p = page <= 3 ? i + 1 : page + i - 2;
                if (p < 1 || p > pages) return null;
                return (
                  <button key={p} onClick={() => setPage(p)}
                    className={`w-9 h-9 rounded-xl text-sm font-bold transition-all
                      ${page === p ? 'bg-blue-600 text-white shadow-md shadow-blue-200' : 'bg-white border border-gray-200 text-gray-600 hover:border-gray-300'}`}>
                    {p}
                  </button>
                );
              })}
            </div>
            <button
              onClick={() => setPage(p => Math.min(pages, p + 1))}
              disabled={page === pages}
              className="flex items-center gap-1 bg-white border border-gray-200 hover:border-gray-300 disabled:opacity-40
                text-sm font-bold text-gray-600 px-4 py-2 rounded-xl transition-all shadow-sm">
              Next →
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
