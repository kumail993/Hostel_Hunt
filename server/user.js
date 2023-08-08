const express=require('express');
const router=express.Router();
var db=require('./db.js');
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");

const app = express();

router.route('/register').post((req, res) => {
    // Get params
    console.log(req.body);
    var student_name = req.body.student_name;
    var email = req.body.email;
    var password = req.body.password;


    // Check if the email or name already exists
    var checkExistingQuery = "SELECT * FROM login WHERE email = ? OR password = ?";
    db.query(checkExistingQuery, [email, student_name], function (error, existingUsers) {
        if (error) {
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            if (existingUsers.length > 0) {
                // User with the same email or name already exists
                res.send(JSON.stringify({ success: false, message: 'User with the same email or name already registered' }));
            } else {
                //here

                //Generating OTP for User Authentication

                const otp = otpGenerator.generate(6, { digits: true, alphabets: false, upperCaseAlphabets: false,lowerCaseAlphabets: false, specialChars: false });
                console.log(otp);

                //sending OTP to the given Email

                const transporter = nodemailer.createTransport({
                    service: "Gmail", // Use your email service here (e.g., "Gmail", "Outlook")
                    auth: {
                    user: "khaider308@gmail.com",
                    pass: "epjudfftrtdmaukc",
                    },
                });

                const mailOptions = {
                    from: "Khaider308@gmail.com",
                    to: email, // Recipient's email
                    subject: "Your OTP Code",
                    text: `Your OTP code is: ${otp}`,
                };


                transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {
                    console.log("Error sending OTP:", error);
                    } else {
                    console.log("OTP email sent:", info.response);
                    }
                });


                // Create query for inserting into login table
                var loginSqlQuery = "INSERT INTO login(email, password, otp) VALUES (?, ?, ?)";

                // Call database to insert into login table
                db.query(loginSqlQuery, [email, password, otp], function (error, loginResult, fields) {
                    if (error) {
                        res.send(JSON.stringify({ success: false, message: error }));
                    } else {
                        // Insert successful, now get the login ID
                        var loginId = loginResult.insertId;
                        console.log(loginId);

                        // Create query for inserting into user table
                        var userSqlQuery = "INSERT INTO student(login_id, student_name) VALUES (?, ?)";

                        // Call database to insert into user table
                        db.query(userSqlQuery, [loginId, student_name], function (error, userResult) {
                            if (error) {
                                res.send(JSON.stringify({ success: false, message: error }));
                            } else {
                                // Registration successful
                                res.send(JSON.stringify({ success: true, message: 'register' }));
                            }
                        });
                    }
                });
            }
        }
    });
});


router.route('/login').post((req,res)=>{
    console.log(req.body);
    var student_email=req.body.student_email;
    var student_password=req.body.student_password;

    var sql="SELECT * FROM login WHERE email=? AND password=?";
    
    if(student_email != "" && student_password !=""){
        db.query(sql,[student_email,student_password],function(err,data,fields){
            if(err){
                res.send(JSON.stringify({success:false,message:err}));

            }else{
                if(data.length > 0)
                {
                    res.send(JSON.stringify({success:true,user:data}));
                }else{
                    res.send(JSON.stringify({success:false,message:'Empty Data'}));
                }
            }
        });
    }else{
        res.send(JSON.stringify({success:false,message:'Email and password required!'}));
    }

});


router.route('/premiumhostels').get((req, res) => {
    const query = 'SELECT * FROM hostels WHERE Category = "premium";';
  
    db.query(query, (err, result) => {
      if (err) {
        console.error('Error fetching data:', err);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
  
      res.status(200).json(result);
    });
  });



  router.route('/ratedhostels').get((req, res) => {
    const query = 'SELECT * FROM hostels WHERE Category = "rated";';
  
    db.query(query, (err, result) => {
      if (err) {
        console.error('Error fetching data:', err);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
    //   const hostelIds = result.map(hostel => hostel.id);

    //     res.status(200).json({ hostelIds })
  
      res.status(200).json(result);
    });
  });

  router.route('/reservation').post((req, res) => {
    console.log(req.body);
    //const { Hostel_id, reservation_name, reservation_email, reservation_phone, type } = req.body;
    const Hostel_id = req.body.Hostel_id;
    const reservation_name = req.body.reservation_name;
    const reservation_email = req.body.reservation_email;
    const reservation_phone = req.body.reservation_phone;
    const type = req.body.type;
    const sql = 'INSERT INTO reservations (Hostel_id, name, email, ph_no, type) VALUES (?, ?, ?, ?, ?)';
    const values = [Hostel_id, reservation_name, reservation_email, reservation_phone, type];
    db.query(sql, values, (error, result) => {
        if (error) {
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            // Registration successful
            res.send(JSON.stringify({ success: true, message: 'Reservation Successfuly' }));
        }
    });
    //   if (err) {
    //     console.error('Error storing reservation data:', err);
    //     res.status(500).json({ error: 'An error occurred while storing reservation data' });
    //     return;
    //   }
    //   console.log('Reservation data stored successfully');
    //   res.status(200).json({ message: 'Reservation data stored successfully' });
    // });
  });



module.exports =router;