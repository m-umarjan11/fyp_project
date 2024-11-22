const ItemReviews = require('../models/itemReview');


exports.getAllReviews = async (req, res) => {
  try {
    const reviews = await ItemReviews.find();
    res.status(200).json(reviews);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.getReviewsByItemId = async (req, res) => {
  try {
    const reviews = await ItemReviews.find({ itemId: req.params.itemId });
    res.status(200).json(reviews);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.addReview = async (req, res) => {
  try {
    const review = new ItemReviews(req.body);
    const savedReview = await review.save();
    res.status(201).json(savedReview);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.deleteReview = async (req, res) => {
  try {
    const review = await ItemReviews.findByIdAndDelete(req.params.id);
    if (!review) return res.status(404).json({ message: 'Review not found' });
    res.status(200).json({ message: 'Review deleted' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
