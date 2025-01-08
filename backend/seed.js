const db = require('./config/db');

// Seed Users
db.run(`
  INSERT INTO Users (username, password) 
  VALUES 
    ('user1', 'password1'),
    ('user2', 'password2'),
    ('user3', 'password3')
`, (err) => {
  if (err) console.error('Error seeding Users:', err.message);
  else console.log('Users table seeded successfully');
});

// Seed Memories
db.run(`
  INSERT INTO Memories (user_id, title, content, image_url, latitude, longitude) 
  VALUES 
    (1, 'Mountain Adventure', 'A thrilling hike to the peak.', '/uploads/no1.jpg', 37.7749, -122.4194),
    (2, 'Beach Day', 'Relaxing day at the sunny beach.', '/uploads/no2.jpg', 34.0522, -118.2437),
    (3, 'City Lights', 'Exploring the city at night.', '/uploads/no3.jpg', 40.7128, -74.0060)
`, (err) => {
  if (err) console.error('Error seeding Memories:', err.message);
  else console.log('Memories table seeded successfully');
});

// Seed Clues
db.run(`
  INSERT INTO Clues (title, description, location, latitude, longitude, image_url) 
  VALUES 
    ('clue1', 'Find the hidden key', 'Central Park', 1.23, 34.34, '/uploads/no1.jpg'),
    ('clue2', 'Look behind the old tree', 'City Square', 34.45, 45.45, '/uploads/no2.jpg'),
    ('clue3', 'Search near the fountain', 'Town Plaza', 34.4, 42.4, '/uploads/no3.jpg')
`, (err) => {
  if (err) console.error('Error seeding Clues:', err.message);
  else console.log('Clues table seeded successfully');
});

// Seed User_Clue
db.run(`
  INSERT INTO User_Clue (user_id, clue_id) 
  VALUES 
    (1, 1),
    (2, 2),
    (3, 3)
`, (err) => {
  if (err) console.error('Error seeding User_Clue:', err.message);
  else console.log('User_Clue table seeded successfully');
});

// Seed Settings
db.run(`
  INSERT INTO Settings (user_id, notifications_enabled) 
  VALUES 
    (1, TRUE),
    (2, FALSE),
    (3, TRUE)
`, (err) => {
  if (err) console.error('Error seeding Settings:', err.message);
  else console.log('Settings table seeded successfully');
});

// Close the database connection
db.close((err) => {
  if (err) console.error('Error closing database connection:', err.message);
  else console.log('Database connection closed');
});
