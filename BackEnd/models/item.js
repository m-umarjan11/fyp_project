const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  userId: { type: String, required: true },
  itemName: { type: String, required: true },
  itemDescription: { type: String },
  itemImages: { type: [String] },
  itemPrice: { type: Number, default: 0 },
});

module.exports = mongoose.model('Item', itemSchema);
