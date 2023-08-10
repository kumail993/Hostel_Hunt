const express=require('express');
const router=express.Router();
var db=require('./db.js');
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");

const app = express();

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

module.exports =router;