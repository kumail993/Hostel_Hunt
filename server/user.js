const express=require('express');
const router=express.Router();
var db=require('./db.js');




router.route('/register').post((req, res) => {
    // Get params
    var student_name = req.body.student_name;
    var email = req.body.email;
    var student_number = req.body.student_number;
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
                // Create query for inserting into login table
                var loginSqlQuery = "INSERT INTO login(email, password) VALUES (?, ?)";

                // Call database to insert into login table
                db.query(loginSqlQuery, [email, password], function (error, loginResult, fields) {
                    if (error) {
                        res.send(JSON.stringify({ success: false, message: error }));
                    } else {
                        // Insert successful, now get the login ID
                        var loginId = loginResult.insertId;

                        // Create query for inserting into user table
                        var userSqlQuery = "INSERT INTO student(login_id, student_name, student_number) VALUES (?, ?, ?)";

                        // Call database to insert into user table
                        db.query(userSqlQuery, [loginId, student_name, student_number], function (error, userResult) {
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





// router.route('/register').post((req, res) => {
//     // Get params
//     var student_name = req.body.student_name;
//     var email = req.body.email;
//     var student_number = req.body.student_number;
//     var password = req.body.password;
  
//     // Create query for inserting into login table
//     var loginSqlQuery = "INSERT INTO login(email,password) VALUES (?,?)";
  
//     // Call database to insert into login table
//     db.query(loginSqlQuery, [email,password], function (error, loginResult,fields,) {
//       if (error) {
//         res.send(JSON.stringify({ success: false, message: error }));
//       } else {
//         // Insert successful, now get the login ID
//         var loginId = loginResult.insertId;
        
//         //Create query for inserting into user table
//         var userSqlQuery = "INSERT INTO student(login_id, student_name, student_number) VALUES (?, ?, ?)";
  
//         // Call database to insert into user table
//         db.query(userSqlQuery, [loginId, student_name, student_number], function (error, userResult) {
//           if (error) {
//             res.send(JSON.stringify({ success: false, message: error }));
//           } else {
//             // Registration successful
//             res.send(JSON.stringify({ success: true, message: 'register' }));
//           }
//         });
//       }
//     });
//   });

router.route('/login').post((req,res)=>{

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

module.exports =router;