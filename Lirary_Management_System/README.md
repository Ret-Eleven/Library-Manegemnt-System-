# LibraryOS — Library Management System

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
| Book Covers | Open Library Covers API |

---

## Project Structure

```
Lirary_Management_System/
├── backend/                  # Express.js API server
│   ├── config/
│   │   ├── database.js       # Supabase client setup
│   │   ├── identity.js       # Opaque id prefixing (mem_/staff_/req_/iss_) across split tables
│   │   ├── lookups.js        # findOrCreateAuthor / findOrCreateCategory / splitName
│   │   └── loanFormat.js     # Shared loan enrichment (book_request + book_issue → flat loan shape)
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
        │   ├── Register.jsx      # Multi-step registration (Student / Public+Staff)
        │   ├── admin/
        │   │   ├── AdminLayout.jsx
        │   │   ├── AdminDashboard.jsx  # Pending approvals + stats
        │   │   ├── BookManagement.jsx  # Book CRUD with search & filter
        │   │   └── LoanManagement.jsx  # Full loan lifecycle management
        │   ├── user/
        │   │   ├── UserLayout.jsx
        │   │   ├── UserHome.jsx        # User dashboard with recent loans
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
- **Student registration** — instant verification via institutional email
- **Public / Staff registration** — manual ID verification path with National ID / Passport number and expiry date
- JWT-based login with role-based redirect

### User Dashboard
- Book catalog with search and category filter
- Book cover images loaded from the [Open Library Covers API](https://openlibrary.org/dev/docs/api#anchor-covers) by ISBN; falls back to a colored gradient with title initials when no cover is available
- Borrow request submission
- User home page with recent loans list (including book cover images)
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
SUPABASE_KEY=your-publishable-key   # RLS is disabled on all tables; the Express backend enforces auth itself
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

The backend runs on a normalized Postgres schema (Supabase). Core tables:

| Table | Purpose | Key columns |
|---|---|---|
| `member` | Patrons — role is implicitly `user` | `member_id`, `first_name`, `last_name`, `email_id`, `password_hash`, `is_active` |
| `library_staff` | Admins & superadmins | `issued_by_id`, `staff_name`, `email`, `password_hash`, `staff_designation` (`admin`\|`superadmin`), `is_active` |
| `book` | Book catalog | `book_id`, `book_title`, `isbn_code`, `category_id`, `copies_total`, `copies_available`, `published_year`, `description`, `cover_url` |
| `author` | Authors | `author_id`, `first_name`, `last_name` |
| `book_author` | Book ↔ author (many-to-many) | `book_id`, `author_id` |
| `category` | Book categories | `category_id`, `category_name` |
| `book_request` | Pending / rejected borrow requests | `request_id`, `book_id`, `member_id`, `request_date`, `status` (`pending`\|`approved`\|`rejected`) |
| `book_issue` | Active / returned loans | `issue_id`, `book_id`, `member_id`, `issued_by_id`, `issue_date`, `due_date`, `return_date`, `status` (`active`\|`returned`), `pickup_code` |
| `fine_due` | Overdue fines | `fine_id`, `member_id`, `issue_id`, `fine_date`, `fine_total`, `paid` |

Notes:
- **User and loan identities are split across two tables each** (`member`/`library_staff`, `book_request`/`book_issue`). To keep a single stable id per record, the API exposes opaque prefixed ids — `mem_<id>` / `staff_<id>` for users, `req_<id>` / `iss_<id>` for loans — which the backend parses to know which table to query. The frontend treats these as opaque strings and never needs to know the split exists.
- Role changes are only allowed *within* an account type (e.g. `admin` ↔ `superadmin`). Promoting a `member` to staff (or vice versa) isn't supported, since it would require moving the row to a different table with a new id.
- Deleting a book is blocked once it has **any** loan history (not just active/pending), because `book_issue`/`book_request` hold real foreign keys to `book`.
- Row Level Security is disabled on all tables — the Express backend is the only client and already enforces auth/roles itself.

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
| GET | `/categories` | Any | List distinct categories |
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
| GET | `/` | Superadmin | List all users (filter by role/search, paginated) |
| POST | `/` | Superadmin | Create a user or admin account |
| GET | `/search` | Admin+ | Search active members by name/email (for direct-issue) |
| PUT | `/:id` | Superadmin | Update name / active status / role (within account type only) |
| DELETE | `/:id` | Superadmin | Deactivate account |
| GET | `/:id/loans` | Admin+ | A specific member's loan history |

---

## Demo Accounts

| Role | Email | Password |
|---|---|---|
| Superadmin | demo.superadmin@library.test | Demo@123 |
| Admin | demo.admin@library.test | Demo@123 |
| User | demo.user1@library.test | Demo@123 |

---

## Fine Policy

- Loan period: **14 days**
- Fine rate: **$0.50 per day** overdue
- Fines are calculated automatically on the backend
- Payment is processed at the library desk and marked paid by an admin

---

## Authors

Developed by the **RUPP Year 2 — Data Science & Engineering** team  
Royal University of Phnom Penh · 2025–2026
