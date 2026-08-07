import { Outlet } from 'react-router-dom';
import { LayoutDashboard, BookOpen, ClipboardList, User, Settings } from 'lucide-react';
import AppLayout from '../../components/AppLayout';

const NAV = [
  { to: '/admin',           icon: LayoutDashboard, label: 'Dashboard'       },
  { to: '/admin/books',     icon: BookOpen,        label: 'Books'           },
  { to: '/admin/loans',     icon: ClipboardList,   label: 'Loans & Requests'},
  { to: '/admin/profile',   icon: User,            label: 'Profile'         },
  { to: '/admin/settings',  icon: Settings,        label: 'Settings'        },
];

export default function AdminLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
