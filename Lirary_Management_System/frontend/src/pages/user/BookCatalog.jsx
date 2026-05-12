import { useState, useEffect, useCallback } from 'react';
import api from '../../services/api';

const STATUS_BADGE = {
  pending:  'bg-yellow-100 text-yellow-800',
  active:   'bg-green-100 text-green-800',
  returned: 'bg-gray-100 text-gray-700',
  rejected: 'bg-red-100 text-red-700',
};

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
      showToast('Borrow request submitted! An admin will approve it soon.');
      const { data } = await api.get('/api/loans/my');
      setMyLoans(data);
      fetchBooks();
    } catch (err) {
      showToast(err.response?.data?.message || 'Request failed', 'error');
    } finally {
      setRequesting(null);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    setPage(1);
    fetchBooks();
  };

  return (
    <div>
      {/* Toast */}
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-xl shadow-lg text-sm font-medium transition-all
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-green-600 text-white'}`}>
          {toast.msg}
        </div>
      )}

      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Browse Books</h1>
        <p className="text-gray-500 mt-1 text-sm">{total} books in the library</p>
      </div>

      {/* Search & filter */}
      <form onSubmit={handleSearch} className="flex flex-col sm:flex-row gap-3 mb-6">
        <input
          type="text"
          className="input flex-1"
          placeholder="Search by title, author or ISBN…"
          value={search}
          onChange={e => { setSearch(e.target.value); setPage(1); }}
        />
        <select
          className="input sm:w-48"
          value={category}
          onChange={e => { setCategory(e.target.value); setPage(1); }}
        >
          <option value="">All categories</option>
          {categories.map(c => <option key={c} value={c}>{c}</option>)}
        </select>
        <button type="submit" className="btn-primary">Search</button>
      </form>

      {/* Books grid */}
      {loading ? (
        <div className="flex justify-center py-16">
          <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-700" />
        </div>
      ) : books.length === 0 ? (
        <div className="text-center py-16 text-gray-400">
          <div className="text-5xl mb-3">📭</div>
          <p className="font-medium">No books found</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {books.map(book => {
            const loan = getLoanStatus(book.id);
            const unavailable = book.available_copies === 0;
            return (
              <div key={book.id} className="card flex flex-col gap-3 hover:shadow-md transition-shadow">
                <div className="flex items-start justify-between gap-2">
                  <div className="text-3xl">📖</div>
                  {book.available_copies > 0 ? (
                    <span className="badge bg-green-100 text-green-700">
                      {book.available_copies} available
                    </span>
                  ) : (
                    <span className="badge bg-red-100 text-red-700">Unavailable</span>
                  )}
                </div>

                <div className="flex-1">
                  <h3 className="font-semibold text-gray-900 leading-tight line-clamp-2">{book.title}</h3>
                  <p className="text-sm text-gray-500 mt-0.5">{book.author}</p>
                  {book.category && (
                    <span className="badge bg-blue-50 text-blue-700 mt-2">{book.category}</span>
                  )}
                  {book.published_year && (
                    <p className="text-xs text-gray-400 mt-1">{book.published_year}</p>
                  )}
                </div>

                {loan ? (
                  <div className={`badge w-full justify-center py-1.5 ${STATUS_BADGE[loan.status]}`}>
                    {loan.status === 'pending' ? '⏳ Request pending' : '✅ Currently borrowed'}
                  </div>
                ) : (
                  <button
                    onClick={() => handleRequest(book.id)}
                    disabled={unavailable || requesting === book.id}
                    className={`btn w-full ${unavailable ? 'btn-secondary opacity-50 cursor-not-allowed' : 'btn-primary'}`}
                  >
                    {requesting === book.id ? 'Requesting…' : unavailable ? 'Not available' : 'Borrow'}
                  </button>
                )}
              </div>
            );
          })}
        </div>
      )}

      {/* Pagination */}
      {pages > 1 && (
        <div className="flex items-center justify-center gap-2 mt-8">
          <button
            className="btn-secondary btn-sm"
            onClick={() => setPage(p => Math.max(1, p - 1))}
            disabled={page === 1}
          >
            ← Prev
          </button>
          <span className="text-sm text-gray-600">Page {page} of {pages}</span>
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
