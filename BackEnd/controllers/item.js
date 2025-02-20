const Item = require('./../models/item');

const handleError = (res, error, statusCode = 500, message = "Internal Server Error") => {
  res.status(statusCode).json({
    error: {
      code: statusCode,
      message: message,
      details: error.message || error,
    },
  });
};

exports.getAllItems = async (req, res) => {
  try {
    const items = await Item.find();
    res.status(200).json(items);
  } catch (error) {
    handleError(res, error, 500, "Failed to fetch all items");
  }
};

exports.getItemById = async (req, res) => {
  try {
    const item = await Item.findById(req.params.itemId);
    if (!item) return res.status(404).json({ message: 'Item not found' });
    res.status(200).json(item);
  } catch (error) {
    handleError(res, error, 500, "Failed to fetch item by ID");
  }
};

exports.createItem = async (req, res) => {
  try {
    console.log(req.body)
    const newItem = new Item(req.body);
    const savedItem = await newItem.save();
    res.status(201).json(savedItem);
  } catch (error) {
    console.log(error)
    handleError(res, error, 500, "Failed to create new item");
  }
};

exports.updateItem = async (req, res) => {
  try {
    const updatedItem = await Item.findByIdAndUpdate(req.params.itemId, req.body, {
      new: true,
    });
    if (!updatedItem) return res.status(404).json({ message: 'Item not found' });
    res.status(200).json(updatedItem);
  } catch (error) {
    handleError(res, error, 500, "Failed to update item");
  }
};

exports.deleteItem = async (req, res) => {
  try {
    const deletedItem = await Item.findByIdAndDelete(req.params.itemId);
    if (!deletedItem) return res.status(404).json({ message: 'Item not found' });
    res.status(200).json({ message: 'Item deleted' });
  } catch (error) {
    handleError(res, error, 500, "Failed to delete item");
  }
};

exports.getItemsNearMe = async (req, res) => {
  const { userLocation, setNo = 1 } = req.body;

  const ITEMS_PER_PAGE = 20;
  const skip = (setNo - 1) * ITEMS_PER_PAGE;

  try {
    if (!userLocation || !userLocation.lat || !userLocation.lng) {
      return res.status(400).json({ error: { code: 400, message: "Invalid location" } });
    }

    const items = await Item.aggregate([
      {
        $geoNear: {
          near: {
            type: "Point",
            coordinates: [userLocation.lng, userLocation.lat], 
          },
          distanceField: "distance", 
          spherical: true, 
        },
      },
      { $skip: skip }, 
      { $limit: ITEMS_PER_PAGE },
    ]);

    res.status(200).json(items);
  } catch (error) {
    handleError(res, error, 500, "Failed to fetch items near you");
  }
};
