const User = require("../model/User");
const express = require("express");
const bcrypt = require("bcryptjs");
const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const router = express.Router();
const auth = require("../middleware/auth");
const UpdateUser = asyncHandler(async (req, res) => {
  
    const user = await User.findOneAndUpdate(req.body.username);
  
    if (user) {
      
      user.email = req.body.email || user.email;
      
    
      user.password = req.body.password;
      
  
      const updatedUser = await user.save();
  
      res.json({
        username: updatedUser.username,
        password:updatedUser.password,
        
        email: updatedUser.email,
       
        
      });
    } else {
      res.status(404);
      throw new Error("User Not Found");
    }
  });
  module.exports = {UpdateUser};