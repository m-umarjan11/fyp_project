const express = require('express');
const router = express.Router();
const userLocationController = require('../controllers/userLocation');

router.get('/', userLocationController.getAllLocations);
router.get('/:userId', userLocationController.getLocationByUserId);
router.post('/', userLocationController.upsertLocation);
router.delete('/:userId', userLocationController.deleteLocation);

module.exports = router;
