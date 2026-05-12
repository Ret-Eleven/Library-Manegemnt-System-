import { useState, useEffect, useCallback } from 'react';
import api from '../../services/api';

const EMPTY_FORM = { title: '', author: '', isbn: '', category: '', total_copies: 1, published_year: '', description: '' };

export default function BookManagement() {
  const [books, setBooks]       = useState([]);
  const [total, setTotal]       = useState(0);
  const [pages, setPages]       = useState(1);
  const [page, setPage]         = useState(1);
  const [search, setSearch]     = useState('');
  const [loading, setLoading]   = useState(true);
  const [modal, setModal]       = useState(null); // null | 'add' | 'edit' | 'delete'
  const [selected, setSelected] = useState(null);
  const [form, setForm]         = useState(EMPTY_FORM);
  const [saving, setSaving]     = useState(false);
  const [toast, setToast]       = useState(null);

  const LIMIT = 15;

  const showToast = (msg, type = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 3500);
  };

  const fetchBooks = useCallback(async () => {
    setLoading(true);
    try {
      const params = { page, limit: LIMIT };
      if (search) params.search = search;
      const { data } = await api.get('/api/books', { params });
      setBooks(data.books);
      setTotal(data.total);
      setPages(data.pages);
    } finally {
      setLoading(false);
    }
  }, [page, search]);

  useEffect(() => { fetchBooks(); }, [fetchBooks]);

  const openAdd = () => {
    setForm(EMPTY_FORM);
    setSelected(null);
    setModal('add');
  };

  const openEdit = (book) => {
    setForm({
      title: book.title,
      author: book.author,
      isbn: book.isbn || '',
      category: book.category || '',
      total_copies: book.total_copies,
      published_year: book.published_year || '',
      description: book.description || '',
    });
    setSelected(book);
    setModal('edit');
  };

  const openDelete = (book) => {
    setSelected(book);
    setModal('delete');
  };

  const closeModal = () => { setModal(null); setSelected(null); };

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

  const f = (k) => (e) => setForm({ ...form, [k]: e.target.value });

  return (
    <div>
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-xl shadow-lg text-sm font-medium
          ${toast.type === 'error' ? 'bg-red-600 text-white' : 'bg-green-600 text-white'}`}>
          {toast.msg}
        </div>
      )}

      <div className="mb-6 flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Book Management</h1>
          <p className="text-gray-500 text-sm mt-1">{total} books total</p>
        </div>
        <button onClick={openAdd} className="btn-primary">+ Add Book</button>
      </div>

      {/* Search */}
      <div className="mb-4">
        <input
          type="text"
          className="input max-w-sm"
          placeholder="Search books…"
          value={search}
          onChange={e => { setSearch(e.target.value); setPage(1); }}
        />
      </div>

      {/* Table */}
      {loading ? (
        <div className="flex justify-center py-16">
          <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-blue-700" />
        </div>
      ) : (
        <>
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>Title / Author</th>
                  <th>ISBN</th>
                  <th>Category</th>
                  <th>Copies</th>
                  <th>Available</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {books.length === 0 ? (
                  <tr><td colSpan={6} className="text-center py-8 text-gray-400">No books found</td></tr>
                ) : books.map(book => (
                  <tr key={book.id}>
                    <td>
                      <p className="font-medium text-gray-900">{book.title}</p>
                      <p className="text-xs text-gray-400">{book.author}</p>
                    </td>
                    <td className="text-gray-500 text-xs">{book.isbn || '—'}</td>
                    <td>
                      {book.category && <span className="badge bg-blue-50 text-blue-700">{book.category}</span>}
                    </td>
                    <td className="text-center">{book.total_copies}</td>
                    <td className="text-center">
                      <span className={`badge ${book.available_copies > 0 ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                        {book.available_copies}
                      </span>
                    </td>
                    <td>
                      <div className="flex gap-2">
                        <button onClick={() => openEdit(book)} className="btn-secondary btn-sm">Edit</button>
                        <button onClick={() => openDelete(book)} className="btn-danger btn-sm">Delete</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {pages > 1 && (
            <div className="flex items-center justify-center gap-2 mt-6">
              <button className="btn-secondary btn-sm" onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1}>← Prev</button>
              <span className="text-sm text-gray-600">Page {page} of {pages}</span>
              <button className="btn-secondary btn-sm" onClick={() => setPage(p => Math.min(pages, p + 1))} disabled={page === pages}>Next →</button>
            </div>
          )}
        </>
      )}

      {/* Add / Edit Modal */}
      {(modal === 'add' || modal === 'edit') && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto p-6">
            <h2 className="text-xl font-bold mb-5">{modal === 'add' ? 'Add New Book' : 'Edit Book'}</h2>
            <form onSubmit={handleSave} className="space-y-4">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div className="sm:col-span-2">
                  <label className="label">Title *</label>
                  <input className="input" value={form.title} onChange={f('title')} required />
                </div>
                <div className="sm:col-span-2">
                  <label className="label">Author *</label>
                  <input className="input" value={form.author} onChange={f('author')} required />
                </div>
                <div>
                  <label className="label">ISBN</label>
                  <input className="input" value={form.isbn} onChange={f('isbn')} />
                </div>
                <div>
                  <label className="label">Category</label>
                  <input className="input" value={form.category} onChange={f('category')} placeholder="e.g. Fiction" />
                </div>
                <div>
                  <label className="label">Total Copies</label>
                  <input type="number" min={1} className="input" value={form.total_copies} onChange={f('total_copies')} />
                </div>
                <div>
                  <label className="label">Published Year</label>
                  <input type="number" min={1000} max={2099} className="input" value={form.published_year} onChange={f('published_year')} />
                </div>
                <div className="sm:col-span-2">
                  <label className="label">Description</label>
                  <textarea rows={3} className="input resize-none" value={form.description} onChange={f('description')} />
                </div>
              </div>
              <div className="flex justify-end gap-3 pt-2">
                <button type="button" onClick={closeModal} className="btn-secondary">Cancel</button>
                <button type="submit" className="btn-primary" disabled={saving}>
                  {saving ? 'Saving…' : modal === 'add' ? 'Add Book' : 'Save Changes'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Delete Modal */}
      {modal === 'delete' && selected && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-sm p-6">
            <h2 className="text-xl font-bold mb-2">Delete Book</h2>
            <p className="text-gray-600 mb-6">
              Are you sure you want to delete <strong>"{selected.title}"</strong>?
              This cannot be undone. Books with active loans cannot be deleted.
            </p>
            <div className="flex justify-end gap-3">
              <button onClick={closeModal} className="btn-secondary">Cancel</button>
              <button onClick={handleDelete} className="btn-danger" disabled={saving}>
                {saving ? 'Deleting…' : 'Delete'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
