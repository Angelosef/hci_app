const db = require('../config/db');

// Create Settings Table
db.run(`
  CREATE TABLE IF NOT EXISTS Settings (
    user_id INTEGER PRIMARY KEY,
    notifications_enabled BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
  )
`);
