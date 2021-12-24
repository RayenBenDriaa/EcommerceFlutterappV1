const User = require("../model/User");
const express = require("express");
const bcrypt = require("bcryptjs");
const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const router = express.Router();
const auth = require("../middleware/auth");
const UpdateUser = asyncHandler(async (req, res) => {
  
    const user = await User.findOneAndUpdate(req.body.fullname);
  
    if (user) {
      
      user.email = req.body.email || user.email;
      user.fullname= req.body.fullname || user.fullname;
      user.telephone=req.body.telephone || user.telephone;
      user.date_naissance= req.body.date_naissance|| user.date_naissance;
      user.adresse="la marsa";

      
    
      user.password = req.body.password;
      
  
      const updatedUser = await user.save();
  
      res.json({
        
        fullname: updatedUser.fullname,
        password:updatedUser.password,
        email: updatedUser.email,
        telephone :updatedUser.telephone,

       
        
      });
    } else {
      res.status(404);
      throw new Error("User Not Found");
    }
  });
  module.exports = {UpdateUser};