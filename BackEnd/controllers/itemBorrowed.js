const ItemBorrowed = require('../models/ItemBorrowed');


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
    const borrowedItems = await ItemBorrowed.find({ userId: req.params.userId });
    res.status(200).json(borrowedItems);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.borrowItem = async (req, res) => {
  try {
    const borrowedItem = new ItemBorrowed(req.body);
    const savedBorrowedItem = await borrowedItem.save();
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
