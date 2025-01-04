const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const db = new sqlite3.Database(
  path.resolve(__dirname, '../data/database.db'),
  (err) => {
    if (err) console.error('Database connection failed:', err.message);
    else console.log('Connected to SQLite database');
  }
);

module.exports = db;
