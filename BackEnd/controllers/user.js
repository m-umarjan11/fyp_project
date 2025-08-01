const User = require("../models/user");
const jwt = require('jsonwebtoken');
const { OAuth2Client } = require('google-auth-library');

const handleError = (res, error, statusCode = 500, message = "Internal Server Error") => {
  res.status(statusCode).json({
    code: statusCode,
    message: message,
    details: error.message || error,
  });
};

exports.createUser = async (req, res) => {
  //console.log("Creating User");
  const { userName, email, password, picture, personReputation, location, phoneNumber, cnic } = req.body;
  try {
    const user = new User({
      userName,
      email,
      password,
      picture,
phoneNumber,
      cnic,
      personReputation,
      location,
    });

    await user.save();
    let token = jwt.sign({ name: user.userName, email: user.email }, process.env.JWT_SECRET);
    user.password = token;
    res.status(201).json(user.toObject());
  } catch (error) {
    //console.log(error);
    handleError(res, error, 400, "Failed to create user");
  }
};

exports.getUser = async (req, res) => {
  try {
    //console.log("Getting User ", req.params.userId);
    const user = await User.findById(req.params.userId);
    //console.log("User found: ", user);
    if (!user) return handleError(res, "User not found", 404);
    res.status(200).json({userId:user._id,sellerName: user.userName, email: user.email, image: user.picture, personReputation: user.personReputation, location: user.location });
  } catch (error) {
    handleError(res, error, 500, "Failed to retrieve user");
  }
};

exports.updateUser = async (req, res) => {
  try {
    const updateData = req.body;
    if (req.body.location) updateData.location = req.body.location;

    const user = await User.findOneAndUpdate(
      { userId: req.params.userId },
      updateData,
      { new: true }
    );

    if (!user) return handleError(res, "User not found", 404);
    res.status(200).json(user);
  } catch (error) {
    handleError(res, error, 400, "Failed to update user");
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const user = await User.findOneAndDelete({ userId: req.params.userId });
    if (!user) return handleError(res, "User not found", 404);
    res.status(200).json({ message: "User deleted successfully" });
  } catch (error) {
    handleError(res, error, 500, "Failed to delete user");
  }
};

exports.loginWithGoogle = async (req, res) => {
  try {
    const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);
    const ticket = await client.verifyIdToken({
      idToken: req.body.idToken,
      audience: process.env.GOOGLE_CLIENT_ID,
    });

    const payload = ticket.getPayload();
    const { sub: googleId, email, name, picture } = payload;

    const jwtToken = jwt.sign({ name, email }, process.env.JWT_SECRET);
    let user = await User.findOne({ email });
    if (!user) {
      user = new User({
        userName: name,
        userId: googleId,
        email,
        password: googleId,
        picture,
        personReputation: 0,
        location: req.body.location || {},
        
      });
      const userObj = user.toObject();
userObj.userType = "newUser";
return res.status(201).json(userObj);
    }

    user.password = jwtToken;
    res.status(201).json(user.toObject());
  } catch (error) {
    //console.log(error);
    handleError(res, error, 400, "Google login failed");
  }
};

exports.logIn = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) return handleError(res, `Account with ${email} not found`, 404);

    const comparePassword = await user.comparePassword(password);
    if (!comparePassword) return handleError(res, "Invalid Credentials", 401);

    let token = jwt.sign({ userId: user.userId }, process.env.JWT_SECRET);
    user.password = token;
    res.status(201).json(user.toObject());
  } catch (error) {
    console.error(error);
    handleError(res, error, 500, "Internal Server Error");
  }
};


 exports.saveFcmToken = async (req, res) => {
  const { userId, fcmToken } = req.body;
  try {
    const user = await User.findByIdAndUpdate(
      userId,
      { fcmToken },
      { new: true }
    );
    // console.log(user);
    if (!user) return handleError(res, "User not found", 404);
    res.status(200).json({ message: "FCM Token saved successfully" });
  } catch (error) {
    console.error(error);
    handleError(res, error, 500, "Failed to save FCM Token");
  }
} 