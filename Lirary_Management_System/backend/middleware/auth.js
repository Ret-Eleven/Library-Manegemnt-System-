const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'library-secret-key-change-in-production';

function authenticate(req, res, next) {
  const header = req.headers.authorization;
  if (!header?.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'No token provided' });
  }
  try {
    req.user = jwt.verify(header.split(' ')[1], JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ message: 'Invalid or expired token' });
  }
}

module.exports = { authenticate, JWT_SECRET };
