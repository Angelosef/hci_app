const express = require('express');
const router = express.Router();
const memsController = require('../controllers/memsController');
const multer = require('multer');
const path = require('path');

// Configure Multer to preserve the file extension
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        const ext = path.extname(file.originalname); // Get original file extension
        cb(null, `${uniqueSuffix}${ext}`);
    }
});

const upload = multer({ storage: storage });

router.post('/add_memory', upload.single('image'), memsController.add_memory);
router.get('/get_all', memsController.get_memories);
router.delete('/delete_memory/:id', memsController.delete_memory);

module.exports = router;
