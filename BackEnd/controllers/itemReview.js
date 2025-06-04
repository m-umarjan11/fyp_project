const ItemReviews = require('../models/itemReview');
const User = require("../models/user");
const Item = require("../models/item");
const {orderPlaced} = require('../middleware/fcmService');


const handleError = (res, error, statusCode = 500, message = "Internal Server Error") => {
  res.status(statusCode).json({
    code: statusCode,
    message: message,
    details: error.message || error,
  });
};

exports.getAllReviews = async (req, res) => {
  try {
    const reviews = await ItemReviews.find({ itemId: req.params.itemId });
    res.status(200).json(reviews);
  } catch (error) {
    handleError(res, error, 500, "Failed to retrieve all reviews");
  }
};

exports.getReviewsByItemId = async (req, res) => {
  try {
    const setNo = parseInt(req.query.setNo) || 0; // 0 = first page, 1 = second, etc.
    const pageSize = 5;
// //console.log("setNo: ", req.query.setNo)
    const reviews = await ItemReviews.find({ itemId: req.query.itemId }).skip(setNo*pageSize).limit(pageSize);
    const users = await User.find({ userId: { $in: reviews.map(review => review.userId) } })
    const enrichedReviews = reviews.map((review, i) => ({
      ...review._doc,
      renterName: users[i]?.userName || '',
      renterPicture: users[i]?.picture || ''
    }));
    // //console.log("Enriched Reviews: ", enrichedReviews);
    const isLastPage = reviews.length < pageSize;
    // print(isLastPage) 

    res.status(200).json({ enrichedReviews,  isLastPage });
  } catch (error) {
    handleError(res, error, 500, "Failed to retrieve reviews for the item");
  }
};

exports.addReview = async (req, res) => {
  try {
    // Create and save the new review
    const review = new ItemReviews(req.body);
    const savedReview = await review.save();

    // Get the item to update
    const item = await Item.findById(req.body.itemId);
    if (!item) {
      return res.status(404).json({ message: "Item not found" });
    }
    orderPlaced(item, `Your item ${item.itemName}has been reviewed`, "Item Reviewed");
  // Increment review count
const newReviewCount = (item.reviews || 0) + 1;

// Update total rating sum
const newTotalRatingSum = (item.totalRatingSum || 0) + review.personRating;

// Calculate new average
const newAverageRating = newTotalRatingSum / newReviewCount;

    // Update the item with new review count, total rating sum, and average rating
    // //console.log("New Average Rating: ", newAverageRating)
    await Item.findByIdAndUpdate(req.body.itemId, {
      $set: {
        reviews: newReviewCount,
        ratings: newAverageRating,
      },
    });

    res.status(201).json(savedReview);
  } catch (error) {
    handleError(res, error, 500, "Failed to add review");
  }
};

exports.deleteReview = async (req, res) => {
  try {
    const review = await ItemReviews.findByIdAndDelete(req.params.id);
    if (!review) return handleError(res, "Review not found", 404);

    res.status(200).json({ message: "Review deleted successfully" });
  } catch (error) {
    handleError(res, error, 500, "Failed to delete review");
  }
};
