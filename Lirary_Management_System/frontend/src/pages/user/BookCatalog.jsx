import { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';
import { BookOpen, Clock, AlertTriangle, CheckCircle, ArrowDownToLine, X, Inbox, Check } from 'lucide-react';

/* ─── Status pill ─────────────────────────────────────────── */
function StatusPill({ book, loan }) {
  if (loan?.status === 'active') {
    const ov = loan.is_overdue;
    return (
      <span className={`inline-flex items-center gap-1 text-[10px] font-black tracking-widest uppercase px-2.5 py-1 rounded-full border
        ${ov ? 'bg-red-500/20 text-red-300 border-red-500/40 shadow shadow-red-500/20'
             : 'bg-orange-500/20 text-orange-300 border-orange-500/40 shadow shadow-orange-500/20'}`}>
        <span className={`w-1.5 h-1.5 rounded-full animate-pulse ${ov ? 'bg-red-400' : 'bg-orange-400'}`}/>
        {ov ? 'Overdue' : 'Borrowed'}
      </span>
    );
  }
  if (loan?.status === 'pending') return (
    <span className="inline-flex items-center gap-1 text-[10px] font-black tracking-widest uppercase px-2.5 py-1 rounded-full border bg-yellow-500/20 text-yellow-300 border-yellow-500/40">
      <span className="w-1.5 h-1.5 rounded-full bg-yellow-400 animate-pulse"/> Pending
    </span>
  );
  if (book.available_copies < 1) return (
    <span className="inline-flex items-center gap-1 text-[10px] font-black tracking-widest uppercase px-2.5 py-1 rounded-full border bg-orange-500/20 text-orange-300 border-orange-500/40">
      <span className="w-1.5 h-1.5 rounded-full bg-orange-400"/> Borrowed
    </span>
  );
  return (
    <span className="inline-flex items-center gap-1 text-[10px] font-black tracking-widest uppercase px-2.5 py-1 rounded-full border bg-emerald-500/20 text-emerald-300 border-emerald-500/40 shadow shadow-emerald-500/20">
      <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"/> Available
    </span>
  );
}

const GENRE_CLR = {
  'Fiction':'bg-violet-500/15 text-violet-300','Computer Science':'bg-blue-500/15 text-blue-300',
  'History':'bg-amber-500/15 text-amber-300','Philosophy':'bg-teal-500/15 text-teal-300',
  'Science Fiction':'bg-indigo-500/15 text-indigo-300','Self-Help':'bg-emerald-500/15 text-emerald-300',
};
const gc = c => GENRE_CLR[c] || 'bg-white/10 text-white/60';

/* ─── Skeleton ─────────────────────────────────────────────── */
function SkeletonCard() {
  return (
    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden animate-pulse">
      <div className="bg-gray-200" style={{ paddingTop: '140%' }} />
      <div className="p-4 space-y-2">
        <div className="h-3 bg-gray-200 rounded-full w-4/5" />
        <div className="h-3 bg-gray-100 rounded-full w-3/5" />
        <div className="h-8 bg-gray-200 rounded-xl mt-3" />
      </div>
    </div>
  );
}

/* ─── Book card ─────────────────────────────────────────────── */
function BookCard({ book, loan, requesting, onRequest, onDetails }) {
  const [imgErr, setImgErr]     = useState(false);
  const [hovered, setHovered]   = useState(false);
  const canBorrow   = !loan && book.available_copies > 0;
  const isReqesting = requesting === book.id;

  return (
    <div className="group bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden flex flex-col
      hover:shadow-xl hover:-translate-y-1 transition-all duration-300"
      onMouseEnter={() => setHovered(true)} onMouseLeave={() => setHovered(false)}>

      {/* Cover */}
      <div className="relative overflow-hidden bg-gradient-to-br from-slate-800 to-slate-900 flex-shrink-0"
        style={{ paddingTop: '140%' }}>
        <div className="absolute inset-0">
          {book.cover_url && !imgErr ? (
            <img src={book.cover_url} alt={book.title}
              className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              onError={() => setImgErr(true)} />
          ) : (
            <div className="w-full h-full flex flex-col items-center justify-center gap-2 p-4">
              <BookOpen className="w-8 h-8 text-white opacity-30" />
              <p className="text-[10px] text-white/40 text-center line-clamp-3 leading-snug">{book.title}</p>
            </div>
          )}
          {/* gradient overlay */}
          <div className="absolute inset-x-0 bottom-0 h-24 bg-gradient-to-t from-black/80 via-black/20 to-transparent" />

          {/* Status pill — top left */}
          <div className="absolute top-2.5 left-2.5"><StatusPill book={book} loan={loan} /></div>

          {/* Copies badge — top right */}
          {book.available_copies > 0 && !loan && (
            <div className="absolute top-2.5 right-2.5 bg-black/40 backdrop-blur-sm text-white/80
              text-[9px] font-bold px-2 py-0.5 rounded-full border border-white/10">
              {book.available_copies} left
            </div>
          )}

          {/* Hover overlay */}
          <div className={`absolute inset-0 bg-black/50 backdrop-blur-[2px] flex items-center justify-center gap-2
            transition-opacity duration-200 ${hovered ? 'opacity-100' : 'opacity-0'}`}>
            <button onClick={e => { e.stopPropagation(); onDetails(book); }}
              className="bg-white/20 hover:bg-white/30 border border-white/30 text-white text-xs font-bold
              px-3 py-1.5 rounded-xl transition-colors backdrop-blur-sm">Details</button>
            {canBorrow && (
              <button onClick={e => { e.stopPropagation(); onRequest(book.id); }} disabled={isReqesting}
                className="bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold px-3 py-1.5 rounded-xl transition-colors disabled:opacity-60">
                {isReqesting ? '…' : 'Reserve'}
              </button>
            )}
          </div>
        </div>
      </div>

      {/* Card body */}
      <div className="p-4 flex flex-col gap-2 flex-1">
        <div className="flex-1">
          <h3 className="font-bold text-gray-900 text-sm leading-snug line-clamp-2">{book.title}</h3>
          <p className="text-xs text-gray-400 mt-0.5 truncate font-medium">{book.author}</p>
          <div className="flex items-center gap-1.5 mt-2 flex-wrap">
            {book.category && (
              <span className={`text-[9px] font-bold px-2 py-0.5 rounded-full ${gc(book.category)}`}>{book.category}</span>
            )}
            {book.published_year && (
              <span className="text-[9px] text-gray-400 font-medium">{book.published_year}</span>
            )}
          </div>
        </div>

        {/* CTA */}
        {loan?.status === 'pending' ? (
          <div className="mt-1 w-full py-2 rounded-xl text-xs font-bold text-center bg-yellow-50 text-yellow-600 border border-yellow-200 inline-flex items-center justify-center gap-1"><Clock className="w-3 h-3" /> Awaiting approval</div>
        ) : loan?.status === 'active' ? (
          <div className={`mt-1 w-full py-2 rounded-xl text-xs font-bold text-center border inline-flex items-center justify-center gap-1 ${loan.is_overdue ? 'bg-red-50 text-red-600 border-red-200' : 'bg-blue-50 text-blue-600 border-blue-200'}`}>
            {loan.is_overdue ? <><AlertTriangle className="w-3 h-3" /> Overdue</> : <><CheckCircle className="w-3 h-3" /> Borrowed by you</>}
          </div>
        ) : book.available_copies < 1 ? (
          <div className="mt-1 w-full py-2 rounded-xl text-xs font-bold text-center bg-gray-50 text-gray-400 border border-gray-200 cursor-not-allowed">Not Available</div>
        ) : (
          <button onClick={() => onRequest(book.id)} disabled={isReqesting}
            className="mt-1 w-full py-2.5 rounded-xl text-xs font-bold bg-slate-900 hover:bg-slate-700
              active:scale-95 text-white transition-all shadow-sm disabled:opacity-60">
            {isReqesting
              ? <span className="flex items-center justify-center gap-2"><span className="w-3 h-3 border-2 border-white/30 border-t-white rounded-full animate-spin"/>Requesting…</span>
              : <span className="inline-flex items-center gap-1"><ArrowDownToLine className="w-3.5 h-3.5" /> Borrow</span>}
          </button>
        )}
      </div>
    </div>
  );
}

/* ─── Book details modal ─────────────────────────────────────── */
function BookDetailsModal({ book, loan, requesting, onRequest, onClose }) {
  const [imgErr, setImgErr] = useState(false);
  const isRequesting = requesting === book.id;

  useEffect(() => {
    const onKey = e => { if (e.key === 'Escape') onClose(); };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [onClose]);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm"
      onClick={onClose}>
      <div className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto"
        onClick={e => e.stopPropagation()}>
        <div className="relative grid grid-cols-1 sm:grid-cols-[200px_1fr]">
          <button onClick={onClose}
            className="absolute top-3 right-3 z-10 w-8 h-8 bg-black/40 hover:bg-black/60 backdrop-blur-sm
              rounded-full flex items-center justify-center text-white transition-colors">
            <X className="w-4 h-4" />
          </button>

          {/* Cover */}
          <div className="relative bg-gradient-to-br from-slate-800 to-slate-900" style={{ minHeight: '260px' }}>
            {book.cover_url && !imgErr ? (
              <img src={book.cover_url} alt={book.title}
                className="absolute inset-0 w-full h-full object-cover" onError={() => setImgErr(true)} />
            ) : (
              <div className="absolute inset-0 flex flex-col items-center justify-center gap-2 p-4">
                <BookOpen className="w-10 h-10 text-white opacity-30" />
                <p className="text-xs text-white/40 text-center line-clamp-3">{book.title}</p>
              </div>
            )}
            <div className="absolute top-3 left-3"><StatusPill book={book} loan={loan} /></div>
          </div>

          {/* Info */}
          <div className="p-6 flex flex-col gap-3">
            <div>
              <h2 className="text-xl font-extrabold text-gray-900 leading-snug">{book.title}</h2>
              <p className="text-sm text-gray-500 mt-1 font-medium">{book.author}</p>
            </div>

            <div className="flex items-center gap-1.5 flex-wrap">
              {book.category && (
                <span className={`text-[10px] font-bold px-2.5 py-1 rounded-full ${gc(book.category)}`}>{book.category}</span>
              )}
              {book.published_year && (
                <span className="text-[10px] text-gray-400 font-semibold">{book.published_year}</span>
              )}
            </div>

            {book.description && (
              <p className="text-sm text-gray-600 leading-relaxed">{book.description}</p>
            )}

            <div className="grid grid-cols-2 gap-3 text-xs mt-1">
              <div className="bg-gray-50 rounded-xl p-3">
                <p className="text-gray-400 font-bold uppercase tracking-widest text-[9px] mb-0.5">ISBN</p>
                <p className="text-gray-800 font-semibold">{book.isbn || '—'}</p>
              </div>
              <div className="bg-gray-50 rounded-xl p-3">
                <p className="text-gray-400 font-bold uppercase tracking-widest text-[9px] mb-0.5">Copies</p>
                <p className="text-gray-800 font-semibold">{book.available_copies} / {book.total_copies} available</p>
              </div>
            </div>

            <div className="mt-auto pt-2">
              {loan?.status === 'pending' ? (
                <div className="w-full py-2.5 rounded-xl text-sm font-bold text-center bg-yellow-50 text-yellow-600 border border-yellow-200 inline-flex items-center justify-center gap-1.5"><Clock className="w-4 h-4" /> Awaiting approval</div>
              ) : loan?.status === 'active' ? (
                <div className={`w-full py-2.5 rounded-xl text-sm font-bold text-center border inline-flex items-center justify-center gap-1.5 ${loan.is_overdue ? 'bg-red-50 text-red-600 border-red-200' : 'bg-blue-50 text-blue-600 border-blue-200'}`}>
                  {loan.is_overdue ? <><AlertTriangle className="w-4 h-4" /> Overdue</> : <><CheckCircle className="w-4 h-4" /> Borrowed by you</>}
                </div>
              ) : book.available_copies < 1 ? (
                <div className="w-full py-2.5 rounded-xl text-sm font-bold text-center bg-gray-50 text-gray-400 border border-gray-200 cursor-not-allowed">Not Available</div>
              ) : (
                <button onClick={() => onRequest(book.id)} disabled={isRequesting}
                  className="w-full py-3 rounded-xl text-sm font-bold bg-slate-900 hover:bg-slate-700
                    active:scale-95 text-white transition-all shadow-sm disabled:opacity-60">
                  {isRequesting
                    ? <span className="flex items-center justify-center gap-2"><span className="w-3.5 h-3.5 border-2 border-white/30 border-t-white rounded-full animate-spin"/>Requesting…</span>
                    : <span className="inline-flex items-center gap-1.5"><ArrowDownToLine className="w-4 h-4" /> Borrow this book</span>}
                </button>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

/* ─── Pagination ──────────────────────────────────────────────── */
function Pagination({ page, pages, onChange }) {
  if (pages <= 1) return null;
  const nums = pages <= 7
    ? Array.from({ length: pages }, (_, i) => i + 1)
    : page <= 4
      ? [1,2,3,4,5,'…',pages]
      : page >= pages-3
        ? [1,'…',pages-4,pages-3,pages-2,pages-1,pages]
        : [1,'…',page-1,page,page+1,'…',pages];

  return (
    <div className="flex items-center justify-center gap-1.5 pt-8">
      <button onClick={() => onChange(page-1)} disabled={page===1}
        className="px-4 py-2 rounded-xl text-sm font-semibold border border-gray-200 bg-white text-gray-600
          hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors shadow-sm">
        ← Previous
      </button>
      {nums.map((n, i) => n === '…'
        ? <span key={`e${i}`} className="w-9 h-9 flex items-center justify-center text-gray-400">…</span>
        : <button key={n} onClick={() => onChange(n)}
            className={`w-9 h-9 rounded-xl text-sm font-bold transition-all
              ${n===page ? 'bg-slate-900 text-white shadow-sm' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'}`}>
            {n}
          </button>
      )}
      <button onClick={() => onChange(page+1)} disabled={page===pages}
        className="px-4 py-2 rounded-xl text-sm font-semibold border border-gray-200 bg-white text-gray-600
          hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors shadow-sm">
        Next →
      </button>
    </div>
  );
}

/* ─── Main ───────────────────────────────────────────────────── */
export default function BookCatalog() {
  const { user } = useAuth();
  const [books, setBooks]           = useState([]);
  const [categories, setCategories] = useState([]);
  const [myLoans, setMyLoans]       = useState([]);
  const [loading, setLoading]       = useState(true);
  const [page, setPage]             = useState(1);
  const [total, setTotal]           = useState(0);
  const [pages, setPages]           = useState(1);
  const [requesting, setRequesting] = useState(null);
  const [selectedBook, setSelectedBook] = useState(null);
  const [toast, setToast]           = useState(null);
  const [search, setSearch]         = useState('');
  const [debouncedSearch, setDebouncedSearch] = useState('');
  const [category, setCategory]     = useState('');
  const [availability, setAvailability] = useState('');

  const LIMIT = 12;
  const showToast = (msg, type='success') => { setToast({msg,type}); setTimeout(()=>setToast(null),3500); };

  // Debounce the search box so we don't fire an API call on every keystroke
  useEffect(() => {
    const t = setTimeout(() => { setDebouncedSearch(search); setPage(1); }, 350);
    return () => clearTimeout(t);
  }, [search]);

  const fetchBooks = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: LIMIT };
      if (debouncedSearch) params.search   = debouncedSearch;
      if (category)        params.category = category;
      const { data } = await api.get('/api/books', { params });
      let bks = data.books || [];
      if (availability === 'available')   bks = bks.filter(b => b.available_copies > 0);
      if (availability === 'unavailable') bks = bks.filter(b => b.available_copies < 1);
      setBooks(bks); setTotal(data.total); setPages(data.pages);
    } catch { showToast('Failed to load books','error'); }
    finally  { setLoading(false); }
  }, [page, debouncedSearch, category, availability]);

  useEffect(() => { fetchBooks(); }, [fetchBooks]);
  useEffect(() => {
    api.get('/api/books/categories').then(r => setCategories(r.data)).catch(()=>{});
    api.get('/api/loans/my').then(r => setMyLoans(r.data)).catch(()=>{});
  }, []);

  const getLoan = id => myLoans.find(l => l.book_id===id && ['pending','active'].includes(l.status));

  const handleRequest = async id => {
    setRequesting(id);
    try {
      await api.post('/api/loans/request', { book_id: id });
      showToast('Request submitted! An admin will approve it soon.');
      const { data } = await api.get('/api/loans/my');
      setMyLoans(data); fetchBooks();
    } catch (err) { showToast(err.response?.data?.message || 'Request failed','error'); }
    finally { setRequesting(null); }
  };

  const clearAll = () => { setSearch(''); setDebouncedSearch(''); setCategory(''); setAvailability(''); setPage(1); };
  const hasFilter = search || category || availability;

  return (
    <div>
      {/* Toast */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type==='error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          {toast.type==='error'?<X className="w-4 h-4"/>:<Check className="w-4 h-4"/>} {toast.msg}
        </div>
      )}

      {/* Page header */}
      <div className="mb-5">
        <h1 className="text-2xl font-extrabold text-gray-900">Browse Library</h1>
        <p className="text-sm text-gray-400 mt-0.5">Explore and discover books from our collection</p>
      </div>

      {/* Filters */}
      <div className="flex flex-wrap items-center gap-3 mb-6">
        <div className="flex items-center gap-2 bg-white border border-gray-200 rounded-xl px-3.5 py-2.5 shadow-sm
          focus-within:ring-2 focus-within:ring-blue-400 transition-all flex-1 min-w-[200px] max-w-sm">
          <svg className="w-4 h-4 text-gray-400 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
            <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
          </svg>
          <input
            value={search} onChange={e => setSearch(e.target.value)}
            placeholder="Search title, author, ISBN…"
            className="text-sm text-gray-700 placeholder-gray-400 outline-none bg-transparent w-full"
          />
          {search && (
            <button onClick={() => setSearch('')} className="text-gray-300 hover:text-gray-500 flex-shrink-0"><X className="w-3.5 h-3.5" /></button>
          )}
        </div>

        <select
          value={category} onChange={e => { setCategory(e.target.value); setPage(1); }}
          className="bg-white border border-gray-200 rounded-xl px-3.5 py-2.5 text-sm text-gray-600 font-semibold
            shadow-sm outline-none focus:ring-2 focus:ring-blue-400 cursor-pointer">
          <option value="">All Categories</option>
          {categories.map(c => <option key={c} value={c}>{c}</option>)}
        </select>

        <select
          value={availability} onChange={e => { setAvailability(e.target.value); setPage(1); }}
          className="bg-white border border-gray-200 rounded-xl px-3.5 py-2.5 text-sm text-gray-600 font-semibold
            shadow-sm outline-none focus:ring-2 focus:ring-blue-400 cursor-pointer">
          <option value="">All Books</option>
          <option value="available">Available Now</option>
          <option value="unavailable">Currently Borrowed</option>
        </select>

        {hasFilter && (
          <button onClick={clearAll} className="text-sm text-blue-600 hover:text-blue-500 font-semibold transition-colors">
            Clear filters
          </button>
        )}
      </div>

      {/* Grid header */}
      <div className="flex items-end justify-between mb-4">
        <div>
          <h2 className="text-lg font-extrabold text-gray-900">All Books</h2>
          <p className="text-sm text-gray-400 mt-0.5">{loading ? 'Loading…' : `${total} title${total!==1?'s':''} found`}</p>
        </div>
        <div className="hidden sm:flex items-center gap-3 text-[10px] font-bold text-gray-500">
          <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-emerald-400"/>Available</span>
          <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-orange-400"/>Borrowed</span>
          <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-red-400"/>Overdue</span>
        </div>
      </div>

      {/* Grid */}
      {loading ? (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {Array.from({length:LIMIT}).map((_,i)=><SkeletonCard key={i}/>)}
        </div>
      ) : books.length===0 ? (
        <div className="flex flex-col items-center justify-center py-24 bg-white rounded-2xl border border-gray-100">
          <div className="w-20 h-20 bg-gray-100 rounded-3xl flex items-center justify-center mb-4"><Inbox className="w-10 h-10 text-gray-400" /></div>
          <p className="text-lg font-bold text-gray-800">No books found</p>
          <p className="text-sm text-gray-400 mt-1 mb-5">Try different search terms or clear your filters</p>
          <button onClick={clearAll} className="bg-slate-900 hover:bg-slate-700 text-white text-sm font-bold px-6 py-2.5 rounded-xl transition-colors">
            Clear all filters
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {books.map(b => (
            <BookCard key={b.id} book={b} loan={getLoan(b.id)} requesting={requesting} onRequest={handleRequest} onDetails={setSelectedBook}/>
          ))}
        </div>
      )}

      {/* Pagination */}
      <Pagination page={page} pages={pages} onChange={p => { setPage(p); window.scrollTo({top:0,behavior:'smooth'}); }}/>

      {/* Details modal */}
      {selectedBook && (
        <BookDetailsModal book={selectedBook} loan={getLoan(selectedBook.id)} requesting={requesting}
          onRequest={handleRequest} onClose={() => setSelectedBook(null)} />
      )}
    </div>
  );
}
