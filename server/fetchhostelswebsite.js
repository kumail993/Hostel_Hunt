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
    const query = 'SELECT ID, post_content, post_title, post_type, post_name, post_parent FROM wp_posts WHERE post_type = "property" AND post_status = "publish" AND ID > 18212;';
    const posts = await queryAsync(query);

    // Extract post IDs
    const postIds = posts.map(row => row.ID);

    // Fetch data from wp_postmeta for matching post_ids with meta_key 'fave_property_price'
    const postmetaQuery = `
      SELECT pm.*
      FROM wp_postmeta pm
      WHERE pm.post_id IN (${postIds.join(',')})
      AND (pm.meta_key = 'fave_property_price' OR pm.meta_key = 'fave_property_map_address' OR pm.meta_key = 'fave_property_bathrooms' OR pm.meta_key = 'fave_property_bedrooms' OR pm.meta_key = 'fave_property_images' OR pm.meta_key = 'fave_agents');
    `;
    const postmetaResult = await queryAsync(postmetaQuery);

    // Create a map to store the combined data
    const combinedDataMap = new Map();

    // Populate the map with post data and associated meta data
    posts.forEach(post => {
      const matchingPostmeta = postmetaResult.filter(meta => meta.post_id === post.ID);
      combinedDataMap.set(post.ID, { ...post, postmeta: matchingPostmeta });
    });

    // Create an object to store images grouped by post ID
    const imagesByPostId = {};

    // Iterate through the combined data map
    for (const [postId, combinedData] of combinedDataMap.entries()) {
      // Check if postmeta contains 'fave_property_images'
      const imagesMeta = combinedData.postmeta.find(meta => meta.meta_key === 'fave_property_images');

      if (imagesMeta) {
        // Extract the meta_value (assuming it's a comma-separated list of IDs)
        const imageIds = imagesMeta.meta_value.split(',');
        const imageGuids = [];

        // Fetch the 'guid' from 'wp_post' for each 'ID' in 'imageIds'
        for (const imageId of imageIds) {
          const imageQuery = `SELECT guid FROM wp_posts WHERE ID = ${imageId}`;
          const imageResult = await queryAsync(imageQuery);
          if (imageResult.length > 0) {
            imageGuids.push(imageResult[0].guid);
          }
        }

        // Store image GUIDs in the object, grouped by post ID
        imagesByPostId[postId] = imageGuids;
      }
    }

    // Add the imageGuids object to the combined data for each post
    for (const [postId, combinedData] of combinedDataMap.entries()) {
      if (imagesByPostId[postId]) {
        combinedData.imageGuids = imagesByPostId[postId];
      }
    }

    res.status(200).json(Array.from(combinedDataMap.values()));
  } catch (err) {
    console.error('Error:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// ... (Your other routes and server setup code)

// Export the router
module.exports = router;
