const mongoose = require('mongoose');

const itemReviewsSchema = new mongoose.Schema({
  itemId: { type: String, required: true }, 
  renterId: { type: String, required: true }, 
  review: { type: String, required: true },
});

module.exports = mongoose.model('ItemReviews', itemReviewsSchema);
