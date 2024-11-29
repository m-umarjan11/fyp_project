const User = require("../models/user");

exports.createUser = async (req, res) => {
  console.log("Creating User");
  try {
    const user = new User({
      'userName': req.body["userName"],
      'email': req.body["email"],
      'password': req.body["password"],
      'picture': req.body["picture"],
      'personReputation': req.body["personReputation"],
      'location': req.body["location"],
    });
    await user.save();
    res.status(201).json(user.toObject());
  } catch (error) {
    console.log(error);
    res.status(400).send(error);
  }
};

exports.getUser = async (req, res) => {
  try {
    // Find user by userId
    const user = await User.findOne({ userId: req.params.userId });
    if (!user) return res.status(404).send("User not found");
    res.send(user); // Sends the user object which includes the location
  } catch (error) {
    res.status(500).send(error);
  }
};

exports.updateUser = async (req, res) => {
  try {
    // Ensure that location is included in the update if needed
    const updateData = req.body;

    // Check if location is in the body and update it
    if (req.body.location) {
      updateData.location = req.body.location;
    }

    const user = await User.findOneAndUpdate(
      { userId: req.params.userId },
      updateData, // Dynamically update fields, including location
      { new: true }
    );

    if (!user) return res.status(404).send("User not found");
    res.send(user); // Sends the updated user object
  } catch (error) {
    res.status(400).send(error);
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const user = await User.findOneAndDelete({ userId: req.params.userId });
    if (!user) return res.status(404).send("User not found");
    res.send({ message: "User deleted successfully" });
  } catch (error) {
    res.status(500).send(error);
  }
};
