
const express=require('express');
const app=express();
var bodyParser=require('body-parser');
var db=require('./db.js')

app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}));

const RegisterRouter=require('./Register');
const LoginRouter = require('./login');
const HostelFetchRouter = require('./hostel_fetch');
const ReservationRouter = require('./reservation');
const otpverificationRouter = require('./OTP_verification');
const reservationlistRouter = require('./reservation_list');
const RentRouter = require('./fetchrent');
const ResendOTPRouter = require('./resendOtp.js');
const UserloginRouter = require('./loginuser.js');
const RegisterfromwebRouter = require('./registeruser.js');
const hostelsfromwebRouter = require('./fetchhostelswebsite.js');
const OTPverificationweb = require('./OTP_verification_web.js');
const webreservationRouter = require('./web_reservation.js');
const web_reservation_list = require('./web_reservation_list.js');


app.use('/Hostel-hunt',RegisterRouter);
app.use('/Hostel-hunt',LoginRouter);
app.use('/Hostel-hunt', HostelFetchRouter);
app.use('/Hostel-hunt',ReservationRouter);
app.use('/Hostel-hunt',otpverificationRouter);
app.use('/Hostel-hunt',reservationlistRouter);
app.use('/Hostel-hunt',RentRouter);
app.use('/Hostel-hunt',ResendOTPRouter);
app.use('/Hostel-hunt',UserloginRouter);
app.use('/Hostel-hunt',RegisterfromwebRouter);
app.use('/Hostel-hunt',hostelsfromwebRouter);
app.use('/Hostel-hunt',OTPverificationweb);
app.use('/Hostel-hunt',webreservationRouter);
app.use('/Hostel-hunt',web_reservation_list);


app.listen(3000,()=> console.log('your server is running on port 3000'))

