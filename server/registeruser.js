const express = require('express');
const router = express.Router();
const db = require('./db.js');
// const otpGenerator = require("otp-generator");
// const nodemailer = require("nodemailer");

const app = express();

router.route('/registeruser').post((req, res) => {
    // Get params
    console.log(req.body);
    var user_login = req.body.user_login;
    var user_email = req.body.user_email;
    var user_pass = req.body.user_pass;
    var user_nicename = req.body.user_nicename

  // Check if the username is already taken
  var Existquery = 'SELECT ID FROM wp_users WHERE user_login = ? AND user_email = ?';
  
  db.query(Existquery,[user_login,user_email], (err, results) => {
    if (err) {
      console.error('Error executing query: ' + err.stack);
      return res.status(500).json({ success: false, message: 'Server error' });
    }

    if (results.length > 0) {
      return res.status(400).json({ success: false, message: 'Username or email is already taken' });
    }

    // If the username is not taken, insert the new user into the database
    var query = 'INSERT INTO wp_users (user_login, user_pass,user_email,user_nicename,user_registered) VALUES (?, ?,?,?,NOW())';
    
    db.query(query,[user_login, user_pass,user_email,user_nicename], (err, results) => {
      if (err) {
        console.error('Error executing query: ' + err.stack);
        return res.status(500).json({ success: false, message: 'Server error' });
      }

      const user_id = results.insertId;
      return res.json({ success: true, user_id });
    });
  });
});

module.exports = router;
