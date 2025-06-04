const Stripe = require('stripe');
const stripe = Stripe(process.env.STRIPE_SECRET_KEY);
const cors = require('cors');
const User = require('../models/user');
const ItemBorrowed = require('../models/itemBorrowed');

exports.paymentCreateAccount = async (req, res) => {
  try {
    const userId = req.body.userId;
    //console.log(`Creating Stripe account for user: ${userId}`);

    const account = await stripe.accounts.create({
      type: 'express',
    });
    //console.log(`Stripe account created: ${account.id}`);

    const accountLink = await stripe.accountLinks.create({
      account: account.id,
      refresh_url: 'https://example.com/reauth',
      return_url: 'https://example.com/return',
      type: 'account_onboarding',
    });
    //console.log(`Account onboarding link created: ${accountLink.url}`);

    const updatedUser = await User.findByIdAndUpdate(
      userId,
      { accountId: account.id },
      { new: true }
    );
    //console.log(`User updated with Stripe account ID: ${updatedUser?.sellerAccountId}`);

    const updatedItems = await ItemBorrowed.updateMany(
      { lenderId: userId },
      { sellerAccountId: account.id }
    );
    //console.log(`Updated ${updatedItems.modifiedCount} borrowed items with seller account ID`);

    res.json({
      url: accountLink.url,
      accountId: account.id,
    });

  } catch (error) {
    console.error(`Error in paymentCreateAccount: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
};

exports.paymentIntent = async (req, res) => {
  const { amount, currency, connectedAccountId } = req.body;
  //console.log(`Creating payment intent for amount: ${amount} ${currency}, connectedAccountId: ${connectedAccountId}`);

  try {
    const paymentIntent = await stripe.paymentIntents.create(
      {
        amount: amount,
        currency: currency,
        payment_method_types: ['card'],
        // application_fee_amount: Math.round(amount * 0.1),
      },
      {
        stripeAccount: connectedAccountId,
      }
    );

    //console.log(`PaymentIntent created: ${paymentIntent.id}`);
    res.status(200).json({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (err) {
    console.error(`Error in paymentIntent: ${err.message}`);
    res.status(400).json({ error: err.message });
  }
};
