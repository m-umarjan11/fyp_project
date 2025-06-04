const firebaseAdmin = require('../firebase');
const User = require('../models/user');

async function orderPlaced(item, notificationMessage, title)  {
  try {
    const user = await User.findById(item.userId);
    if (!user) {
      console.error('User not found for item:', item._id);
      return;
    }

    const message = {
      token: user.fcmToken,
      notification: {
        title: title || 'Order Placed',
        body: notificationMessage,
      },
      data: {
        role: 'borrower',
        targetPage: 'RequestPage',
        status: 'placed',
        itemId: item._id.toString(),
      },
    };

    const response = await firebaseAdmin.messaging().send(message);
    console.log(`Notification sent to borrower (${user.userName}):`, response);
  } catch (error) {
    console.error(`Error in orderPlaced for item ${item._id}:`, error);
  }
}

async function onRequestStatusChange(itemBorrowed, newStatus) {
  try {
    if (!itemBorrowed) return console.error('Item not found.');

    const [lender, borrower] = await Promise.all([
      User.findById(itemBorrowed.lenderId),
      User.findById(itemBorrowed.borrowerId),
    ]);

    const users = [
      { user: lender, role: 'lender', targetPage: 'OrderPage' },
      { user: borrower, role: 'borrower', targetPage: 'RequestPage' },
    ];

    for (const { user, role, targetPage } of users) {
      console.log(`Sending notification to ${role} (${user.userName})...${user.fcmToken ? 'Yes' : 'No'}`);
      if (!user?.fcmToken) continue;

      const message = {
        token: user.fcmToken,
        notification: {
          title: 'Request Status Updated',
          body: `Status changed to ${newStatus}`,
        },
        data: {
          role,
          targetPage,
          status: newStatus,
          itemId: itemBorrowed._id.toString(),
        },
      };

      await firebaseAdmin.messaging().send(message).then((response) => {
        console.log(`Notification sent to ${role} (${user.userName}):`, response);
      }).catch((error) => {
        console.error(`Error sending notification to ${role} (${user.userName}):`, error);
      } );  
    }

    console.log('Notifications sent to lender and borrower.');
  } catch (err) {
    console.error('Error sending notifications:', err);
  }
}

module.exports = { onRequestStatusChange, orderPlaced };
