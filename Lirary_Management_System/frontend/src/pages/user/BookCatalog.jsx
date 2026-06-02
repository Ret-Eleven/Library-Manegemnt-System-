import { useState, useEffect, useCallback } from 'react';
import api from '../../services/api';

const CAT_COLOR = {
  'Fiction':          'bg-violet-100 text-violet-700',
  'Computer Science': 'bg-blue-100   text-blue-700',
  'History':          'bg-amber-100  text-amber-700',
  'Philosophy':       'bg-teal-100   text-teal-700',
  'Science Fiction':  'bg-indigo-100 text-indigo-700',
  'Self-Help':        'bg-emerald-100 text-emerald-700',
};
const catColor = (c) => CAT_COLOR[c] || 'bg-gray-100 text-gray-600';

const CAT_ICON = {
  'Fiction': '📖', 'Computer Science': '💻', 'History': '🏛️',
  'Philosophy': '🧠', 'Science Fiction': '🚀', 'Self-Help': '⭐',
};

/* ── Skeleton card ── */
function SkeletonCard() {
  return (
    <div className="bg-white rounded-2xl border border-gray-200 overflow-hidden animate-pulse">
      <div className="bg-gray-200" style={{ paddingTop: '140%' }} />
      <div className="p-4 space-y-2">
        <div className="h-4 bg-gray-200 rounded-full w-3/4" />
        <div className="h-3 bg-gray-100 rounded-full w-1/2" />
        <div className="h-3 bg-gray-100 rounded-full w-1/3 mt-3" />
        <div className="h-9 bg-gray-200 rounded-xl mt-4" />
      </div>
    </div>
  );
}

/* ── Book card ── */
function BookCard({ book, loan, requesting, onRequest }) {
  const unavailable = book.available_copies === 0;
  const isPending   = loan?.status === 'pending';
  const isActive    = loan?.status === 'active';
  const [imgError, setImgError] = useState(false);

  return (
    <div className="group bg-white rounded-2xl border border-gray-200 overflow-hidden flex flex-col hover:shadow-lg hover:-translate-y-0.5 transition-all duration-200">

      {/* ── Cover ── */}
      <div className="relative overflow-hidden bg-gray-100 flex-shrink-0" style={{ paddingTop: '140%' }}>
        <div className="absolute inset-0">
          {book.cover_url && !imgError ? (
            <img
              src={book.cover_url}
              alt={book.title}
              className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
              onError={() => setImgError(true)}
            />
          ) : (
            <div className="w-full h-full flex flex-col items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 gap-2">
              <span className="text-5xl opacity-40">{CAT_ICON[book.category] || '📖'}</span>
              <p className="text-[10px] text-gray-400 font-medium px-2 text-center line-clamp-2">{book.title}</p>
            </div>
          )}

          {/* Dark gradient overlay at bottom */}
          <div className="absolute inset-x-0 bottom-0 h-20 bg-gradient-to-t from-black/60 to-transparent" />

          {/* Availability badge — top right */}
          <div className="absolute top-2.5 right-2.5">
            {unavailable ? (
              <span className="bg-red-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full shadow">
                Unavailable
              </span>
            ) : (
              <span className="bg-emerald-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full shadow">
                {book.available_copies} left
              </span>
            )}
          </div>

          {/* Loan status overlay — bottom of image */}
          {(isPending || isActive) && (
            <div className={`absolute inset-x-0 bottom-0 flex items-center justify-center gap-1.5 py-2 text-xs font-bold
              ${isPending ? 'bg-yellow-500/90 text-white' : 'bg-blue-600/90 text-white'}`}>
              {isPending ? '⏳ Pending approval' : '✅ Borrowed by you'}
            </div>
          )}
        </div>
      </div>

      {/* ── Info ── */}
      <div className="flex flex-col gap-3 p-4 flex-1">
        <div className="flex-1">
          <h3 className="font-bold text-gray-900 leading-snug line-clamp-2 text-sm">{book.title}</h3>
          <p className="text-xs text-gray-400 mt-0.5 font-medium truncate">{book.author}</p>
          <div className="flex items-center gap-1.5 mt-2.5 flex-wrap">
            {book.category && (
              <span className={`text-[10px] font-semibold px-2 py-0.5 rounded-full ${catColor(book.category)}`}>
                {book.category}
              </span>
            )}
            {book.published_year && (
              <span className="text-[10px] text-gray-400">{book.published_year}</span>
            )}
          </div>
        </div>

        {/* ── Action button ── */}
        {isPending ? (
          <div className="w-full text-center py-2.5 rounded-xl text-xs font-bold bg-yellow-50 text-yellow-600 border border-yellow-200">
            ⏳ Awaiting approval
          </div>
        ) : isActive ? (
          <div className="w-full text-center py-2.5 rounded-xl text-xs font-bold bg-blue-50 text-blue-600 border border-blue-200">
            ✅ Borrowed by you
          </div>
        ) : unavailable ? (
          <div className="w-full text-center py-2.5 rounded-xl text-xs font-bold bg-gray-50 text-gray-400 border border-gray-200 cursor-not-allowed">
            Not Available
          </div>
        ) : (
          <button
            onClick={() => onRequest(book.id)}
            disabled={requesting === book.id}
            className="w-full py-2.5 rounded-xl text-xs font-bold bg-blue-600 hover:bg-blue-700 active:scale-95 text-white transition-all shadow-sm shadow-blue-200 disabled:opacity-60"
          >
            {requesting === book.id ? (
              <span className="flex items-center justify-center gap-2">
                <span className="w-3.5 h-3.5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                Requesting…
              </span>
            ) : '📥 Borrow this book'}
          </button>
        )}
      </div>
    </div>
  );
}

/* ── Main page ── */
export default function BookCatalog() {
  const [books, setBooks]           = useState([]);
  const [categories, setCategories] = useState([]);
  const [myLoans, setMyLoans]       = useState([]);
  const [loading, setLoading]       = useState(true);
  const [search, setSearch]         = useState('');
  const [category, setCategory]     = useState('');
  const [page, setPage]             = useState(1);
  const [total, setTotal]           = useState(0);
  const [pages, setPages]           = useState(1);
  const [requesting, setRequesting] = useState(null);
  const [toast, setToast]           = useState(null);

  const LIMIT = 12;

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchBooks = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: LIMIT };
      if (search)   params.search   = search;
      if (category) params.category = category;
      const { data } = await api.get('/api/books', { params });
      setBooks(data.books);
      setTotal(data.total);
      setPages(data.pages);
    } catch {
      showToast('Failed to load books', 'error');
    } finally {
      setLoading(false);
    }
  }, [page, search, category]);

  useEffect(() => { fetchBooks(); }, [fetchBooks]);

  useEffect(() => {
    api.get('/api/books/categories').then(r => setCategories(r.data));
    api.get('/api/loans/my').then(r => setMyLoans(r.data));
  }, []);

  const getLoanStatus = (bookId) =>
    myLoans.find(l => l.book_id === bookId && ['pending', 'active'].includes(l.status));

  const handleRequest = async (bookId) => {
    setRequesting(bookId);
    try {
      await api.post('/api/loans/request', { book_id: bookId });
      showToast('Request submitted! An admin will approve it soon.');
      const { data } = await api.get('/api/loans/my');
      setMyLoans(data);
      fetchBooks();
    } catch (err) {
      showToast(err.response?.data?.message || 'Request failed', 'error');
    } finally {
      setRequesting(null);
    }
  };

  const clearAll = () => { setSearch(''); setCategory(''); setPage(1); };

  return (
    <div className="space-y-5">

      {/* ── Toast ── */}
      {toast && (
        <div className={`fixed top-5 right-5 z-50 flex items-center gap-2.5 px-4 py-3 rounded-2xl shadow-xl text-sm font-semibold
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-emerald-600 text-white'}`}>
          <span>{toast.type === 'error' ? '✕' : '✓'}</span>
          {toast.msg}
        </div>
      )}

      {/* ── Header ── */}
      <div className="flex items-end justify-between">
        <div>
          <h1 className="text-2xl font-extrabold text-gray-900">Browse Books</h1>
          <p className="text-sm text-gray-400 mt-0.5">
            {loading ? 'Loading library…' : `${total} book${total !== 1 ? 's' : ''} available`}
          </p>
        </div>
        {(search || category) && (
          <button onClick={clearAll} className="text-xs text-blue-600 hover:underline font-semibold">
            Clear filters ✕
          </button>
        )}
      </div>

      {/* ── Search ── */}
      <form
        onSubmit={e => { e.preventDefault(); setPage(1); fetchBooks(); }}
        className="flex items-center gap-2 bg-white border border-gray-200 rounded-2xl px-4 py-2.5 shadow-sm focus-within:ring-2 focus-within:ring-blue-500 focus-within:border-transparent transition-all"
      >
        <svg className="w-4 h-4 text-gray-400 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
          <circle cx="11" cy="11" r="8"/><path strokeLinecap="round" d="m21 21-4.35-4.35"/>
        </svg>
        <input
          type="text"
          className="flex-1 text-sm text-gray-800 placeholder-gray-400 bg-transparent outline-none min-w-0"
          placeholder="Search by title, author, or ISBN…"
          value={search}
          onChange={e => { setSearch(e.target.value); setPage(1); }}
          autoComplete="off"
        />
        {search && (
          <button type="button" onClick={() => { setSearch(''); setPage(1); }}
            className="text-gray-400 hover:text-gray-600 transition-colors flex-shrink-0 text-lg leading-none">
            ✕
          </button>
        )}
        <button type="submit" className="btn-primary btn-sm flex-shrink-0 rounded-xl">
          Search
        </button>
      </form>

      {/* ── Category strip ── */}
      <div className="flex gap-2 overflow-x-auto pb-1 scrollbar-hide">
        {[{ value: '', label: 'All Books', icon: '📚' }, ...categories.map(c => ({ value: c, label: c, icon: CAT_ICON[c] || '📖' }))].map(c => (
          <button
            key={c.value}
            onClick={() => { setCategory(c.value); setPage(1); }}
            className={`flex items-center gap-1.5 px-4 py-2 rounded-full text-xs font-semibold whitespace-nowrap border transition-all flex-shrink-0
              ${category === c.value
                ? 'bg-blue-600 text-white border-blue-600 shadow-sm'
                : 'bg-white text-gray-500 border-gray-200 hover:border-blue-300 hover:text-blue-600'}`}
          >
            <span>{c.icon}</span>
            {c.label}
          </button>
        ))}
      </div>

      {/* ── Grid ── */}
      {loading ? (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {Array.from({ length: 10 }).map((_, i) => <SkeletonCard key={i} />)}
        </div>
      ) : books.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-24 text-center">
          <div className="w-24 h-24 bg-gray-100 rounded-3xl flex items-center justify-center text-5xl mb-5">📭</div>
          <p className="text-lg font-bold text-gray-700">No books found</p>
          <p className="text-sm text-gray-400 mt-1 mb-5">Try a different search term or category</p>
          <button onClick={clearAll} className="btn-secondary btn-sm">Clear filters</button>
        </div>
      ) : (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {books.map(book => (
            <BookCard
              key={book.id}
              book={book}
              loan={getLoanStatus(book.id)}
              requesting={requesting}
              onRequest={handleRequest}
            />
          ))}
        </div>
      )}

      {/* ── Pagination ── */}
      {pages > 1 && !loading && (
        <div className="flex items-center justify-center gap-2 pt-4">
          <button
            className="btn-secondary btn-sm"
            onClick={() => setPage(p => Math.max(1, p - 1))}
            disabled={page === 1}
          >
            ← Prev
          </button>
          <div className="flex gap-1">
            {Array.from({ length: pages }, (_, i) => i + 1).map(p => (
              <button
                key={p}
                onClick={() => setPage(p)}
                className={`w-9 h-9 rounded-xl text-xs font-bold transition-all
                  ${p === page ? 'bg-blue-600 text-white shadow-sm' : 'text-gray-500 hover:bg-gray-100'}`}
              >
                {p}
              </button>
            ))}
          </div>
          <button
            className="btn-secondary btn-sm"
            onClick={() => setPage(p => Math.min(pages, p + 1))}
            disabled={page === pages}
          >
            Next →
          </button>
        </div>
      )}
    </div>
  );
}
