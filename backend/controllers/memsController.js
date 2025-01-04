const db = require('../config/db')

// get all memories from a user
exports.get_memories = (req, res) => {
    const { user_id } = req.query;

    if (!user_id) {
        return res.status(400).json({ error: 'No user ID provided in query parameters' });
    }

    db.all(
        `SELECT * FROM Memories WHERE user_id = ?`,
        [user_id],
        (err, rows) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to fetch memories' });
            }
            res.status(200).json({ status: 'OK', memories: rows });
        }
    );
};

// Add a new memory
exports.add_memory = (req, res) => {
    const { user_id, title, content, image_url, location } = req.body;

    // Validate input
    if (!user_id || !title || !content) {
        return res.status(400).json({ error: 'user_id, title, and content are required' });
    }

    db.run(
        `INSERT INTO Memories (user_id, title, content, image_url, location) 
         VALUES (?, ?, ?, ?, ?)`,
        [user_id, title, content, image_url || null, location || null],
        function (err) {
            if (err) {
                return res.status(500).json({ error: 'Failed to add memory' });
            }
            res.status(201).json({ status: 'OK', memory_id: this.lastID });
        }
    );
};

// delete a memory
exports.delete_memory = (req, res) => {
    const { id } = req.params;

    // Validate input
    if (!id) {
        return res.status(400).json({ error: 'Memory ID is required' });
    }

    db.run(
        `DELETE FROM Memories WHERE memory_id = ?`,
        [id],
        function (err) {
            if (err) {
                return res.status(500).json({ error: 'Failed to delete memory' });
            }
            if (this.changes === 0) {
                return res.status(404).json({ error: 'Memory not found' });
            }
            res.status(200).json({ status: 'OK', message: 'Memory deleted successfully' });
        }
    );
};
