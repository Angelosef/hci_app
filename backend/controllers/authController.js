const db = require('../config/db');

// Register User
exports.register = (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }

  // Insert into Users table
  db.run(
    `INSERT INTO Users (username, password) VALUES (?, ?)`,
    [username, password],
    function (err) {
      if (err) {
        return res.status(400).json({ error: 'Username already exists' });
      }

      // Insert into Settings table using the last inserted user ID
      const userId = this.lastID;  // Get the last inserted ID (user ID)
      
      db.run(
        `INSERT INTO Settings (user_id) VALUES (?)`,
        [userId],
        function (err) {
          if (err) {
            return res.status(400).json({ error: 'Failed to create settings for the user' });
          }

          // Respond with the user ID after both inserts are successful
          res.status(201).json({ status: 'OK', user_id: userId });
        }
      );
    }
  );
};


// Login User
exports.login = (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }

  db.get(
    `SELECT * FROM Users WHERE username = ? AND password = ?`,
    [username, password],
    (err, user) => {
      if (err || !user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
      res.status(200).json({ status: 'OK', user_id: user.user_id });
    }
  );
};
