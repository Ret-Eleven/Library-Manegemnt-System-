import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/superadmin',       icon: '📊', label: 'Statistics' },
  { to: '/superadmin/users', icon: '👥', label: 'User Management' },
];

export default function SuperadminLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
