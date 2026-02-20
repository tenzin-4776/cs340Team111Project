const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'classmysql.engr.oregonstate.edu',   
  user: 'cs340_ramirej9',
  password: 'NRhaYEs3EcFh',
  database: 'cs340_ramirej9',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = pool;