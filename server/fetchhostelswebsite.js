const express = require('express');
const router = express.Router();
const db = require('./db.js');

// Promisify the database query function
const queryAsync = (sql, values) => {
  return new Promise((resolve, reject) => {
    db.query(sql, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results);
      }
    });
  });
};

router.route('/hostelsfromweb').get(async (req, res) => {
  try {
    // Fetch data from wp_posts
    const query = 'SELECT ID, post_content,post_title, post_type, post_name, post_parent FROM wp_posts WHERE post_type = "property" AND post_status = "publish" AND ID > 18212;';
    const posts = await queryAsync(query);

    // Extract post IDs
    const postIds = posts.map(row => row.ID);

    // Fetch data from wp_postmeta for matching post_ids with meta_key 'fave_property_price'
    const postmetaQuery = `
  SELECT pm.*
  FROM wp_postmeta pm
  WHERE pm.post_id IN (${postIds.join(',')})
  AND (pm.meta_key = 'fave_property_price' OR pm.meta_key = 'fave_property_map_address' OR pm.meta_key = 'fave_property_bathrooms' OR pm.meta_key = 'fave_property_bedrooms');
`;
    const postmetaResult = await queryAsync(postmetaQuery);

    // Create a map to store the combined data
    const combinedDataMap = new Map();

    // Populate the map with post data and associated meta data
    posts.forEach(post => {
      const matchingPostmeta = postmetaResult.filter(meta => meta.post_id === post.ID);
      combinedDataMap.set(post.ID, { ...post, postmeta: matchingPostmeta });
    });

    res.status(200).json(Array.from(combinedDataMap.values()));
  } catch (err) {
    console.error('Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// router.route('/hostelsfromweb').get(async (req, res) => {
//   try {
//     // Fetch data from wp_posts
//     const query = 'SELECT ID, post_title, post_type, post_name, post_parent FROM wp_posts WHERE post_status = "publish" AND ID > 18212;';
//     const posts = await queryAsync(query);

//     // Extract post IDs
//     const postIds = posts.map(row => row.ID);

//     // Fetch data from wp_postmeta for matching post_ids with meta_key 'fave_property_price'
//     const postmetaQuery = `
//       SELECT pm.*
//       FROM wp_postmeta pm
//       WHERE pm.post_id IN (${postIds.join(',')})
//       AND pm.meta_key = 'fave_property_price';
//     `;
//     const postmetaResult = await queryAsync(postmetaQuery);

//     // Combine the wp_posts and wp_postmeta data into a single response
//     const combinedData = posts.map(post => {
//       const matchingPostmeta = postmetaResult.filter(meta => meta.post_id === post.ID);
//       return { ...post, postmeta: matchingPostmeta };
//     });

//     res.status(200).json(combinedData);
//   } catch (err) {
//     console.error('Error:', err);
//     res.status(500).json({ error: 'Internal Server Error' });
//   }
// });


module.exports = router;
