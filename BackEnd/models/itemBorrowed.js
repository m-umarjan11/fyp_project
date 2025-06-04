const mongoose = require('mongoose');

const itemBorrowedSchema = new mongoose.Schema({
  itemId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Item',
    required: true
  },
  borrowerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  lenderId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  paymentMethod: { type: String, required: true },
  requestStatus: {
    type: String, required: true
  },
  borrowDate: { type: Date, required: true },
  returnDate: { type: Date },
  sellerAccountId: {
    type: String,
    default: null,
    required: false
  },
});

// requestStatus can be 'pending', 'accepted', 'rejected', 'completed', 'returning', 'returned'

module.exports = mongoose.model('ItemBorrowed', itemBorrowedSchema);
