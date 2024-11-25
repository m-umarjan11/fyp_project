
const express = require('express');
const { createCart, getCart, updateCart, deleteCart } = require('../controllers/cartController');

const router = express.Router();


router.post('/cart', createCart);


router.get('/cart/:userId', getCart);


router.put('/cart/:userId', updateCart);


router.delete('/cart/:userId', deleteCart);

module.exports = router;
