const User = require('../models/user');


exports.createUser = async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(201).send(user);
  } catch (error) {
    res.status(400).send(error);
  }
};


exports.getUser = async (req, res) => {
  try {
    const user = await User.findOne({ userId: req.params.userId });
    if (!user) return res.status(404).send('User not found');
    res.send(user);
  } catch (error) {
    res.status(500).send(error);
  }
};


exports.updateUser = async (req, res) => {
  try {
    const user = await User.findOneAndUpdate(
      { userId: req.params.userId },
      req.body,
      { new: true }
    );
    if (!user) return res.status(404).send('User not found');
    res.send(user);
  } catch (error) {
    res.status(400).send(error);
  }
};


exports.deleteUser = async (req, res) => {
  try {
    const user = await User.findOneAndDelete({ userId: req.params.userId });
    if (!user) return res.status(404).send('User not found');
    res.send({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).send(error);
  }
};
