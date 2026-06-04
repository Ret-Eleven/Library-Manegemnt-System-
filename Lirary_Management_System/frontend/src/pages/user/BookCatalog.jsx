import { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';

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
function BookCard({ book, loan, requesting, onRequest }) {
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
              <span className="text-5xl opacity-30">📖</span>
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
            <button className="bg-white/20 hover:bg-white/30 border border-white/30 text-white text-xs font-bold
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
          <div className="mt-1 w-full py-2 rounded-xl text-xs font-bold text-center bg-yellow-50 text-yellow-600 border border-yellow-200">⏳ Awaiting approval</div>
        ) : loan?.status === 'active' ? (
          <div className={`mt-1 w-full py-2 rounded-xl text-xs font-bold text-center border ${loan.is_overdue ? 'bg-red-50 text-red-600 border-red-200' : 'bg-blue-50 text-blue-600 border-blue-200'}`}>
            {loan.is_overdue ? '⚠️ Overdue' : '✅ Borrowed by you'}
          </div>
        ) : book.available_copies < 1 ? (
          <div className="mt-1 w-full py-2 rounded-xl text-xs font-bold text-center bg-gray-50 text-gray-400 border border-gray-200 cursor-not-allowed">Not Available</div>
        ) : (
          <button onClick={() => onRequest(book.id)} disabled={isReqesting}
            className="mt-1 w-full py-2.5 rounded-xl text-xs font-bold bg-slate-900 hover:bg-slate-700
              active:scale-95 text-white transition-all shadow-sm disabled:opacity-60">
            {isReqesting
              ? <span className="flex items-center justify-center gap-2"><span className="w-3 h-3 border-2 border-white/30 border-t-white rounded-full animate-spin"/>Requesting…</span>
              : '📥 Borrow'}
          </button>
        )}
      </div>
    </div>
  );
}

/* ─── Discovery Banner ──────────────────────────────────────── */
function DiscoveryBanner({ onSearch, categories }) {
  const [f, setF] = useState({ title:'', author:'', isbn:'', category:'', availability:'' });
  const set = k => e => setF(p => ({ ...p, [k]: e.target.value }));

  const input = `w-full bg-white/10 border border-white/20 rounded-xl px-3 py-2.5 text-white
    placeholder-white/40 text-sm outline-none focus:bg-white/20 focus:border-white/50 transition-all backdrop-blur-sm`;

  return (
    <section className="relative overflow-hidden rounded-2xl mb-6"
      style={{ background:'linear-gradient(135deg,#0f1b4c 0%,#1e1b6e 40%,#2d1b69 70%,#1a0533 100%)' }}>
      {/* texture */}
      <div className="absolute inset-0 opacity-[0.04] pointer-events-none"
        style={{ backgroundImage:'repeating-linear-gradient(45deg,transparent,transparent 10px,rgba(255,255,255,.8) 10px,rgba(255,255,255,.8) 11px)' }}/>
      {/* glow */}
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[200px] bg-indigo-500/20 rounded-full blur-3xl pointer-events-none"/>

      <div className="relative px-6 py-8 sm:px-10">
        <p className="text-white font-extrabold text-2xl sm:text-3xl mb-1">Discover Your Next Read</p>
        <p className="text-white/50 text-sm mb-6">Use advanced filters to find the perfect book</p>

        <form onSubmit={e => { e.preventDefault(); onSearch(f); }}>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-3">
            <div>
              <p className="text-white/50 text-[10px] font-bold uppercase tracking-widest mb-1">Title</p>
              <input value={f.title}   onChange={set('title')}   placeholder="e.g. Clean Code"        className={input}/>
            </div>
            <div>
              <p className="text-white/50 text-[10px] font-bold uppercase tracking-widest mb-1">Author</p>
              <input value={f.author}  onChange={set('author')}  placeholder="e.g. Robert Martin"     className={input}/>
            </div>
            <div>
              <p className="text-white/50 text-[10px] font-bold uppercase tracking-widest mb-1">ISBN</p>
              <input value={f.isbn}    onChange={set('isbn')}    placeholder="e.g. 9780132350884"     className={input}/>
            </div>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 items-end">
            <div>
              <p className="text-white/50 text-[10px] font-bold uppercase tracking-widest mb-1">Category</p>
              <select value={f.category} onChange={set('category')} className={input + ' cursor-pointer'}>
                <option value="" className="bg-slate-900">All Categories</option>
                {categories.map(c => <option key={c} value={c} className="bg-slate-900">{c}</option>)}
              </select>
            </div>
            <div>
              <p className="text-white/50 text-[10px] font-bold uppercase tracking-widest mb-1">Availability</p>
              <select value={f.availability} onChange={set('availability')} className={input + ' cursor-pointer'}>
                <option value=""            className="bg-slate-900">All Books</option>
                <option value="available"   className="bg-slate-900">Available Now</option>
                <option value="unavailable" className="bg-slate-900">Currently Borrowed</option>
              </select>
            </div>
            <button type="submit"
              className="flex items-center justify-center gap-2 bg-white text-slate-900 font-extrabold
                py-2.5 px-6 rounded-xl hover:bg-blue-50 active:scale-95 transition-all shadow-lg text-sm tracking-wide">
              <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
              </svg>
              Search
            </button>
          </div>
        </form>
      </div>
    </section>
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
  const [toast, setToast]           = useState(null);
  const [quick, setQuick]           = useState('');
  const [adv, setAdv]               = useState({ title:'', author:'', isbn:'', category:'', availability:'' });

  const LIMIT = 12;
  const showToast = (msg, type='success') => { setToast({msg,type}); setTimeout(()=>setToast(null),3500); };

  const fetchBooks = useCallback(async () => {
    setLoading(true);
    try {
      const search = quick || [adv.title, adv.author, adv.isbn].filter(Boolean).join(' ');
      const params = { page, limit: LIMIT };
      if (search)        params.search   = search;
      if (adv.category)  params.category = adv.category;
      const { data } = await api.get('/api/books', { params });
      let bks = data.books || [];
      if (adv.availability === 'available')   bks = bks.filter(b => b.available_copies > 0);
      if (adv.availability === 'unavailable') bks = bks.filter(b => b.available_copies < 1);
      setBooks(bks); setTotal(data.total); setPages(data.pages);
    } catch { showToast('Failed to load books','error'); }
    finally  { setLoading(false); }
  }, [page, quick, adv]);

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

  const clearAll = () => { setQuick(''); setAdv({ title:'', author:'', isbn:'', category:'', availability:'' }); setPage(1); };
  const hasFilter = quick || Object.values(adv).some(Boolean);

  return (
    <div>
      {/* Toast */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-5 py-3 rounded-2xl shadow-2xl text-sm font-semibold
          ${toast.type==='error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          {toast.type==='error'?'✕':'✓'} {toast.msg}
        </div>
      )}

      {/* Page header */}
      <div className="flex flex-wrap items-center justify-between gap-3 mb-5">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">Browse Library</h1>
          <p className="text-sm text-gray-400 mt-0.5">Explore and discover books from our collection</p>
        </div>
        <div className="flex items-center gap-3">
          <form onSubmit={e => { e.preventDefault(); setPage(1); }}
            className="flex items-center gap-2 bg-white border border-gray-200 rounded-xl px-3 py-2 shadow-sm focus-within:ring-2 focus-within:ring-blue-400 transition-all">
            <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input value={quick} onChange={e => { setQuick(e.target.value); setPage(1); }}
              placeholder="Quick search…"
              className="text-sm text-gray-700 placeholder-gray-400 outline-none bg-transparent w-36 sm:w-44"/>
            {quick && <button type="button" onClick={clearAll} className="text-gray-400 hover:text-gray-600 text-sm">✕</button>}
          </form>
          <button className="w-9 h-9 bg-white border border-gray-200 rounded-xl flex items-center justify-center text-gray-500 hover:bg-gray-50 shadow-sm">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
              <path strokeLinecap="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
            </svg>
          </button>
          {hasFilter && (
            <button onClick={clearAll} className="text-xs text-blue-600 font-semibold hover:underline">Clear ✕</button>
          )}
        </div>
      </div>

      {/* Discovery banner */}
      <DiscoveryBanner onSearch={f => { setAdv(f); setQuick(''); setPage(1); }} categories={categories} />

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
          <div className="w-20 h-20 bg-gray-100 rounded-3xl flex items-center justify-center text-4xl mb-4">📭</div>
          <p className="text-lg font-bold text-gray-800">No books found</p>
          <p className="text-sm text-gray-400 mt-1 mb-5">Try different search terms or clear your filters</p>
          <button onClick={clearAll} className="bg-slate-900 hover:bg-slate-700 text-white text-sm font-bold px-6 py-2.5 rounded-xl transition-colors">
            Clear all filters
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {books.map(b => (
            <BookCard key={b.id} book={b} loan={getLoan(b.id)} requesting={requesting} onRequest={handleRequest}/>
          ))}
        </div>
      )}

      {/* Pagination */}
      <Pagination page={page} pages={pages} onChange={p => { setPage(p); window.scrollTo({top:0,behavior:'smooth'}); }}/>
    </div>
  );
}
