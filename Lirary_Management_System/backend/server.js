require('dotenv').config();
const express = require('express');
<<<<<<< HEAD
const cors = require('cors');
=======
const cors    = require('cors');
>>>>>>> testing

const authRoutes = require('./routes/auth');
const bookRoutes = require('./routes/books');
const loanRoutes = require('./routes/loans');
const userRoutes = require('./routes/users');

const app  = express();
const PORT = process.env.PORT || 5000;

app.use(cors({ origin: process.env.CLIENT_URL || 'http://localhost:5173', credentials: true }));
app.use(express.json());

<<<<<<< HEAD
app.use('/api/auth', authRoutes);
=======
app.use('/api/auth',  authRoutes);
>>>>>>> testing
app.use('/api/books', bookRoutes);
app.use('/api/loans', loanRoutes);
app.use('/api/users', userRoutes);

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Internal server error' });
});

app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
