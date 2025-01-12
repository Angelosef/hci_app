const db = require('../config/db');
const fs = require('fs');
const path = require('path');
const exifParser = require('exif-parser');

// Add a new memory with image upload
exports.add_memory = (req, res) => {
    const { user_id, title, content } = req.body;

    if (!user_id || !title || !content || !req.file) {
        return res.status(400).json({ error: 'user_id, title, content, and image are required' });
    }

    // Default values for latitude and longitude
    let latitude = 0;
    let longitude = 0;

    // Extract EXIF data from the uploaded image
    const imagePath = req.file.path;

    try {
        const buffer = fs.readFileSync(imagePath);
        const parser = exifParser.create(buffer);
        const result = parser.parse();

        if (result.tags.GPSLatitude && result.tags.GPSLongitude) {
            latitude = result.tags.GPSLatitude;
            longitude = result.tags.GPSLongitude;

            // Adjusting EXIF GPS reference (North/South, East/West)
            if (result.tags.GPSLatitudeRef === 'S') latitude = -latitude;
            if (result.tags.GPSLongitudeRef === 'W') longitude = -longitude;
        }
    } catch (err) {
        console.error('Failed to extract EXIF data:', err.message);
    }

    // Save the memory to the database
    db.run(
        `INSERT INTO Memories (user_id, title, content, image_url, latitude, longitude) 
         VALUES (?, ?, ?, ?, ?, ?)`,
        [
            user_id,
            title,
            content,
            `/uploads/${req.file.filename}`,
            latitude,
            longitude,
        ],
        function (err) {
            if (err) {
                return res.status(500).json({ error: 'Failed to add memory' });
            }

            res.status(201).json({
                status: 'OK',
                memory_id: this.lastID,
                latitude,
                longitude,
            });
        }
    );
};



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


// delete a memory
exports.delete_memory = (req, res) => {
    const { id } = req.params;

    if (!id) {
        return res.status(400).json({ error: 'Memory ID is required' });
    }

    // Step 1: Get the image URL from the database
    db.get(
        `SELECT image_url FROM Memories WHERE memory_id = ?`,
        [id],
        (err, row) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to retrieve memory' });
            }
            if (!row) {
                return res.status(404).json({ error: 'Memory not found' });
            }

            const imagePath = row.image_url ? path.join(__dirname, '..', row.image_url) : null;

            // Step 2: Delete the memory from the database
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

                    // Step 3: Delete the image file (if it exists)
                    if (imagePath && fs.existsSync(imagePath)) {
                        fs.unlink(imagePath, (unlinkErr) => {
                            if (unlinkErr) {
                                console.error('Failed to delete image file:', unlinkErr.message);
                                return res.status(500).json({ 
                                    error: 'Memory deleted, but failed to delete image file' 
                                });
                            }
                            res.status(200).json({ 
                                status: 'OK', 
                                message: 'Memory and image file deleted successfully' 
                            });
                        });
                    } else {
                        res.status(200).json({ 
                            status: 'OK', 
                            message: 'Memory deleted successfully (no associated image found)' 
                        });
                    }
                }
            );
        }
    );
};
