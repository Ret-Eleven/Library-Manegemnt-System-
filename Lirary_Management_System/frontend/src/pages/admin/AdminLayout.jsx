import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/admin',       icon: '📊', label: 'Dashboard' },
  { to: '/admin/books', icon: '📚', label: 'Books' },
  { to: '/admin/loans', icon: '📋', label: 'Loans & Requests' },
];

export default function AdminLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
