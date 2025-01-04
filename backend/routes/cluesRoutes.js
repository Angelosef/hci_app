const express = require('express');
const router = express.Router();
const cluesController = require('../controllers/cluesController');

router.get('/get_unlocked', cluesController.get_unlocked);
router.get('/get_locked', cluesController.get_locked);
router.post('/add_unlocked', cluesController.add_unlocked);

module.exports = router;
