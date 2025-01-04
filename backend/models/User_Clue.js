const db = require('../config/db');

// Create User_Clue Table
db.run(`
  CREATE TABLE IF NOT EXISTS User_Clue (
    user_clue_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    clue_id INTEGER,
    unlocked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (clue_id) REFERENCES Clues(clue_id)
  )
`);
