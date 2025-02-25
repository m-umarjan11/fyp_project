const ItemBorrowed = require('../models/itemBorrowed');
const item = require('../models/item');


exports.getAllBorrowedItems = async (req, res) => {
  try {
    const borrowedItems = await ItemBorrowed.find();
    res.status(200).json(borrowedItems);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.getBorrowedByUserId = async (req, res) => {
  try {
    let borrowedItems;
    if (req.path.includes('/borrowed/')) {
      borrowedItems = await ItemBorrowed.find({ borrowerId: req.params.userId });
    } else if (req.path.includes('/lent/')) {
      borrowedItems = await ItemBorrowed.find({ lenderId: req.params.userId });
    } else {
      return res.status(400).json({ message: 'Invalid path' });
    }
    res.status(200).json(borrowedItems);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.borrowItem = async (req, res) => {
  try {
    const borrowedItem = new ItemBorrowed(req.body);
    const savedBorrowedItem = await borrowedItem.save();
    if (!savedBorrowedItem) return res.status(404).json({ message: 'Item not borrowed' });  
    item.findByIdAndUpdate(req.body.itemId, { isRented: true });
    res.status(201).json(savedBorrowedItem);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.returnItem = async (req, res) => {
  try {
    const updatedBorrowedItem = await ItemBorrowed.findByIdAndUpdate(
      req.params.id,
      { returnDate: req.body.returnDate },
      { new: true }
    );
    if (!updatedBorrowedItem) return res.status(404).json({ message: 'Borrow record not found' });
    res.status(200).json(updatedBorrowedItem);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
