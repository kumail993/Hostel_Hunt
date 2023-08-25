
const express=require('express');
const router=express.Router();
var db=require('./db.js');
//const url = require('url');
const app = express();

router.route('/reservation').post((req, res) => {
    console.log(req.body);
    //const { Hostel_id, reservation_name, reservation_email, reservation_phone, type } = req.body;

    //const parsedUrl = url.parse(req.url, true)

    //if(parsedUrl.pathname = '/login'){
    const Hostel_id = req.body.Hostel_id;
    const reservation_name = req.body.reservation_name;
    const reservation_email = req.body.reservation_email;
    const reservation_phone = req.body.reservation_phone;
    const type = req.body.type;
    const login = req.body.login_id;
    const sql = 'INSERT INTO reservations ( name, email, ph_no, type, created_at,Hostel_id, login_id) VALUES (?, ?, ?, ?,NOW(),?,?)';
    const values = [ reservation_name, reservation_email, reservation_phone, type,Hostel_id,login];
    db.query(sql, values, (error, result) => {
        if (error) {
            res.send(JSON.stringify({ success: false, message: error }));
        } else {
            // Registration successful
            res.send(JSON.stringify({ success: true, message: 'Reservation Successfuly' }));
        }
    });
    
  });



module.exports =router;