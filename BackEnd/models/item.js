const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.ObjectId, ref:'User', required: true },
  itemName: { type: String, required: true },
  description: { type: String, required: true, },
  images: { type: [String], required:true},
  location: { 
    type: { type: String, default: 'Point' }, 
    coordinates: { type: [Number], required: true } 
  }
}, {
  timestamps: true
});


itemSchema.index({ userId: 1, location: '2dsphere' });


module.exports = mongoose.model('Item', itemSchema);
