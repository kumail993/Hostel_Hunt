const express=require('express');
const router=express.Router();
var db=require('./db.js');
const app = express();
require('dotenv').config();


router.route('/websiteotpverification').post((req, res, next) => {
    console.log(req.body);
    var user_email = req.body.user_email;
    var otp = req.body.otp;

    db.query('SELECT * FROM wp_users WHERE user_email = ?', [user_email], (err, rows) => {
        if (err) {
            console.error('Database query error:', err.message);
            res.status(500).json({ message: 'Internal server error' });
        } else if (rows.length > 0) {
            const row = rows[0];
            console.log(row.otp); // Get the first row from the array
            console.log(otp);
            if (row.otp == otp) {
                db.query('UPDATE wp_users SET user_status = 1 WHERE user_email = ?', [user_email], (err) => {
                    if (err) {
                        console.error('Database update error:', err.message);
                        res.status(500).json({ message: 'Internal server error' });
                    } else {
                        res.json({ message: 'OTP verified and status updated.' });
                    }
                });
            } else {
                res.status(400).json({ message: 'OTP does not match.' });
            }
        } else {
            res.status(404).json({ message: 'User not found.' });
        }
    });
});
module.exports = router;