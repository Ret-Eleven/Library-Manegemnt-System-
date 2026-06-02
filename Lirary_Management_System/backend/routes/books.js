const express = require('express');
const { supabase } = require('../config/database');
const { authenticate } = require('../middleware/auth');
const { requireMinRole } = require('../middleware/rbac');

const router = express.Router();

router.get('/', authenticate, async (req, res) => {
  try {
    const { search, category, page = 1, limit = 20 } = req.query;
    const offset = (Number(page) - 1) * Number(limit);

    let query = supabase.from('books').select('*', { count: 'exact' });

    if (search) {
      query = query.or(`title.ilike.%${search}%,author.ilike.%${search}%,isbn.ilike.%${search}%`);
    }
    if (category) {
      query = query.eq('category', category);
    }

    const { data: books, count: total, error } = await query
      .order('title', { ascending: true })
      .range(offset, offset + Number(limit) - 1);

    if (error) return res.status(500).json({ message: error.message });
    res.json({ books, total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

router.get('/categories', authenticate, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('books')
      .select('category')
      .not('category', 'is', null)
      .order('category', { ascending: true });

    if (error) return res.status(500).json({ message: error.message });
    const categories = [...new Set(data.map(r => r.category))];
    res.json(categories);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const { data: book, error } = await supabase
      .from('books')
      .select('*')
      .eq('id', req.params.id)
      .single();

    if (!book) return res.status(404).json({ message: 'Book not found' });
    res.json(book);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

router.post('/', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { title, author, isbn, category, total_copies = 1, published_year, description } = req.body;
    if (!title || !author) return res.status(400).json({ message: 'Title and author required' });

    const copies = Number(total_copies);
    const { data, error } = await supabase
      .from('books')
      .insert({
        title, author,
        isbn: isbn || null,
        category: category || null,
        total_copies: copies,
        available_copies: copies,
        published_year: published_year || null,
        description: description || null,
      })
      .select('id')
      .single();

    if (error) return res.status(500).json({ message: error.message });
    res.status(201).json({ message: 'Book added', id: data.id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

router.put('/:id', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: book } = await supabase.from('books').select('*').eq('id', req.params.id).single();
    if (!book) return res.status(404).json({ message: 'Book not found' });

    const { title, author, isbn, category, total_copies, published_year, description } = req.body;
    const newTotal = total_copies != null ? Number(total_copies) : book.total_copies;
    const diff = newTotal - book.total_copies;
    const newAvailable = Math.max(0, book.available_copies + diff);

    const { error } = await supabase
      .from('books')
      .update({
        title: title ?? book.title,
        author: author ?? book.author,
        isbn: isbn !== undefined ? isbn : book.isbn,
        category: category !== undefined ? category : book.category,
        total_copies: newTotal,
        available_copies: newAvailable,
        published_year: published_year !== undefined ? published_year : book.published_year,
        description: description !== undefined ? description : book.description,
      })
      .eq('id', req.params.id);

    if (error) return res.status(500).json({ message: error.message });
    res.json({ message: 'Book updated' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

router.delete('/:id', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { count } = await supabase
      .from('transactions')
      .select('*', { count: 'exact', head: true })
      .eq('book_id', req.params.id)
      .in('status', ['active', 'pending']);

    if (count > 0) return res.status(400).json({ message: 'Cannot delete a book with active or pending loans' });

    await supabase.from('books').delete().eq('id', req.params.id);
    res.json({ message: 'Book deleted' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
