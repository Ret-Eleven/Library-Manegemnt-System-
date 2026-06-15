# LibraryMS — Library Management System

A full-stack web application for managing a university library. Built for the **Royal University of Phnom Penh (RUPP)** as a Year 2 Semester 2 project.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React 18 + Vite + Tailwind CSS |
| Backend | Express.js (Node.js) |
| Database | Supabase (PostgreSQL) |
| Auth | JWT (JSON Web Tokens) + bcryptjs |
| HTTP Client | Axios |
| Routing | React Router v6 |

---

## Project Structure

```
Lirary_Management_System/
├── backend/                  # Express.js API server
│   ├── config/
│   │   └── database.js       # Supabase client setup
│   ├── middleware/
│   │   ├── auth.js           # JWT authentication middleware
│   │   └── rbac.js           # Role-based access control
│   ├── routes/
│   │   ├── auth.js           # Register, login, profile
│   │   ├── books.js          # Book CRUD
│   │   ├── loans.js          # Loan lifecycle (request → issue → return)
│   │   └── users.js          # User management (superadmin)
│   ├── server.js             # Express entry point
│   └── package.json
│
└── frontend/                 # React + Vite SPA
    └── src/
        ├── components/
        │   ├── AppLayout.jsx      # Shared sidebar + topbar layout
        │   └── ProtectedRoute.jsx # Role-guard route wrapper
        ├── context/
        │   ├── AuthContext.jsx         # Auth state & login/logout
        │   └── NotificationContext.jsx # Real-time notification polling
        ├── pages/
        │   ├── Home.jsx          # Public landing page
        │   ├── Login.jsx         # Split-screen login
        │   ├── Register.jsx      # Multi-step registration (Student / Public)
        │   ├── admin/
        │   │   ├── AdminLayout.jsx
        │   │   ├── AdminDashboard.jsx  # Pending approvals + stats
        │   │   ├── BookManagement.jsx  # Book CRUD with search & filter
        │   │   └── LoanManagement.jsx  # Full loan lifecycle management
        │   ├── user/
        │   │   ├── UserLayout.jsx
        │   │   ├── UserHome.jsx        # User dashboard
        │   │   ├── BookCatalog.jsx     # Browse & request books
        │   │   └── BorrowingHistory.jsx# Loan history + detail modal
        │   ├── superadmin/
        │   │   ├── SuperadminLayout.jsx
        │   │   ├── SuperadminDashboard.jsx # System-wide stats
        │   │   └── UserManagement.jsx      # Manage all accounts
        │   └── shared/
        │       ├── ProfilePage.jsx    # Edit profile & change password
        │       └── SettingsPage.jsx   # Notification & display preferences
        └── services/
            └── api.js           # Axios instance with JWT interceptor
```

---

## Roles & Permissions

| Role | Access |
|---|---|
| **User** | Browse catalog, request books, view borrowing history, manage profile |
| **Admin** | All user access + approve/reject/return loans, manage books |
| **Superadmin** | All admin access + manage user accounts, system-wide stats |

---

## Features

### Public
- Landing page with catalog preview and feature highlights
- Student and Non-Student registration paths
- JWT-based login with role-based redirect

### User Dashboard
- Book catalog with search and category filter
- Borrow request submission
- Borrowing history with status filters (Active / Overdue / Pending / Returned)
- Loan detail modal — timeline, dates, fine summary
- Cancel pending requests
- Profile editing and password change
- Notification bell (overdue alerts, due-soon reminders, pending status)

### Admin Panel
- Dashboard with live stats: Pending, Active, Overdue, Total Books
- One-click approve / reject pending requests
- Book management — add, edit, delete with availability tracking
- Loan management — issue, return, mark fine paid
- Confirm modal before destructive actions

### Superadmin Panel
- System-wide statistics (loans by month, most borrowed books, fine totals)
- User account management — activate, deactivate, change roles

---

## Getting Started

### Prerequisites

- Node.js 18+
- A [Supabase](https://supabase.com) project with the schema below

### 1 — Clone the repo

```bash
git clone <repo-url>
cd Lirary_Management_System
```

### 2 — Backend setup

```bash
cd backend
npm install
```

Create `backend/.env`:

```env
PORT=5000
CLIENT_URL=http://localhost:5173
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-service-role-key
JWT_SECRET=your-jwt-secret
```

Start the server:

```bash
npm run dev      # development (nodemon)
npm start        # production
```

### 3 — Frontend setup

```bash
cd frontend
npm install
```

Create `frontend/.env`:

```env
VITE_API_URL=http://localhost:5000
```

Start the dev server:

```bash
npm run dev
```

Open [http://localhost:5173](http://localhost:5173)

---

## Database Schema

```sql
-- Users
CREATE TABLE users (
  id          SERIAL PRIMARY KEY,
  name        TEXT NOT NULL,
  email       TEXT UNIQUE NOT NULL,
  password    TEXT NOT NULL,
  role        TEXT DEFAULT 'user',   -- 'user' | 'admin' | 'superadmin'
  is_active   INTEGER DEFAULT 1,
  created_at  TIMESTAMP DEFAULT NOW()
);

-- Books
CREATE TABLE books (
  id               SERIAL PRIMARY KEY,
  title            TEXT NOT NULL,
  author           TEXT NOT NULL,
  isbn             TEXT,
  category         TEXT,
  published_year   INTEGER,
  description      TEXT,
  total_copies     INTEGER DEFAULT 1,
  available_copies INTEGER DEFAULT 1,
  created_at       TIMESTAMP DEFAULT NOW()
);

-- Transactions (loans)
CREATE TABLE transactions (
  id           SERIAL PRIMARY KEY,
  user_id      INTEGER REFERENCES users(id),
  book_id      INTEGER REFERENCES books(id),
  issued_by    INTEGER REFERENCES users(id),
  status       TEXT DEFAULT 'pending',  -- 'pending' | 'active' | 'returned' | 'rejected'
  borrow_date  DATE,
  due_date     DATE,
  return_date  DATE,
  fine_amount  NUMERIC DEFAULT 0,
  fine_paid    INTEGER DEFAULT 0,
  created_at   TIMESTAMP DEFAULT NOW()
);
```

---

## API Endpoints

### Auth — `/api/auth`

| Method | Path | Role | Description |
|---|---|---|---|
| POST | `/register` | Public | Create account |
| POST | `/login` | Public | Login, returns JWT |
| GET | `/me` | Any | Get current user |
| PUT | `/profile` | Any | Update name |
| PUT | `/password` | Any | Change password |

### Books — `/api/books`

| Method | Path | Role | Description |
|---|---|---|---|
| GET | `/` | Any | List books (search, category, pagination) |
| GET | `/:id` | Any | Get single book |
| POST | `/` | Admin+ | Add book |
| PUT | `/:id` | Admin+ | Update book |
| DELETE | `/:id` | Admin+ | Delete book |

### Loans — `/api/loans`

| Method | Path | Role | Description |
|---|---|---|---|
| GET | `/my` | User | Own loan history |
| POST | `/request` | User | Request to borrow |
| POST | `/:id/cancel` | User | Cancel own pending request |
| GET | `/` | Admin+ | All loans (filter, paginate) |
| POST | `/:id/issue` | Admin+ | Approve and issue book |
| POST | `/:id/return` | Admin+ | Process return |
| POST | `/:id/reject` | Admin+ | Reject request |
| POST | `/:id/pay-fine` | Admin+ | Mark fine as paid |
| GET | `/stats/overview` | Superadmin | System-wide statistics |

### Users — `/api/users`

| Method | Path | Role | Description |
|---|---|---|---|
| GET | `/` | Superadmin | List all users |
| PUT | `/:id` | Superadmin | Update role / active status |

---

## Demo Accounts

| Role | Email | Password |
|---|---|---|
| Superadmin | superadmin@library.com | admin123 |
| Admin (Librarian) | admin@library.com | admin123 |
| User (Student) | user@library.com | user123 |

---

## Fine Policy

- Loan period: **14 days**
- Fine rate: **$0.50 per day** overdue
- Fines are calculated automatically on the backend
- Payment is processed at the library desk and marked paid by an admin

---

## Authors

Developed by the **RUPP Year 2 — Data Science & Engineering** team  
Royal University of Phnom Penh · 2025
