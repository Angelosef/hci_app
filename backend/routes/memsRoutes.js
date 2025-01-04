const express = require('express');
const router = express.Router();
const memsController = require('../controllers/memsController');

router.get('/get_all', memsController.get_memories);
router.post('/add_memory', memsController.add_memory);
router.delete('/delete_memory/:id', memsController.delete_memory);

module.exports = router;
