import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/user',           icon: '🏠', label: 'Home'         },
  { to: '/user/catalog',   icon: '📚', label: 'Book Catalog'  },
  { to: '/user/history',   icon: '📖', label: 'My Books'      },
  { to: '/user/profile',   icon: '👤', label: 'Profile'       },
  { to: '/user/settings',  icon: '⚙️', label: 'Settings'      },
];

export default function UserLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
