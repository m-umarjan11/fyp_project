const express = require('express');
const router = express.Router();
const userController = require('./../controllers/user');

// Define routes

router.post('/register',(req,res, next)=>{console.log(req.body);next();}, userController.createUser);
router.get('/:userId', userController.getUser);
router.put('/:userId', userController.updateUser);
router.delete('/:userId', userController.deleteUser);

module.exports = router;