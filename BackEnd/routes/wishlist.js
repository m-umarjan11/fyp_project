
const express = require('express');
const { createWishlist, getWishlist, updateWishlist, deleteWishlist } = require('../controllers/wishlistController');

const router = express.Router();


router.post('/wishlist', createWishlist);


router.get('/wishlist/:userId', getWishlist);


router.put('/wishlist/:userId', updateWishlist);


router.delete('/wishlist/:userId', deleteWishlist);

module.exports = router;
