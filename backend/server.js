const express = require('express');
const cors = require('cors');
require('dotenv').config();

const authRoutes = require('./routes/authRoutes');
const memsRoutes = require('./routes/memsRoutes');
const cluesRoutes = require('./routes/cluesRoutes');
const settingsRoutes = require('./routes/settingsRoutes');

require('./models/User');
require('./models/Memory');
require('./models/Clue');
require('./models/User_Clue');
require('./models/Settings');


const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

app.use('/uploads', express.static('uploads'));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/memories', memsRoutes);
app.use('/api/clues', cluesRoutes);
app.use('/api/settings', settingsRoutes);


// Test Route
app.get('/', (req, res) => {
  res.send('Backend is running!');
});

// Start Server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
