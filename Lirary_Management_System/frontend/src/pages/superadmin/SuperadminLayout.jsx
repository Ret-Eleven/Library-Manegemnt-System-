import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/superadmin',       icon: '📊', label: 'Dashboard'       },
  { to: '/superadmin/users', icon: '👥', label: 'User Management' },
  { to: '/admin/books',      icon: '📚', label: 'Books'           },
  { to: '/admin/loans',      icon: '📋', label: 'All Loans'       },
];

export default function SuperadminLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
