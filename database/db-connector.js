const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'classmysql.engr.oregonstate.edu',   
  user: 'cs340_senorons',
  password: 'jQtZrUYlAoIt',
  database: 'cs340_senorons',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = pool;