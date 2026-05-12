# Library Management System

A full-stack Library Management System built with React (frontend) and Node.js/Express (backend), using SQLite for data storage.

> School project — RUPP Year 2, Semester 2

---

## Features

### Roles & Permissions

| Feature | User | Admin | Superadmin |
|---|:---:|:---:|:---:|
| Browse & search books | ✓ | ✓ | ✓ |
| Request to borrow a book | ✓ | ✓ | ✓ |
| View personal borrowing history | ✓ | ✓ | ✓ |
| Manage books (CRUD) | | ✓ | ✓ |
| Approve / reject borrow requests | | ✓ | ✓ |
| Issue & return books | | ✓ | ✓ |
| Mark fines as paid | | ✓ | ✓ |
| Manage users | | | ✓ |
| View statistics dashboard | | | ✓ |

### Core Functionality

- **Book catalog** — search by title, author, or ISBN; filter by category; paginated results
- **Loan workflow** — `pending` → `active` (issued) → `returned`; loans can also be `rejected`
- **Automatic fines** — $0.50 per day after a 14-day loan period, calculated live
- **JWT authentication** — 24-hour tokens stored in localStorage
- **Role-based access control (RBAC)** — enforced on every API route and frontend page

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React 18, Vite, Tailwind CSS, React Router v6, Axios |
| Backend | Node.js, Express |
| Database | SQLite (via better-sqlite3) |
| Auth | JWT (jsonwebtoken), bcrypt |

---

## Project Structure

```
Lirary_Management_System/
├── backend/
│   ├── config/
│   │   └── database.js      # SQLite init, schema, seed data
│   ├── middleware/
│   │   ├── auth.js          # JWT verification
│   │   └── rbac.js          # Role-based access control
│   ├── routes/
│   │   ├── auth.js          # POST /login, POST /register, GET /me
│   │   ├── books.js         # Book CRUD + search/pagination
│   │   ├── loans.js         # Loan workflow + fine calculation
│   │   └── users.js         # User management (superadmin)
│   └── server.js            # Express entry point (port 5000)
│
└── frontend/
    └── src/
        ├── components/
        │   ├── AppLayout.jsx        # Shared sidebar layout
        │   └── ProtectedRoute.jsx   # Auth + role guard
        ├── context/
        │   └── AuthContext.jsx      # Global auth state
        ├── pages/
        │   ├── Login.jsx
        │   ├── Register.jsx
        │   ├── user/
        │   │   ├── BookCatalog.jsx
        │   │   └── BorrowingHistory.jsx
        │   ├── admin/
        │   │   ├── AdminDashboard.jsx
        │   │   ├── BookManagement.jsx
        │   │   └── LoanManagement.jsx
        │   └── superadmin/
        │       ├── SuperadminDashboard.jsx
        │       └── UserManagement.jsx
        └── services/
            └── api.js               # Axios instance with 401 interceptor
```

---

## Getting Started

### Prerequisites

- Node.js 18+
- npm

### 1. Start the Backend

```bash
cd Lirary_Management_System/backend
npm install
npm run dev
```

The API server starts at **http://localhost:5000**

### 2. Start the Frontend

Open a second terminal:

```bash
cd Lirary_Management_System/frontend
npm install
npm run dev
```

The app opens at **http://localhost:5173**

> Both servers must be running at the same time. The frontend proxies all `/api/*` requests to the backend on port 5000.

---

## Demo Accounts

| Role | Email | Password |
|---|---|---|
| Superadmin | superadmin@library.com | admin123 |
| Admin | admin@library.com | admin123 |
| User | user@library.com | user123 |

These accounts are auto-created the first time the backend starts. You can also click any row in the **Demo accounts** panel on the login page to auto-fill the credentials.

---

## API Endpoints

### Auth — `/api/auth`

| Method | Path | Description |
|---|---|---|
| POST | `/login` | Login and receive a JWT |
| POST | `/register` | Register a new user account |
| GET | `/me` | Get the current logged-in user |

### Books — `/api/books`

| Method | Path | Access | Description |
|---|---|---|---|
| GET | `/` | All | List books (supports `?search=`, `?category=`, `?page=`, `?limit=`) |
| GET | `/:id` | All | Get a single book |
| POST | `/` | Admin+ | Create a book |
| PUT | `/:id` | Admin+ | Update a book |
| DELETE | `/:id` | Admin+ | Delete a book (blocked if active loans exist) |

### Loans — `/api/loans`

| Method | Path | Access | Description |
|---|---|---|---|
| GET | `/my` | User | Current user's loan history |
| POST | `/request` | User | Request to borrow a book |
| GET | `/` | Admin+ | All loans (supports `?status=` filter) |
| PUT | `/:id/issue` | Admin+ | Approve and issue a loan |
| PUT | `/:id/return` | Admin+ | Mark a loan as returned |
| PUT | `/:id/reject` | Admin+ | Reject a loan request |
| PUT | `/:id/pay-fine` | Admin+ | Mark overdue fine as paid |
| GET | `/stats/overview` | Superadmin | Dashboard statistics |

### Users — `/api/users`

| Method | Path | Access | Description |
|---|---|---|---|
| GET | `/` | Superadmin | List all users |
| POST | `/` | Superadmin | Create a user |
| PUT | `/:id` | Superadmin | Update a user |
| DELETE | `/:id` | Superadmin | Deactivate a user (soft delete) |

---

## Database Schema

```sql
users (id, name, email, password_hash, role, is_active, created_at)
books (id, title, author, isbn, category, total_copies, available_copies, published_year, description, created_at)
transactions (id, user_id, book_id, issued_by, borrow_date, due_date, return_date, status, fine_amount, fine_paid, notes)
```

---

## Fine Policy

- Loan period: **14 days**
- Overdue rate: **$0.50 per day**
- Fines are calculated live using SQLite's `julianday()` function and stored on return
