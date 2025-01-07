const db = require('../config/db');

// get all clues a user has found
exports.get_unlocked = (req, res) => {
    const { user_id } = req.query;

    if (!user_id) {
        return res.status(400).json({ error: 'No user ID provided in query parameters' });
    }

    db.all(
        `select * from clues where clue_id in
        (
        select clue_id from clues natural join user_clue where user_id=?
        )
        `,
        [user_id],
        (err, rows) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to fetch clues' });
            }
            res.status(200).json({ status: 'OK', clues: rows });
        }
    );
};

// get all clues a user has not found
exports.get_locked = (req, res) => {
    const { user_id } = req.query;

    if (!user_id) {
        return res.status(400).json({ error: 'No user ID provided in query parameters' });
    }

    db.all(
        `select * from clues where clue_id not in
        (
        select clue_id from clues natural join user_clue where user_id=?
        )
        `,
        [user_id],
        (err, rows) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to fetch memories' });
            }
            res.status(200).json({ status: 'OK', clues: rows });
        }
    );
};

// make a clue unlocked for a user
exports.add_unlocked = (req, res) => {
    const { user_id, clue_id} = req.body;
    if (!user_id || !clue_id) {
      return res.status(400).json({ error: 'user_id and clue_id are required' });
    }
  
    db.run(
      `INSERT INTO user_clue (user_id, clue_id) VALUES (?, ?)`,
      [user_id, clue_id],
      function (err) {
        if (err) {
          return res.status(400).json({ error: 'Username already exists' });
        }
        res.status(200).json({ status: 'OK'});
      }
    );
  };
