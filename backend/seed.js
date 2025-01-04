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
  INSERT INTO Memories (user_id, title, content, location) 
  VALUES 
    (1, 'First Memory', 'This is the first test memory.', 'Location A'),
    (2, 'Second Memory', 'This is the second test memory.', 'Location B'),
    (3, 'Third Memory', 'This is the third test memory.', 'Location C')
`, (err) => {
  if (err) console.error('Error seeding Memories:', err.message);
  else console.log('Memories table seeded successfully');
});

// Seed Clues
db.run(`
  INSERT INTO Clues (description, location) 
  VALUES 
    ('Find the hidden treasure', 'Park Entrance'),
    ('Look behind the old tree', 'Central Square'),
    ('Search near the fountain', 'City Garden')
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
