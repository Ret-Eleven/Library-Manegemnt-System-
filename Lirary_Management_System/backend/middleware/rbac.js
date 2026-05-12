const ROLE_LEVEL = { user: 1, admin: 2, superadmin: 3 };

function requireRole(...roles) {
  return (req, res, next) => {
    if (!req.user) return res.status(401).json({ message: 'Unauthenticated' });
    if (roles.includes(req.user.role)) return next();
    res.status(403).json({ message: 'Insufficient permissions' });
  };
}

function requireMinRole(minRole) {
  return (req, res, next) => {
    if (!req.user) return res.status(401).json({ message: 'Unauthenticated' });
    if ((ROLE_LEVEL[req.user.role] || 0) >= (ROLE_LEVEL[minRole] || 99)) return next();
    res.status(403).json({ message: 'Insufficient permissions' });
  };
}

module.exports = { requireRole, requireMinRole };
