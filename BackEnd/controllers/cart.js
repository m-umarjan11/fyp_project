const Cart = require('./../models/cart');

exports.createCart = async (req, res) => {
  try {
    const cart = new Cart(req.body);
    await cart.save();
    res.status(201).send(cart);
  } catch (error) {
    res.status(400).send(error);
  }
};

exports.getCart = async (req, res) => {
  try {
    const cart = await Cart.findOne({ userId: req.params.userId }).populate('items.itemId');
    if (!cart) return res.status(404).send('Cart not found');
    res.send(cart);
  } catch (error) {
    res.status(500).send(error);
  }
};

exports.updateCart = async (req, res) => {
  try {
    const cart = await Cart.findOneAndUpdate(
      { userId: req.params.userId },
      { $set: req.body },
      { new: true }
    ).populate('items.itemId');
    
    if (!cart) return res.status(404).send('Cart not found');
    res.send(cart);
  } catch (error) {
    res.status(400).send(error);
  }
};

exports.deleteCart = async (req, res) => {
  try {
    const cart = await Cart.findOneAndDelete({ userId: req.params.userId });
    if (!cart) return res.status(404).send('Cart not found');
    res.send({ message: 'Cart deleted successfully' });
  } catch (error) {
    res.status(500).send(error);
  }
};
