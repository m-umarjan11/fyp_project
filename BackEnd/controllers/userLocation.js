const UserLocation = require('../models/userLocation');


exports.getAllLocations = async (req, res) => {
  try {
    const locations = await UserLocation.find();
    res.status(200).json(locations);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.getLocationByUserId = async (req, res) => {
  try {
    const location = await UserLocation.findOne({ userId: req.params.userId });
    if (!location) return res.status(404).json({ message: 'Location not found' });
    res.status(200).json(location);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.upsertLocation = async (req, res) => {
  try {
    const { userId, latitude, longitude } = req.body;
    const location = await UserLocation.findOneAndUpdate(
      { userId },
      { latitude, longitude, lastModified: Date.now() },
      { new: true, upsert: true }
    );
    res.status(200).json(location);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


exports.deleteLocation = async (req, res) => {
  try {
    const location = await UserLocation.findOneAndDelete({ userId: req.params.userId });
    if (!location) return res.status(404).json({ message: 'Location not found' });
    res.status(200).json({ message: 'Location deleted' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
