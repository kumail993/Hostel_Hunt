const express = require('express');
const router = express.Router();
const db = require('./db.js');
const phpUnserialize = require('php-unserialize');

router.route('/webreservations/:loginId').get(async (req, res) => {
  var loginId = req.params.loginId;


  if (loginId.startsWith(':')) {
    loginId = loginId.substring(1); // Remove the first character (the colon)
  }


  const query = 'SELECT meta FROM wp_houzez_crm_activities WHERE login_id = ?';
 
  db.query(query, [loginId], (err, results) => {
    if (err) {
      console.error('Error executing query: ' + err.stack);
      res.status(500).json({ error: 'Internal Server Error' });
      return;
    }
  
    if (results.length === 0) {
      res.status(404).json({ error: 'Data not found' });
      return;
    }
  
    const serializedDataArray = results.map((row) => row.meta);
  
    // Deserialize the PHP-serialized data for each row
    try {
      const deserializedDataArray = serializedDataArray.map((serializedData) =>
        phpUnserialize.unserialize(serializedData)
      );
      
      res.json(deserializedDataArray);
    } catch (error) {
      console.error('Error deserializing data: ' + error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  

});

module.exports = router;



