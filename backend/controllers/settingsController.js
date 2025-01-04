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
