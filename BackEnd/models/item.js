const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.ObjectId, ref:'User', required: true },
  itemName: { type: String, required: true },
  description: { type: String, required: false, },
  images: { type: [String], required:false},
  rating: { type: Number, required:false},
  sales: { type: Number, required:false},
  location: {
    type: { type: String, default: "Point" },
    coordinates: { type: [Number], required: false, default: [0, 0] },
  },
}, {
  timestamps: true
});


itemSchema.index({ userId: 1, location: '2dsphere' });


module.exports = mongoose.model('Item', itemSchema);
