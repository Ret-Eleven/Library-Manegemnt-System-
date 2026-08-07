import { Outlet } from 'react-router-dom';
import { Home, BookOpen, BookMarked, User, Settings } from 'lucide-react';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/user',           icon: Home,       label: 'Home'        },
  { to: '/user/catalog',   icon: BookOpen,   label: 'Book Catalog'},
  { to: '/user/history',   icon: BookMarked, label: 'My Books'    },
  { to: '/user/profile',   icon: User,       label: 'Profile'     },
  { to: '/user/settings',  icon: Settings,   label: 'Settings'    },
];

export default function UserLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
