
const express = require('express');
const router = express.Router();
const db = require('./db.js');
const app = express();
require('dotenv').config();

router.route('/loginuser').post((req, res, next) => {
    console.log(req.body);

const { user_login, user_pass } = req.body;

  // SQL query to check user credentials
  const sql = 'SELECT id FROM wp_users WHERE user_login = ? AND user_pass = ?';

  db.query(sql, [user_login, user_pass], (err, results) => {
    if (err) {
      console.error('Error executing query: ' + err.stack);
      return res.status(500).json({ success: false, message: 'Server error' });
    }

    if (results.length === 1) {
      const user_id = results[0].id;
      return res.json({ success: true, user_id });
    } else {
      return res.status(401).json({ success: false, message: 'Invalid login credentials' });
    }
  });
    

    
});

module.exports = router;

