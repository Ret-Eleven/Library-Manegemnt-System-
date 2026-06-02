-- ============================================================
--  Library Management System — Supabase / PostgreSQL Schema
--  Paste this entire file into the Supabase SQL Editor and Run.
-- ============================================================

-- Needed for bcrypt-compatible password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ─────────────────────────────────────────
--  Tables
-- ─────────────────────────────────────────

CREATE TABLE IF NOT EXISTS users (
  id            SERIAL PRIMARY KEY,
  name          TEXT    NOT NULL,
  email         TEXT    UNIQUE NOT NULL,
  password_hash TEXT    NOT NULL,
  role          TEXT    NOT NULL DEFAULT 'user',
  is_active     INTEGER DEFAULT 1,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS books (
  id               SERIAL PRIMARY KEY,
  title            TEXT    NOT NULL,
  author           TEXT    NOT NULL,
  isbn             TEXT    UNIQUE,
  category         TEXT,
  total_copies     INTEGER DEFAULT 1,
  available_copies INTEGER DEFAULT 1,
  published_year   INTEGER,
  description      TEXT,
  cover_url        TEXT,
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS transactions (
  id          SERIAL PRIMARY KEY,
  user_id     INTEGER NOT NULL REFERENCES users(id),
  book_id     INTEGER NOT NULL REFERENCES books(id),
  issued_by   INTEGER REFERENCES users(id),
  borrow_date TEXT,
  due_date    TEXT,
  return_date TEXT,
  status      TEXT    NOT NULL DEFAULT 'pending',
  fine_amount REAL    DEFAULT 0,
  fine_paid   INTEGER DEFAULT 0,
  notes       TEXT
);

-- ─────────────────────────────────────────
--  Indexes
-- ─────────────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_transactions_user   ON transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_transactions_book   ON transactions(book_id);
CREATE INDEX IF NOT EXISTS idx_transactions_status ON transactions(status);
CREATE INDEX IF NOT EXISTS idx_books_title         ON books(title);
CREATE INDEX IF NOT EXISTS idx_books_author        ON books(author);
CREATE INDEX IF NOT EXISTS idx_books_isbn          ON books(isbn);

-- ─────────────────────────────────────────
--  Demo Accounts
--  Passwords hashed with blowfish (bcrypt-compatible, $2a$ prefix).
--  Node.js `bcrypt.compare()` accepts $2a$ hashes.
-- ─────────────────────────────────────────

INSERT INTO users (name, email, password_hash, role)
VALUES
  ('Super Admin', 'superadmin@library.com', crypt('admin123', gen_salt('bf', 10)), 'superadmin'),
  ('Admin User',  'admin@library.com',      crypt('admin123', gen_salt('bf', 10)), 'admin'),
  ('John Doe',    'user@library.com',        crypt('user123',  gen_salt('bf', 10)), 'user')
ON CONFLICT (email) DO NOTHING;

-- ─────────────────────────────────────────
--  Sample Books
-- ─────────────────────────────────────────

INSERT INTO books (title, author, isbn, category, total_copies, available_copies, published_year, cover_url)
VALUES
  ('The Great Gatsby',           'F. Scott Fitzgerald', '9780743273565', 'Fiction',           3, 3, 1925, 'https://covers.openlibrary.org/b/isbn/9780743273565-M.jpg'),
  ('To Kill a Mockingbird',      'Harper Lee',           '9780061935466', 'Fiction',           2, 2, 1960, 'https://covers.openlibrary.org/b/isbn/9780061935466-M.jpg'),
  ('1984',                       'George Orwell',        '9780451524935', 'Fiction',           4, 4, 1949, 'https://covers.openlibrary.org/b/isbn/9780451524935-M.jpg'),
  ('Introduction to Algorithms', 'Thomas H. Cormen',    '9780262033848', 'Computer Science',  2, 2, 2009, 'https://covers.openlibrary.org/b/isbn/9780262033848-M.jpg'),
  ('Clean Code',                 'Robert C. Martin',    '9780132350884', 'Computer Science',  3, 3, 2008, 'https://covers.openlibrary.org/b/isbn/9780132350884-M.jpg'),
  ('Sapiens',                    'Yuval Noah Harari',   '9780062316097', 'History',           2, 2, 2011, 'https://covers.openlibrary.org/b/isbn/9780062316097-M.jpg'),
  ('The Art of War',             'Sun Tzu',              '9781599869773', 'Philosophy',        5, 5, 2006, 'https://covers.openlibrary.org/b/isbn/9781599869773-M.jpg'),
  ('Dune',                       'Frank Herbert',        '9780441013593', 'Science Fiction',   2, 2, 1965, 'https://covers.openlibrary.org/b/isbn/9780441013593-M.jpg'),
  ('Atomic Habits',              'James Clear',          '9780735211292', 'Self-Help',         3, 3, 2018, 'https://covers.openlibrary.org/b/isbn/9780735211292-M.jpg'),
  ('The Pragmatic Programmer',   'David Thomas',         '9780135957059', 'Computer Science',  2, 2, 2019, 'https://covers.openlibrary.org/b/isbn/9780135957059-M.jpg')
ON CONFLICT (isbn) DO NOTHING;
