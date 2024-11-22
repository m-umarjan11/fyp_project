const mongoose = require('mongoose');

const itemBorrowedSchema = new mongoose.Schema({
  itemId: { type: String, required: true },
  userId: { type: String, required: true },
  borrowDate: { type: Date, required: true },
  returnDate: { type: Date },
});

module.exports = mongoose.model('ItemBorrowed', itemBorrowedSchema);
