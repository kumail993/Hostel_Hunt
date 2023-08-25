const express=require('express');
const router=express.Router();
var db=require('./db.js');
//const session = require('express-session');
const app = express();
require('dotenv').config();



// app.use(
//     session({
//       secret: 'whysoserious',
//       resave: false,
//       saveUninitialized: true,

//     })
//   );


router.route('/login').post((req,res,next)=>{
    console.log(req.body);
    var student_email=req.body.student_email;
    var student_password=req.body.student_password;

    var sql="SELECT * FROM login WHERE email=? AND password=?";
    
    if(student_email != "" && student_password !=""){
        db.query(sql,[student_email,student_password],function(err,data,fields){
            if(err){
                console.log(err);
                res.send(JSON.stringify({success:false,message:err}));

            }else{
                const login_id = data[0].login_id;
                if(data.length > 0)
                {
                     
                    res.send(JSON.stringify({success:true,user:data}));
                    console.log(login_id);
                    //console.log(res.login_id);
                    //res.locals.login_id = login_id;
                     //res.send({ login_id });
                    next();
                    
                }else{
                    console.log(err);
                    res.send(JSON.stringify({success:false,message:'Empty Data'}));
                    
                }
            }
        });
    }else{
        
        res.send(JSON.stringify({success:false,message:'Email and password required!'}));
    }
    //res.redirect('./userdata');
    
});


// router.route('/userdata').get((req, res, ) => {

//     //const id = res.loacals.login_id

//     const query = 'SELECT * FROM student WHERE login_id = ?';
//     db.query(query,[id], (err, result) => {
//       if (err) {
//         console.error('Error fetching data:', err);
//         res.status(500).json({ error: 'Internal Server Error' });
//         return;
//       }
//       console.log(id);
//       res.status(200).json(result);
//     });
//   });


module.exports =router;