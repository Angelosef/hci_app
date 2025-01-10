const db = require('../config/db');

// Create Clues Table
db.run(`
  CREATE TABLE IF NOT EXISTS Clues (
    clue_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    image_url TEXT NOT NULL,
    location TEXT,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL
  )
`);
