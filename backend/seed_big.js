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
    (1, 'Mountain Adventure', 'A thrilling hike to the peak of the mountain where I had the chance to observe breathtaking views of the valley below. The journey was full of challenges, but the stunning landscape made every step worthwhile. I will never forget the feeling of reaching the summit and witnessing the panoramic view. The quiet at the top made it the perfect place to reflect on the journey.', '/uploads/im1.jpg', 37.7749, -122.4194),
    (1, 'Beach Day', 'Relaxing day at the sunny beach with the sound of the waves crashing in the background. The golden sands stretched out before me, and I took a long walk by the water, feeling the cool breeze on my face. I also spent some time lounging under the umbrella, enjoying a cold drink while reading a book. The sunset that evening was absolutely mesmerizing, a perfect ending to a day well spent.', '/uploads/im2.jpg', 34.0522, -118.2437),
    (3, 'City Lights', 'Exploring the city at night was an unforgettable experience. The streets were alive with energy, and the lights from the skyscrapers illuminated the whole city in a magical glow. I wandered around the bustling streets, discovering new restaurants and coffee shops, and even found a hidden gem for late-night snacks. It was an adventure in itself, full of excitement and new discoveries.', '/uploads/im3.jpg', 40.7128, -74.0060),
    (2, 'Countryside Escape', 'A peaceful getaway to the countryside where the air was fresh and the scenery was untouched by time. I spent my days walking through fields of flowers and my evenings by the fireplace, enjoying homemade meals. The tranquil environment offered the perfect escape from the hectic pace of everyday life, allowing me to reconnect with nature.', '/uploads/im4.jpg', 51.5074, -0.1278),
    (3, 'Mountain Sunset', 'The sunset over the mountains was an experience I’ll never forget. The sky was painted with hues of orange and pink, casting a warm glow over the landscape. The climb to the viewpoint was challenging, but once I reached the top, I was rewarded with a view that made all the effort worth it. The fading light as the night approached created a peaceful and surreal moment.', '/uploads/im5.jpg', 39.7392, -104.9903),
    (1, 'Lakeside Serenity', 'A quiet retreat by the lakeside, where I spent the entire weekend enjoying the serene atmosphere. Early mornings by the water, watching the mist rise from the lake, and the sound of birds chirping in the distance made it an idyllic getaway. I spent time reading, fishing, and reflecting, all while taking in the calm beauty of nature.', '/uploads/im6.jpg', 46.8797, -121.7269),
    (2, 'Desert Trek', 'A long trek across the desert, where the heat was intense, and the landscape seemed to stretch endlessly in every direction. Despite the challenges, the vast open spaces and quiet isolation were peaceful. The dunes shifted as I walked, and the golden colors of the desert at sunset were mesmerizing. I’ll never forget the incredible silence and the way the stars looked at night.', '/uploads/im1.jpg', 36.7783, 119.4179),
    (3, 'Tropical Paradise', 'An unforgettable journey to a tropical island where the turquoise water met the white sandy beaches. The weather was perfect, and I spent most of my time swimming in the clear waters and exploring the local culture. I also visited the famous waterfall nearby, where I took a refreshing dip under the cascade of water.', '/uploads/im2.jpg', 8.9833, -79.5167),
    (1, 'Snowy Peaks', 'A winter expedition to a snowy mountain range, where the air was crisp and the snow covered everything in a beautiful white blanket. Skiing down the slopes was exhilarating, and the frozen lakes offered a serene moment of reflection. The mountain village at the base of the slopes was charming, with cozy cabins and warm fires.', '/uploads/im3.jpg', 45.4215, -75.6992),
    (2, 'Historic Ruins', 'Exploring the ancient ruins of a lost civilization was like stepping back in time. The stone structures, weathered by centuries of history, stood as a reminder of a once-great culture. I wandered through the remnants of temples and palaces, imagining what life might have been like in this forgotten place. The views from the ruins were breathtaking, offering a glimpse into both history and the natural world.', '/uploads/im4.jpg', 30.0444, 31.2357)
`, (err) => {
  if (err) console.error('Error seeding Memories:', err.message);
  else console.log('Memories table seeded successfully');
});

// Seed Clues
db.run(`
  INSERT INTO Clues (title, description, location, latitude, longitude, image_url) 
  VALUES 
    ('Hidden Key', 'Find the hidden key near the old oak tree in Central Park. It’s well hidden, so make sure to look closely at the roots and branches. This clue will lead you to the next step in your adventure. Be careful, as the area can be busy, and many people may pass by without noticing the hidden object. The key is small, so you need a keen eye to spot it.', 'Central Park', 1.23, 34.34, '/uploads/im1.jpg'),
    ('Behind the Tree', 'Look behind the old tree in City Square. This tree has witnessed many years of change, and its bark is worn and weathered. You’ll need to explore the area around the tree’s base to find the clue. The square is a popular gathering spot, so be prepared to keep an eye out for curious bystanders. The clue is tucked away, not far from the trunk, beneath the thick roots.', 'City Square', 34.45, 45.45, '/uploads/im2.jpg'),
    ('Fountain Secret', 'Search near the fountain in Town Plaza. The water in the fountain flows continuously, and the sound creates a peaceful atmosphere. Look for a small hidden compartment under the stone structure of the fountain. It’s an ideal spot to conceal something valuable, and it’s often overlooked by those simply passing by. The compartment blends in well with the surrounding stones, making it tricky to spot.', 'Town Plaza', 34.4, 42.4, '/uploads/im3.jpg'),
    ('The Hidden Passage', 'In the alleyway behind the old library, there’s a hidden passage that leads to a forgotten garden. It’s not marked, but if you know where to look, you can find it by examining the bricks closely. The clue is tucked inside a small crevice near the back wall, just behind some ivy. Take care, as it can be easy to miss if you’re not paying attention.', 'Old Library Alley', 51.5174, -0.1279, '/uploads/im4.jpg'),
    ('Mountain Summit', 'On the summit of the mountain, there’s a plaque that commemorates the early explorers of the region. The clue is etched onto the plaque itself, but only those with a sharp eye can notice it. The view from the top is breathtaking, and many come here to reflect on their journey. But if you’re looking for the clue, be sure to check the plaque carefully.', 'Mountain Peak', 39.7392, -104.9903, '/uploads/im5.jpg'),
    ('Sunken Treasure', 'Look for the sunken treasure near the old dock. Over the years, the sea has covered many artifacts, but there’s still one item that lies waiting to be discovered. The clue is hidden in a small, rusted chest that has been forgotten by time. Dive into the shallow waters and search near the edge of the dock to find it.', 'Old Dock', 36.7783, 119.4179, '/uploads/im6.jpg'),
    ('The Whispering Winds', 'In the quiet corner of the park, there’s a bench that faces the river. The clue is hidden beneath the seat, covered by some moss and leaves. The bench has stood there for decades, weathering the passage of time. The soft whisper of the winds through the trees may lead you to this hidden treasure.', 'River Park', 37.7749, -122.4194, '/uploads/im1.jpg'),
    ('Under the Bridge', 'Find the hidden compartment under the old stone bridge. The area is known for its serenity, and many come here to sit and reflect. But beneath the arch of the bridge, there is a small iron lockbox. It’s been here for years, waiting for someone with the knowledge of its location to discover it.', 'Stone Bridge', 40.7128, -74.0060, '/uploads/im2.jpg'),
    ('In the Old Well', 'The old well in the garden is a relic from a bygone era. But if you look closely, you’ll find a hidden metal plate at the bottom. The clue is etched into the metal, waiting for someone to uncover it. Be careful, as the well is deep and dark, and the metal plate can be hard to spot in the shadows.', 'Old Garden', 34.0522, -118.2437),
    ('Beneath the Lighthouse', 'Search beneath the old lighthouse. There’s a secret door hidden in the stone foundation, and the clue is hidden inside a small compartment near the base. The lighthouse has been standing for over a century, but its secrets are still locked away from the public eye. Only those who know where to look will find it.', 'Lighthouse', 38.7749, -77.4194, '/uploads/im3.jpg'),
    ('The Secret Room', 'In the abandoned mansion, there’s a secret room hidden behind the bookshelves in the library. The only way to open the door is by pressing a specific set of books. Once the door swings open, the clue is revealed on a small desk inside. The room hasn’t been touched in years, and the dust tells the story of its forgotten history.', 'Mansion', 30.0444, 31.2357, '/uploads/im4.jpg')
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
    (3, 3),
    (1, 4),
    (2, 5),
    (3, 6),
    (1, 7),
    (2, 8),
    (3, 9),
    (1, 10),
    (2, 11),
    (3, 12)
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
