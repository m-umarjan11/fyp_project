
const Wishlist = require('./../models/wishList');

exports.createWishlist = async (req, res) => {
  try {
    const wishlist = new Wishlist(req.body);
    await wishlist.save();
    res.status(201).send(wishlist);
  } catch (error) {
    res.status(400).send(error);
  }
};

exports.getWishlist = async (req, res) => {
  try {
    const wishlist = await Wishlist.findOne({ userId: req.params.userId }).populate('items.itemId');
    if (!wishlist) return res.status(404).send('Wishlist not found');
    res.send(wishlist);
  } catch (error) {
    res.status(500).send(error);
  }
};

exports.updateWishlist = async (req, res) => {
  try {
    const wishlist = await Wishlist.findOneAndUpdate(
      { userId: req.params.userId },
      { $set: req.body },
      { new: true }
    ).populate('items.itemId');
    
    if (!wishlist) return res.status(404).send('Wishlist not found');
    res.send(wishlist);
  } catch (error) {
    res.status(400).send(error);
  }
};

exports.deleteWishlist = async (req, res) => {
  try {
    const wishlist = await Wishlist.findOneAndDelete({ userId: req.params.userId });
    if (!wishlist) return res.status(404).send('Wishlist not found');
    res.send({ message: 'Wishlist deleted successfully' });
  } catch (error) {
    res.status(500).send(error);
  }
};
