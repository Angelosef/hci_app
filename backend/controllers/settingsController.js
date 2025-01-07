const db = require('../config/db');

// Update notifications setting for a user
exports.update_notifications = (req, res) => {
    const { user_id, notifications_enabled } = req.body;

    // Validate input
    if (!user_id || typeof notifications_enabled !== 'boolean') {
        return res.status(400).json({ error: 'user_id and notifications_enabled (boolean) are required' });
    }

    db.run(
        `UPDATE Settings SET notifications_enabled = ? WHERE user_id = ?`,
        [notifications_enabled, user_id],
        function (err) {
            if (err) {
                console.error('Failed to update settings:', err.message);
                return res.status(500).json({ error: 'Failed to update settings' });
            }
            if (this.changes === 0) {
                return res.status(404).json({ error: 'User settings not found' });
            }
            res.status(200).json({ status: 'OK', message: 'Settings updated successfully' });
        }
    );
};

// get settings for a specific user
exports.get_settings = (req, res) => {
    const { user_id } = req.query;

    if (!user_id) {
        return res.status(400).json({ error: 'No user ID provided in query parameters' });
    }

    db.all(
        `select * from settings where user_id=?`,
        [user_id],
        (err, rows) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to fetch settings' });
            }
            res.status(200).json({ status: 'OK', settings: rows });
        }
    );
};
