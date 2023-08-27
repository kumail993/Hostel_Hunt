const express = require('express');
const router = express.Router();
var db = require('./db.js');

const app = express();

router.route('/ReservationList').get((req, res) => {
  console.log(req.body);
  var loginId = req.query.LoginId; // Use req.query to get URL parameters
  const query = 'SELECT * FROM reservations WHERE login_id = ?';
  
  db.query(query, [loginId], (err, reservations) => {
    if (err) {
      console.error('Error fetching reservation data:', err);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
    
    if (reservations.length === 0) {
      res.status(404).json({ message: 'No reservations found for the provided LoginId' });
      return;
    }
    
    const hostelId = reservations[0].hostel_id; // Assuming the reservations have a hostel_id column
    const hostelQuery = 'SELECT * FROM hostels WHERE id = ?';
    
    db.query(hostelQuery, [hostelId], (err, hostelDetails) => {
      if (err) {
        console.error('Error fetching hostel details:', err);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
      
      if (hostelDetails.length === 0) {
        res.status(404).json({ message: 'Hostel details not found for the provided HostelId' });
        return;
      }
      
      const response = {
        reservations: reservations,
        hostelDetails: hostelDetails[0] // Assuming the query returns a single hostel
      };
      
      res.status(200).json(response);
    });
  });
});

module.exports = router;
