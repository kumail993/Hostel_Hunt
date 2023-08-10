const express=require('express');
const router=express.Router();
var db=require('./db.js');

const app = express();

router.route('/ReservationList').get((req, res) => {
    const query = 'SELECT * FROM reservations WHERE login_id = ?';
    db.query(query,[LoginId], (err, result) => {
      if (err) {
        console.error('Error fetching data:', err);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
  
      res.status(200).json(result);
    });
  });