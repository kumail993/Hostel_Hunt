const express = require('express');
const router = express.Router();
const db = require('./db.js');
const nodemailer = require("nodemailer");

router.route('/webreservation').post((req, res) => {
    console.log(req.body);
    const Hostel_id = req.body.Hostel_id;
    const login_id =  req.body.login_id
    const enquiry_to = req.body.enquiry_to;
    const reservation_name = req.body.reservation_name;
    const reservation_email = req.body.reservation_email;
    const reservation_phone = req.body.reservation_phone;
    //const currentTimestamp = Date.now();
    const type = req.body.type + ' Seater';
    const acticity_type = "lead";
    const user_type = "agent_info"
    const message = "Hello, I am Looking For Reservation"
    const source_link = "https://hostel-hunt.com/property/zostel-inn-hostel/"
    const currentDate = new Date();
    //console.log(currentDate.toLocaleString('en-US', { timeZone: 'Asia/Karachi' }));


    //const serializedData = `a:7:{s:4:"type";s:4:"${type}";s:4:"name";s:${reservation_name.length}:"${reservation_name}";s:5:"email";s:${reservation_email.length}:"${reservation_email}";s:5:"phone";s:${reservation_phone.length}:"${reservation_phone}";s:9:"user_type";s:${type.length}:"${type}";s:10:"listing_id";i:${Hostel_id};}`;
    const serializedData = `a:7:{s:4:"type";s:4:"${acticity_type}";s:4:"name";s:${reservation_name.length}:"${reservation_name}";s:5:"email";s:${reservation_email.length}:"${reservation_email}";s:5:"phone";s:${reservation_phone.length}:"${reservation_phone}";s:9:"user_type";s:${type.length}:"${type}";s:7:"message";s:${message.length}:"${message}";s:10:"listing_id";i:${Hostel_id};}`;
    // First, retrieve user_id from wp_houzez_crm_enquiries table where listing_id = Hostel_id
    const selectQuery = 'SELECT user_id FROM wp_houzez_crm_enquiries WHERE listing_id = ?';

    db.query(selectQuery, [Hostel_id], (selectError, selectResults) => {
        if (selectError) {
            res.send(JSON.stringify({ success: false, message: selectError }));
        } else if (selectResults.length === 0) {
            res.send(JSON.stringify({ success: false, message: 'No data found for the provided Hostel_id' }));
        } else {
            const user_id = selectResults[0].user_id;

            // Insert data into wp_houzez_crm_leads table
            const insertLeadQuery = 'INSERT INTO wp_houzez_crm_leads (user_id, display_name, email, mobile, type, enquiry_to,enquiry_user_type,source_link,time) VALUES (?, ?, ?, ?, ?, ?,?,?,NOW())';
            const leadValues = [user_id, reservation_name, reservation_email, reservation_phone, type, enquiry_to,user_type,source_link];

            db.query(insertLeadQuery, leadValues, (insertLeadError, insertLeadResult) => {
                if (insertLeadError) {
                    res.send(JSON.stringify({ success: false, message: insertLeadError }));
                } else {
                    // Insertion into wp_houzez_crm_leads successful

                    // Retrieve lead_id from the last inserted row
                    const lead_id = insertLeadResult.insertId;

                    // Insert data into wp_houzez_crm_enquiries table
                    const insertEnquiryQuery = 'INSERT INTO wp_houzez_crm_enquiries (lead_id, user_id, listing_id, enquiry_to,enquiry_user_type,time) VALUES (?, ?, ?, ?,?,NOW())';
                    const enquiryValues = [lead_id, user_id, Hostel_id, enquiry_to,user_type];

                    db.query(insertEnquiryQuery, enquiryValues, (insertEnquiryError, insertEnquiryResult) => {
                        if (insertEnquiryError) {
                            res.send(JSON.stringify({ success: false, message: insertEnquiryError }));
                        } else {
                            // Registration and insertion successful
                            
                            const activityInsertQuery = 'INSERT INTO wp_houzez_crm_activities (user_id, meta,time,login_id) VALUES (?, ?,?,?)';
                            const activityValues = [user_id, serializedData,currentDate,login_id];
        
                            db.query(activityInsertQuery, activityValues, (activityInsertError, activityInsertResult) => {
                                if (activityInsertError) {
                                    res.send(JSON.stringify({ success: false, message: activityInsertError }));
                                } else {
                                    // Registration and insertion successful
        
                                    
                            res.send(JSON.stringify({ success: true, message: 'Reservation Done Successful' }));

                            const transporter = nodemailer.createTransport({
                                service: "Gmail", // Use your email service here (e.g., "Gmail", "Outlook")
                                auth: {
                                user: "khaider308@gmail.com",
                                pass: "epjudfftrtdmaukc",
                                },
                            });
                
                            const mailOptions = {
                                from: "Khaider308@gmail.com",
                                to: reservation_email, // Recipient's email
                                subject: "Your Hostel-hunt Reservation Has Been Done",
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
                                    text-align: left;
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
                                  <div class="header">Reservation Email</div>
                                  <div class="info">
                                    Hello, ${reservation_name}!<br>
                                    We are thrilled to inform you that your reservation has been successfully confirmed. We appreciate your choice to book with us and look forward to providing you with an exceptional experience..
                                  </div>
                                  <div class="info">
                                     Name: ${reservation_name}<br>
                                     Email: ${reservation_email}<br>
                                     Phone No: ${reservation_phone}<br>
                                     Room type: ${type}
                                    
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
                                console.log("Error sending OTP:", error);
                                } else {
                                console.log("OTP email sent:", info.response);
                                }
                            });
                
                                }
                            });

                            

                        }
                    });
                }
            });
        }
    });
});

module.exports = router;




// const express = require('express');
// const router = express.Router();
// var db = require('./db.js');
// const nodemailer = require("nodemailer");

// const app = express();

// router.route('/webreservation').post((req, res) => {
//     console.log(req.body);
//     const Hostel_id = req.body.Hostel_id;
//     const reservation_name = req.body.reservation_name;
//     const reservation_email = req.body.reservation_email;
//     const reservation_phone = req.body.reservation_phone;
//     const type = req.body.type;

//     const serializedData = JSON.stringify({
//         type: 'lead',
//         name: req.body.reservation_name,
//         email: req.body.reservation_email,
//         phone: req.body.reservation_phone,
//         //user_type: req.body.type,
//         //message: req.body.message,
//         listing_id: req.body.Hostel_id,
//     });
//     //const login = req.body.login_id;

//     // First, retrieve data from wp_houzez_crm_enquiries table
//     const selectQuery = 'SELECT user_id,enquiry_to FROM wp_houzez_crm_enquiries WHERE listing_id = ?';

//     db.query(selectQuery, [Hostel_id], (selectError, selectResults) => {
//         if (selectError) {
//             res.send(JSON.stringify({ success: false, message: selectError }));
//         } else if (selectResults.length === 0) {
//             res.send(JSON.stringify({ success: false, message: 'No data found for the provided Hostel_id' }));
//         } else {
//             var enquiry_to = selectResults[0].enquiry_to;
//             var user_id = selectResults[0].user_id;
//             console.log(enquiry_to);
//             console.log(user_id);

//             // Now, insert data into wp_houzez_crm_leads table
//             const insertQuery = 'INSERT INTO wp_houzez_crm_leads (user_id, display_name, email, mobile, type, enquiry_to) VALUES (?, ?, ?, ?, ?, ?)';
//             const values = [user_id, reservation_name, reservation_email, reservation_phone, type, enquiry_to];

//             db.query(insertQuery, values, (insertError, insertResult) => {
//                 if (insertError) {
//                     res.send(JSON.stringify({ success: false, message: insertError }));
//                 } else {
//                     // Registration and insertion successful

//                     const transporter = nodemailer.createTransport({
//                         service: "Gmail", // Use your email service here (e.g., "Gmail", "Outlook")
//                         auth: {
//                             user: "khaider308@gmail.com",
//                             pass: "epjudfftrtdmaukc",
//                         },
//                     });

//                     // Rest of your email sending code goes here...

//                     res.send(JSON.stringify({ success: true, message: 'Reservation and data insertion Successful' }));
//                 }
//             });
//         }
//     });
// });

// module.exports = router;
