const mongoose = require('mongoose');

const userReviewsSchema = new mongoose.Schema({
  renterId: { type: String, required: true }, //userId
  ownerId: { type: String, required: true }, //userId
  review: { type: String, required: true },
});

module.exports = mongoose.model('UserReviews', userReviewsSchema);
