import { Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';

import Login    from './pages/Login';
import Register from './pages/Register';

import UserLayout       from './pages/user/UserLayout';
import BookCatalog      from './pages/user/BookCatalog';
import BorrowingHistory from './pages/user/BorrowingHistory';

import AdminLayout      from './pages/admin/AdminLayout';
import AdminDashboard   from './pages/admin/AdminDashboard';
import BookManagement   from './pages/admin/BookManagement';
import LoanManagement   from './pages/admin/LoanManagement';

import SuperadminLayout   from './pages/superadmin/SuperadminLayout';
import SuperadminDashboard from './pages/superadmin/SuperadminDashboard';
import UserManagement     from './pages/superadmin/UserManagement';

export default function App() {
  return (
    <AuthProvider>
      <Routes>
        <Route path="/login"    element={<Login />} />
        <Route path="/register" element={<Register />} />

        {/* User dashboard — all roles can access */}
        <Route
          path="/user"
          element={
            <ProtectedRoute allowedRoles={['user', 'admin', 'superadmin']}>
              <UserLayout />
            </ProtectedRoute>
          }
        >
          <Route index          element={<BookCatalog />} />
          <Route path="history" element={<BorrowingHistory />} />
        </Route>

        {/* Admin dashboard */}
        <Route
          path="/admin"
          element={
            <ProtectedRoute allowedRoles={['admin', 'superadmin']}>
              <AdminLayout />
            </ProtectedRoute>
          }
        >
          <Route index         element={<AdminDashboard />} />
          <Route path="books"  element={<BookManagement />} />
          <Route path="loans"  element={<LoanManagement />} />
        </Route>

        {/* Superadmin dashboard */}
        <Route
          path="/superadmin"
          element={
            <ProtectedRoute allowedRoles={['superadmin']}>
              <SuperadminLayout />
            </ProtectedRoute>
          }
        >
          <Route index         element={<SuperadminDashboard />} />
          <Route path="users"  element={<UserManagement />} />
        </Route>

        <Route path="/"   element={<Navigate to="/user" replace />} />
        <Route path="*"   element={<Navigate to="/user" replace />} />
      </Routes>
    </AuthProvider>
  );
}
