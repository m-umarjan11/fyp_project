const express = require('express');
const router = express.Router();
const itemReviewsController = require('../controllers/itemReview');

router.get('/', itemReviewsController.getAllReviews);
router.get('/query', itemReviewsController.getReviewsByItemId);
router.post('/', itemReviewsController.addReview);
router.delete('/:id', itemReviewsController.deleteReview);

module.exports = router;
