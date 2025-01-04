const db = require('../config/db');

// Register User
exports.register = (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }

  db.run(
    `INSERT INTO Users (username, password) VALUES (?, ?)`,
    [username, password],
    function (err) {
      if (err) {
        return res.status(400).json({ error: 'Username already exists' });
      }
      res.status(201).json({ status: 'OK', user_id: this.lastID });
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
