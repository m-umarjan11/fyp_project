const express = require('express');
const router = express.Router();
const userReviewsController = require('../controllers/userReview');

router.get('/', userReviewsController.getAllReviews);
router.get('/:ownerId', userReviewsController.getReviewsByOwnerId);
router.post('/', userReviewsController.addReview);
router.delete('/:id', userReviewsController.deleteReview);

module.exports = router;
