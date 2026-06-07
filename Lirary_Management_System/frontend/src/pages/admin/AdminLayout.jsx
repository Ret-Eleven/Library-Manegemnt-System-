import { Outlet } from 'react-router-dom';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/admin',           icon: '📊', label: 'Dashboard'      },
  { to: '/admin/books',     icon: '📚', label: 'Books'           },
  { to: '/admin/loans',     icon: '📋', label: 'Loans & Requests'},
  { to: '/admin/profile',   icon: '👤', label: 'Profile'         },
  { to: '/admin/settings',  icon: '⚙️', label: 'Settings'        },
];

export default function AdminLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
