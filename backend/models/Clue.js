const db = require('../config/db');

// Create Clues Table
db.run(`
  CREATE TABLE IF NOT EXISTS Clues (
    clue_id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT NOT NULL,
    image_url TEXT,
    location TEXT NOT NULL
  )
`);
