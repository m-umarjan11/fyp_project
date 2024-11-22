const UserReviews = require('../models/userReview');


exports.getAllReviews = async (req, res) => {
  try {
    const reviews = await UserReviews.find();
    res.status(200).json(reviews);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.getReviewsByOwnerId = async (req, res) => {
  try {
    const reviews = await UserReviews.find({ ownerId: req.params.ownerId });
    res.status(200).json(reviews);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.addReview = async (req, res) => {
  try {
    const review = new UserReviews(req.body);
    const savedReview = await review.save();
    res.status(201).json(savedReview);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.deleteReview = async (req, res) => {
  try {
    const review = await UserReviews.findByIdAndDelete(req.params.id);
    if (!review) return res.status(404).json({ message: 'Review not found' });
    res.status(200).json({ message: 'Review deleted' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
