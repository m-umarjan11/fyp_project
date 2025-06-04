const ItemBorrowed = require('../models/itemBorrowed');
const Item = require('../models/item');
const {onRequestStatusChange, orderPlaced} = require('../middleware/fcmService');
const handleError = (res, error, statusCode = 500, message = "Internal Server Error") => {
  res.status(statusCode).json({
    code: statusCode,
    message: message,
    details: error.message || error,
  });
};

exports.getAllBorrowedItems = async (req, res) => {
  try {
    const borrowedItems = await ItemBorrowed.find();
    res.status(200).json(borrowedItems);
  } catch (error) {
    handleError(res, error, 500, "Failed to retrieve borrowed items");
  }
};

exports.getLentedByUserId = async (req, res) => {
  try {
    const lentedItems = await ItemBorrowed.find({ lenderId: req.params.userId });

    const itemObjects = (await Promise.all(
      lentedItems.map(async (lentedItem) => {
        const item = await Item.findById(lentedItem.itemId);
        if (!item) {
          await ItemBorrowed.deleteOne({ _id: lentedItem._id });
          return null;
        }
        return item;
      })
    )).filter(Boolean); // removes nulls

    res.status(200).json({ itemObjects, lentedItems });
  } catch (error) {
    handleError(res, error, 500, "Failed to retrieve lented items");
  }
};


exports.getBorrowedByUserId = async (req, res) => {
  try {
    const borrowedItems = await ItemBorrowed.find({ borrowerId: req.params.userId });
    //console.log("Borrowed Items: ", borrowedItems);

    const itemObjects = (await Promise.all(
      borrowedItems.map(async (borrowedItem) => {
        const item = await Item.findById(borrowedItem.itemId);
        if (!item) {
          await ItemBorrowed.deleteOne({ _id: borrowedItem._id });
          return null;
        }
        return item;
      })
    )).filter(Boolean); // removes nulls

    res.status(200).json({ itemObjects, borrowedItems });
  } catch (error) {
    handleError(res, error, 500, "Failed to retrieve borrowed items");
  }
};


exports.borrowItem = async (req, res) => {
  try {
    let item = await Item.findById(req.body.itemId);
    if (!item) return handleError(res, "Item not found", 404);
    if (item.isRented) return handleError(res, "Sorry, the item is already rented", 400);

    // Mark item as rented first to avoid race conditions
    item.isRented = true;
    await item.save();
    orderPlaced(item, `Your item "${item.itemName}" has been ordered.`);
    const borrowedItem = new ItemBorrowed(req.body);
    const savedBorrowedItem = await borrowedItem.save();
    if (!savedBorrowedItem) return handleError(res, "Item not borrowed", 500);

    res.status(201).json(savedBorrowedItem);
  } catch (error) {
    handleError(res, error, 500, "Failed to borrow item");
  }
};


exports.returnItem = async (req, res) => {
  try {
    const updatedBorrowedItem = await ItemBorrowed.findByIdAndUpdate(
      req.params.id,
      { returnDate: req.body.returnDate },
      { new: true }
    );

    if (!updatedBorrowedItem) return handleError(res, "Borrow record not found", 404);

    res.status(200).json(updatedBorrowedItem);
  } catch (error) {
    handleError(res, error, 500, "Failed to return item");
  }
};

exports.updatedBorrowedItem = async(req, res) => {
  try{
    const toUpdate = await ItemBorrowed.findByIdAndUpdate(req.params.id, req.body, {new: true});
    if (!toUpdate) return handleError(res, "Borrow record not found", 404);
    //console.log("Updated Borrowed Item: ", toUpdate);
    onRequestStatusChange(toUpdate, toUpdate.requestStatus);
    if(toUpdate.requestStatus === "Returned"){
      const item = await Item.findById(toUpdate.itemId);
      
      await Item.findByIdAndUpdate(toUpdate.itemId, {
    $set: { isRented: false },
    $inc: { sales: 1 },
  });
    } 
    if(toUpdate.requestStatus === "Rejected"){
      await Item.findByIdAndUpdate(
        toUpdate.itemId,
        { isRented: false }
      );
    }
    res.status(200).json({ message: "Borrow record updated successfully", data: toUpdate });
  }catch (error) {
    handleError(res, error, 500, "Failed to update borrowed item");
  }
};

exports.deleteItemBorrowed = async (req, res) => {
  try {
    const deletedItemBorrowed = await ItemBorrowed.findByIdAndDelete(req.params.id);
    if (!deletedItemBorrowed) return handleError(res, "Borrow record not found", 404);

    await Item.findByIdAndUpdate(deletedItemBorrowed.itemId, { isRented: false });

    res.status(200).json({ message: 'Borrow record deleted' });
  } catch (error) {
    handleError(res, error, 500, "Failed to delete borrowed item");
  }
};

