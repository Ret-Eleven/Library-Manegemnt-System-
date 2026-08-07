import { Outlet } from 'react-router-dom';
import { BarChart3, Users, ClipboardList, CheckCircle, User, Settings } from 'lucide-react';
import AppLayout from '../../components/AppLayout';

const NAV = [
<<<<<<< HEAD
  { to: '/superadmin',       icon: '📊', label: 'Dashboard'       },
  { to: '/superadmin/users', icon: '👥', label: 'User Management' },
  { to: '/admin/books',      icon: '📚', label: 'Books'           },
  { to: '/admin/loans',      icon: '📋', label: 'All Loans'       },
=======
  { to: '/superadmin',             icon: BarChart3,     label: 'Statistics'      },
  { to: '/superadmin/users',       icon: Users,         label: 'User Management' },
  { to: '/superadmin/loans',       icon: ClipboardList, label: 'Loans & Issue'   },
  { to: '/superadmin/approvals',   icon: CheckCircle,   label: 'Approval History'},
  { to: '/superadmin/profile',     icon: User,          label: 'Profile'         },
  { to: '/superadmin/settings',    icon: Settings,      label: 'Settings'        },
>>>>>>> testing
];

export default function SuperadminLayout() {
  return (
    <AppLayout navItems={NAV}>
      <Outlet />
    </AppLayout>
  );
}
