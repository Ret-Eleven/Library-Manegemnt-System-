import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/user',         icon: '📚', label: 'Browse Books' },
  { to: '/user/history', icon: '📋', label: 'My Borrowings' },
];

export default function UserLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
