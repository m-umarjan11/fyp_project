
const jwt = require('jsonwebtoken');


const authenticate = (req, res, next) => {
  const token = req.header('Authorization');
  if (!token) return res.status(401).send('Access denied');
  try {
    const verified = jwt.verify(token, process.env.JWT_SECRET);
    req.user = verified;
    next();
  } catch (error) {
    res.status(400).send('Invalid token');
  }
};



module.exports = authenticate;

