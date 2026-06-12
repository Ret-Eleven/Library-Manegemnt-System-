import { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { useAuth } from './AuthContext';
import api from '../services/api';

const NotifCtx = createContext(null);

/* ── Derive notifications from API data ──────────────────────── */

function fromUserLoans(loans) {
  const today = new Date();
  const items = [];

  loans.forEach(l => {
    if (l.is_overdue) {
      items.push({
        id:     `overdue-${l.id}`,
        type:   'overdue',
        icon:   '⚠️',
        dotCls: 'bg-red-500',
        ringCls:'bg-red-100 text-red-600',
        title:  'Overdue Book',
        body:   `"${l.title}" was due ${l.due_date}. Fine: $${(l.current_fine || 0).toFixed(2)}`,
        link:   '/user/history',
        urgent: true,
      });
      return;
    }

    if (l.status === 'active' && l.due_date) {
      const days = Math.ceil((new Date(l.due_date) - today) / 86400000);
      if (days >= 0 && days <= 3) {
        items.push({
          id:     `due-soon-${l.id}`,
          type:   'due_soon',
          icon:   '⏰',
          dotCls: 'bg-amber-500',
          ringCls:'bg-amber-100 text-amber-700',
          title:  'Due Soon',
          body:   `"${l.title}" is due ${days === 0 ? 'today' : `in ${days} day${days > 1 ? 's' : ''}`}.`,
          link:   '/user/history',
          urgent: days === 0,
        });
      }
    }

    if (l.status === 'pending') {
      items.push({
        id:     `pending-${l.id}`,
        type:   'pending',
        icon:   '⏳',
        dotCls: 'bg-blue-400',
        ringCls:'bg-blue-100 text-blue-600',
        title:  'Request Pending',
        body:   `Your request for "${l.title}" is awaiting librarian approval.`,
        link:   '/user/history',
        urgent: false,
      });
    }
  });

  return items;
}

function fromAdminCounts(pendingTotal, overdueCount) {
  const items = [];

  if (pendingTotal > 0) {
    items.push({
      id:     `admin-pending-${pendingTotal}`,
      type:   'pending',
      icon:   '📋',
      dotCls: 'bg-orange-500',
      ringCls:'bg-orange-100 text-orange-700',
      title:  `${pendingTotal} Pending Request${pendingTotal > 1 ? 's' : ''}`,
      body:   `${pendingTotal} borrow request${pendingTotal > 1 ? 's' : ''} awaiting your approval.`,
      link:   '/admin/loans',
      urgent: true,
    });
  }

  if (overdueCount > 0) {
    items.push({
      id:     `admin-overdue-${overdueCount}`,
      type:   'overdue',
      icon:   '⚠️',
      dotCls: 'bg-red-500',
      ringCls:'bg-red-100 text-red-600',
      title:  `${overdueCount} Overdue Loan${overdueCount > 1 ? 's' : ''}`,
      body:   `${overdueCount} active loan${overdueCount > 1 ? 's are' : ' is'} past the due date.`,
      link:   '/admin/loans',
      urgent: true,
    });
  }

  return items;
}

function fromStats(stats) {
  const items = [];

  if (stats.pendingRequests > 0) {
    items.push({
      id:     `super-pending-${stats.pendingRequests}`,
      type:   'pending',
      icon:   '📋',
      dotCls: 'bg-orange-500',
      ringCls:'bg-orange-100 text-orange-700',
      title:  `${stats.pendingRequests} Pending Requests`,
      body:   `${stats.pendingRequests} borrow requests are awaiting approval.`,
      link:   '/admin/loans',
      urgent: true,
    });
  }

  if (stats.overdueLoans > 0) {
    items.push({
      id:     `super-overdue-${stats.overdueLoans}`,
      type:   'overdue',
      icon:   '⚠️',
      dotCls: 'bg-red-500',
      ringCls:'bg-red-100 text-red-600',
      title:  `${stats.overdueLoans} Overdue Loans`,
      body:   `${stats.overdueLoans} active loans are past their due date.`,
      link:   '/admin/loans',
      urgent: true,
    });
  }

  return items;
}

/* ── Provider ────────────────────────────────────────────────── */
export function NotificationProvider({ children }) {
  const { user } = useAuth();

  const [notifications, setNotifications] = useState([]);
  const [loading, setLoading] = useState(false);

  /* IDs the user has already seen, persisted in localStorage */
  const [readIds, setReadIds] = useState(() => {
    try { return new Set(JSON.parse(localStorage.getItem('lms_notif_read') || '[]')); }
    catch { return new Set(); }
  });

  const fetch = useCallback(async () => {
    if (!user) { setNotifications([]); return; }
    setLoading(true);
    try {
      let items = [];

      if (user.role === 'user') {
        const { data } = await api.get('/api/loans/my');
        items = fromUserLoans(data);

      } else if (user.role === 'admin') {
        const [r1, r2] = await Promise.all([
          api.get('/api/loans', { params: { status: 'pending', limit: 1 } }),
          api.get('/api/loans', { params: { status: 'active',  limit: 200 } }),
        ]);
        const pendingTotal  = r1.data.total || 0;
        const overdueCount  = (r2.data.loans || []).filter(l => l.is_overdue).length;
        items = fromAdminCounts(pendingTotal, overdueCount);

      } else if (user.role === 'superadmin') {
        const { data } = await api.get('/api/loans/stats/overview');
        items = fromStats(data);
      }

      /* Sort: urgent first */
      items.sort((a, b) => (b.urgent ? 1 : 0) - (a.urgent ? 1 : 0));
      setNotifications(items);
    } catch {
      /* fail silently — bell just shows 0 */
    } finally {
      setLoading(false);
    }
  }, [user]);

  /* Fetch on mount + every 60 s */
  useEffect(() => {
    fetch();
    const id = setInterval(fetch, 60_000);
    return () => clearInterval(id);
  }, [fetch]);

  const markAllRead = () => {
    const ids = new Set(notifications.map(n => n.id));
    setReadIds(ids);
    localStorage.setItem('lms_notif_read', JSON.stringify([...ids]));
  };

  const unreadCount = notifications.filter(n => !readIds.has(n.id)).length;

  return (
    <NotifCtx.Provider value={{ notifications, unreadCount, loading, markAllRead, refresh: fetch }}>
      {children}
    </NotifCtx.Provider>
  );
}

export const useNotifications = () => useContext(NotifCtx);
