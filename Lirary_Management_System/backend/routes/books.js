const express = require('express');
const { supabase }        = require('../config/database');
const { authenticate }    = require('../middleware/auth');
const { requireMinRole }  = require('../middleware/rbac');
const { findOrCreateAuthor, findOrCreateCategory } = require('../config/lookups');

const router = express.Router();

const BOOK_SELECT = `
  book_id, book_title, isbn_code, copies_total, copies_available, published_year, description, cover_url, created_at,
  category:category_id(category_name),
  book_author(author:author_id(first_name,last_name))
`;

const flatten = (b) => ({
  id: b.book_id,
  title: b.book_title,
  author: (b.book_author || []).map(ba => `${ba.author?.first_name || ''} ${ba.author?.last_name || ''}`.trim()).filter(Boolean).join(', '),
  isbn: b.isbn_code,
  category: b.category?.category_name || null,
  total_copies: b.copies_total,
  available_copies: b.copies_available,
  published_year: b.published_year,
  description: b.description,
  cover_url: b.cover_url,
  created_at: b.created_at,
});

router.get('/', authenticate, async (req, res) => {
  try {
    const { search, category, page = 1, limit = 20 } = req.query;
    const offset = (Number(page) - 1) * Number(limit);

    let q = supabase.from('book').select(BOOK_SELECT, { count: 'exact' });

    if (search) {
      const { data: authorMatches } = await supabase.from('book_author')
        .select('book_id, author:author_id!inner(first_name,last_name)')
        .or(`first_name.ilike.%${search}%,last_name.ilike.%${search}%`, { foreignTable: 'author' });
      const bookIds = [...new Set((authorMatches || []).map(a => a.book_id))];

      let orExpr = `book_title.ilike.%${search}%,isbn_code.ilike.%${search}%`;
      if (bookIds.length) orExpr += `,book_id.in.(${bookIds.join(',')})`;
      q = q.or(orExpr);
    }
    if (category) {
      const { data: cat } = await supabase.from('category').select('category_id').eq('category_name', category).maybeSingle();
      q = q.eq('category_id', cat ? cat.category_id : -1);
    }

    const { data: books, count: total, error } = await q
      .order('book_title', { ascending: true })
      .range(offset, offset + Number(limit) - 1);

    if (error) return res.status(500).json({ message: error.message });
    res.json({ books: books.map(flatten), total, page: Number(page), pages: Math.ceil(total / Number(limit)) });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.get('/categories', authenticate, async (req, res) => {
  try {
    const { data, error } = await supabase.from('category').select('category_name').order('category_name');
    if (error) return res.status(500).json({ message: error.message });
    res.json(data.map(r => r.category_name));
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.get('/:id', authenticate, async (req, res) => {
  try {
    const { data: book } = await supabase.from('book').select(BOOK_SELECT).eq('book_id', req.params.id).single();
    if (!book) return res.status(404).json({ message: 'Book not found' });
    res.json(flatten(book));
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.post('/', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { title, author, isbn, category, total_copies = 1, published_year, description, cover_url } = req.body;
    if (!title || !author) return res.status(400).json({ message: 'Title and author required' });
    const copies = Number(total_copies);

    const category_id = await findOrCreateCategory(category);
    const { data, error } = await supabase.from('book')
      .insert({ book_title: title, isbn_code: isbn||null, category_id,
                copies_total: copies, copies_available: copies,
                published_year: published_year||null, description: description||null,
                cover_url: cover_url||null })
      .select('book_id').single();
    if (error) return res.status(500).json({ message: error.message });

    const author_id = await findOrCreateAuthor(author);
    const { error: linkError } = await supabase.from('book_author').insert({ book_id: data.book_id, author_id });
    if (linkError) return res.status(500).json({ message: linkError.message });

    res.status(201).json({ message: 'Book added', id: data.book_id });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.put('/:id', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { data: book } = await supabase.from('book').select('*').eq('book_id', req.params.id).single();
    if (!book) return res.status(404).json({ message: 'Book not found' });

    const { title, author, isbn, category, total_copies, published_year, description, cover_url } = req.body;
    const newTotal      = total_copies != null ? Number(total_copies) : book.copies_total;
    const newAvailable  = Math.max(0, book.copies_available + (newTotal - book.copies_total));

    const category_id = category !== undefined ? await findOrCreateCategory(category) : book.category_id;

    const { error } = await supabase.from('book').update({
      book_title:     title          ?? book.book_title,
      isbn_code:      isbn           !== undefined ? isbn           : book.isbn_code,
      category_id,
      copies_total:   newTotal,
      copies_available: newAvailable,
      published_year: published_year !== undefined ? published_year : book.published_year,
      description:    description    !== undefined ? description    : book.description,
      cover_url:      cover_url      !== undefined ? (cover_url||null) : book.cover_url,
    }).eq('book_id', req.params.id);

    if (error) return res.status(500).json({ message: error.message });

    if (author !== undefined) {
      await supabase.from('book_author').delete().eq('book_id', req.params.id);
      const author_id = await findOrCreateAuthor(author);
      const { error: linkError } = await supabase.from('book_author').insert({ book_id: req.params.id, author_id });
      if (linkError) return res.status(500).json({ message: linkError.message });
    }

    res.json({ message: 'Book updated' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

router.delete('/:id', authenticate, requireMinRole('admin'), async (req, res) => {
  try {
    const { count: activeCount } = await supabase.from('book_issue')
      .select('*', { count: 'exact', head: true }).eq('book_id', req.params.id).eq('status', 'active');
    const { count: pendingCount } = await supabase.from('book_request')
      .select('*', { count: 'exact', head: true }).eq('book_id', req.params.id).eq('status', 'pending');
    if ((activeCount||0) > 0 || (pendingCount||0) > 0)
      return res.status(400).json({ message: 'Cannot delete a book with active or pending loans' });

    await supabase.from('book_author').delete().eq('book_id', req.params.id);
    const { error } = await supabase.from('book').delete().eq('book_id', req.params.id);
    if (error) {
      if (error.code === '23503') return res.status(400).json({ message: 'Cannot delete a book with existing loan history' });
      return res.status(500).json({ message: error.message });
    }
    res.json({ message: 'Book deleted' });
  } catch (err) { console.error(err); res.status(500).json({ message: 'Server error' }); }
});

module.exports = router;
