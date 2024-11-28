const Item = require('./../models/item');


exports.getAllItems = async (req, res) => {
  try {
    const items = await Item.find();
    res.status(200).json(items);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.getItemById = async (req, res) => {
  try {
    const item = await Item.findById(req.params.itemId);
    if (!item) return res.status(404).json({ message: 'Item not found' });
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.createItem = async (req, res) => {
  try {
    const newItem = new Item(req.body);
    const savedItem = await newItem.save();
    res.status(201).json(savedItem);
  } catch (error) {
    res.status(500).json({ error: error.message });
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
    res.status(500).json({ error: error.message });
  }
};


exports.deleteItem = async (req, res) => {
  try {
    const deletedItem = await Item.findByIdAndDelete(req.params.itemId);
    if (!deletedItem) return res.status(404).json({ message: 'Item not found' });
    res.status(200).json({ message: 'Item deleted' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


// exports.getItemsNearMe = async (req, res) => {
//   const { userLocation, setNo = 1 } = req.body;

//   const ITEMS_PER_PAGE = 20;
//   const skip = (setNo - 1) * ITEMS_PER_PAGE;

//   try {
//     if (!userLocation || !userLocation.lat || !userLocation.lng) {
//       return res.status(400).json({ error: "Invalid location" });
//     }

//     const items = await Item.aggregate([
//       {
//         $geoNear: {
//           near: {
//             type: "Point",
//             coordinates: [userLocation.lng, userLocation.lat], // [longitude, latitude]
//           },
//           distanceField: "distance", // Adds a field "distance" to each result
//           spherical: true, // Use spherical geometry for calculations
//         },
//       },
//       { $skip: skip }, // Skip the first N items
//       { $limit: ITEMS_PER_PAGE }, // Limit the results to ITEMS_PER_PAGE
//     ]);

//     res.json(items);
//   } catch (error) {
//     res.status(500).json({ error: "Failed to fetch items" });
//   }
// };
