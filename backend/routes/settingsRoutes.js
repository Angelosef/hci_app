const express = require('express');
const router = express.Router();
const settingsController = require('../controllers/settingsController');

router.put('/update', settingsController.update_notifications);

module.exports = router;
