const Database = require('better-sqlite3');
const path = require('path');
const bcrypt = require('bcrypt');

const DB_PATH = path.join(__dirname, '..', 'library.db');
let db;

function getDb() {
  if (!db) db = new Database(DB_PATH);
  return db;
}

function initDb() {
  const database = getDb();

  database.exec(`
    PRAGMA journal_mode=WAL;
    PRAGMA foreign_keys=ON;

    CREATE TABLE IF NOT EXISTS users (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      name        TEXT    NOT NULL,
      email       TEXT    UNIQUE NOT NULL,
      password_hash TEXT  NOT NULL,
      role        TEXT    NOT NULL DEFAULT 'user',
      is_active   INTEGER DEFAULT 1,
      created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS books (
      id               INTEGER PRIMARY KEY AUTOINCREMENT,
      title            TEXT NOT NULL,
      author           TEXT NOT NULL,
      isbn             TEXT UNIQUE,
      category         TEXT,
      total_copies     INTEGER DEFAULT 1,
      available_copies INTEGER DEFAULT 1,
      published_year   INTEGER,
      description      TEXT,
      created_at       DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS transactions (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id     INTEGER NOT NULL,
      book_id     INTEGER NOT NULL,
      issued_by   INTEGER,
      borrow_date TEXT,
      due_date    TEXT,
      return_date TEXT,
      status      TEXT NOT NULL DEFAULT 'pending',
      fine_amount REAL DEFAULT 0,
      fine_paid   INTEGER DEFAULT 0,
      notes       TEXT,
      FOREIGN KEY (user_id)   REFERENCES users(id),
      FOREIGN KEY (book_id)   REFERENCES books(id),
      FOREIGN KEY (issued_by) REFERENCES users(id)
    );

    CREATE INDEX IF NOT EXISTS idx_transactions_user   ON transactions(user_id);
    CREATE INDEX IF NOT EXISTS idx_transactions_book   ON transactions(book_id);
    CREATE INDEX IF NOT EXISTS idx_transactions_status ON transactions(status);
    CREATE INDEX IF NOT EXISTS idx_books_title         ON books(title);
    CREATE INDEX IF NOT EXISTS idx_books_author        ON books(author);
    CREATE INDEX IF NOT EXISTS idx_books_isbn          ON books(isbn);
  `);

  // Seed demo accounts for all 3 roles
  const demoAccounts = [
    { name: 'Super Admin', email: 'superadmin@library.com', password: 'admin123', role: 'superadmin' },
    { name: 'Admin User',  email: 'admin@library.com',      password: 'admin123', role: 'admin'      },
    { name: 'John Doe',    email: 'user@library.com',       password: 'user123',  role: 'user'       },
  ];
  for (const acc of demoAccounts) {
    const exists = database.prepare('SELECT id FROM users WHERE email = ?').get(acc.email);
    if (!exists) {
      const hash = bcrypt.hashSync(acc.password, 10);
      database.prepare('INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)').run(
        acc.name, acc.email, hash, acc.role
      );
      console.log(`Demo ${acc.role} created: ${acc.email} / ${acc.password}`);
    }
  }

  // Seed sample books if empty
  const bookCount = database.prepare('SELECT COUNT(*) as count FROM books').get().count;
  if (bookCount === 0) {
    const insertBook = database.prepare(
      'INSERT INTO books (title, author, isbn, category, total_copies, available_copies, published_year) VALUES (?, ?, ?, ?, ?, ?, ?)'
    );
    const books = [
      ['The Great Gatsby',          'F. Scott Fitzgerald', '9780743273565', 'Fiction',       3, 3, 1925],
      ['To Kill a Mockingbird',     'Harper Lee',          '9780061935466', 'Fiction',       2, 2, 1960],
      ['1984',                      'George Orwell',       '9780451524935', 'Fiction',       4, 4, 1949],
      ['Introduction to Algorithms','Thomas H. Cormen',    '9780262033848', 'Computer Science', 2, 2, 2009],
      ['Clean Code',                'Robert C. Martin',    '9780132350884', 'Computer Science', 3, 3, 2008],
      ['Sapiens',                   'Yuval Noah Harari',   '9780062316097', 'History',       2, 2, 2011],
      ['The Art of War',            'Sun Tzu',             '9781599869773', 'Philosophy',    5, 5, 2006],
      ['Dune',                      'Frank Herbert',       '9780441013593', 'Science Fiction',2, 2, 1965],
      ['Atomic Habits',             'James Clear',         '9780735211292', 'Self-Help',     3, 3, 2018],
      ['The Pragmatic Programmer',  'David Thomas',        '9780135957059', 'Computer Science', 2, 2, 2019],
    ];
    books.forEach(b => insertBook.run(...b));
    console.log('Sample books seeded');
  }

  console.log('Database initialized');
}

module.exports = { getDb, initDb };
