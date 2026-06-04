import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/',             icon: '🏠', label: 'Home'         },
  { to: '/user',         icon: '📚', label: 'Book Catalog'  },
  { to: '/user/history', icon: '📖', label: 'My Books'      },
];

export default function UserLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
