const express = require('express');
const router = express.Router();
const db = require('./db.js');
const bcrypt = require('bcrypt');
const app = express();
require('dotenv').config();

router.route('/loginuser').post((req, res, next) => {
    console.log(req.body);
    var user_login = req.body.user_login;
    var user_pass = req.body.user_pass;

    var sql = "SELECT * FROM wp_users WHERE user_login=?";

    if (user_login !== "" && user_pass !== "") {
        db.query(sql, [user_login], async function(err, data, fields) {
            if (err) {
                console.log(err);
                res.status(500).json({ success: false, message: "Internal server error" });
            } else {
                if (data.length > 0) {
                    const hashedPassword = data[0].user_pass;

                    // Compare the hashed password with the provided password
                    const passwordMatch = await bcrypt.compare(user_pass, hashedPassword);

                    if (passwordMatch) {
                        // Assuming there's an 'active_status' column in wp_users table
                        if (data[0].user_status === 1) {
                            res.status(200).json({ success: true, user: data });
                        } else {
                            res.status(403).json({ success: false, message: 'User not verified' });
                        }
                    } else {
                        res.status(401).json({ success: false, message: 'Incorrect username or password' });
                    }
                } else {
                    res.status(401).json({ success: false, message: 'Incorrect username or password' });
                }
            }
        });
    } else {
        res.status(400).json({ success: false, message: 'Username and password required!' });
    }
});

module.exports = router;



