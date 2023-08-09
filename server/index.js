
const express=require('express');
const app=express();
var bodyParser=require('body-parser');
var db=require('./db.js')
//const userController = require('./controllers/registration');
//const hostelController = require('./controllers/HostelController')

app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}));
const userRouter=require('./user');
//const RegisterRouter=require('./Register');
app.use('/Hostel-hunt',userRouter);

app.listen(3000,()=> console.log('your server is running on port 3000'))
