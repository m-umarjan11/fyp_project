const express = require('express');
require('./configs/db');
const app = express();


const userRoutes = require('./routes/user');
// const userReviewRoutes = require('./routes/userReview');
const itemRoutes = require('./routes/item');
const itemReviewRoutes = require('./routes/itemReview');
// const userLocationRoutes = require('./routes/userLocation');
const itemBorrowedRoutes = require('./routes/itemBorrowed');
const wishlistRoutes = require('./routes/wishlist');
const { paymentCreateAccount, paymentIntent } = require('./controllers/payment');
const rateLimit = require('express-rate-limit');

app.use(express.json());
app.use(rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute window
  max: 100                 // Limit each IP to 100 requests per minute
}));


app.use('/api/v1/users', userRoutes);
// app.use('/api/v1/user-reviews', userReviewRoutes);
app.use('/api/v1/items', itemRoutes);
app.use('/api/v1/item-reviews', itemReviewRoutes);
// app.use('/api/v1/user-locations', userLocationRoutes);
app.use('/api/v1/borrowed-items', itemBorrowedRoutes);
app.use('/api/v1/wishlist', wishlistRoutes);
app.post('/api/v1/create-connect-account', paymentCreateAccount);
app.post('/api/v1/create-payment-intent', paymentIntent);
// app.use('/api/v1/payment-gateway', );


const PORT = process.env.PORT || 4000;
app.listen(PORT, '0.0.0.0',() => console.log(`Server running on port ${PORT}`));
// 