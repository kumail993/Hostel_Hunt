const express = require('express');
const router = express.Router();
const db = require('./db.js');
 const otpGenerator = require("otp-generator");
 const nodemailer = require("nodemailer");

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

    const otp = otpGenerator.generate(6, { digits: true, alphabets: false, upperCaseAlphabets: false, lowerCaseAlphabets: false, specialChars: false });
                console.log(otp);

                // Send OTP to the given Email
                const transporter = nodemailer.createTransport({
                    service: "Gmail", // Use your email service here (e.g., "Gmail", "Outlook")
                    auth: {
                        user: "khaider308@gmail.com",
                        pass: "epjudfftrtdmaukc",
                    },
                });
                const mailOptions = {
                    from: "Khaider308@gmail.com",
                    to: user_email, // Recipient's email
                    subject: "Your Hostel-hunt Verification Code",
                    html: `<html>
                    <head>
                    <style>
                      body {
                        font-family: Arial, sans-serif;
                        background-color: white;
                        margin: 0;
                        padding: 0;
                      }
                      .container {
                        max-width: 600px;
                        margin: 0 auto;
                        padding: 20px;
                        border: 1px solid #ddd;
                      }
                      .header {
                        color: #0d47a1; /* Dark Blue */
                        font-size: 24px;
                        margin-bottom: 10px;
                        text-align: center;
                      }
                      .info {
                        font-size: 18px;
                        margin-bottom: 20px;
                        text-align: center;
                        color: #333; /* Dark Gray */
                      }
                      .otp {
                        font-weight: bold;
                        font-size: 28px;
                        color: #0d47a1; /* Dark Blue */
                        text-align: center;
                        margin: 20px 0;
                      }
                      .footer {
                        font-size: 14px;
                        margin-top: 20px;
                        color: white;
                        background-color: #0d47a1; /* Dark Blue */
                        padding: 10px;
                        text-align: center;
                      }
                    </style>
                  </head>
                  <body>
                    <div class="container">
                      <div class="header">Verification Email</div>
                      <div class="info">
                        Hello, ${user_nicename}!<br>
                        We're delighted to welcome you to our Hostel-hunt community.
                      </div>
                      <div class="otp">${otp}</div>
                      <div class="info">
                        Use the verification code above to complete your registration process. If you haven't initiated this request, kindly disregard this email.
                      </div>
                      <div class="footer">
                        Best regards,<br>
                        The Hostel-hunt Team
                      </div>
                    </div>
                  </body>
                    </html>`
                };

                transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {
                        console.error("Error sending OTP:", error);
                        res.status(500).json({ success: false, message: 'Error sending OTP' });
                    } else {
                        console.log("OTP email sent:", info.response);

    // If the username is not taken, insert the new user into the database
    var query = 'INSERT INTO wp_users (user_login, user_pass,user_email,user_nicename,user_registered,user_status,otp) VALUES (?, ?,?,?,NOW(),0,?)';
    
    db.query(query,[user_login, user_pass,user_email,user_nicename,otp], (err, results) => {
      if (err) {
        console.error('Error executing query: ' + err.stack);
        return res.status(500).json({ success: false, message: 'Server error' });
      }

      const user_id = results.insertId;
      return res.json({ success: true, user_id });
    });
  }
  });
});
});

module.exports = router;
