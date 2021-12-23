const User = require("../model/User");
const express = require("express");
const bcrypt = require("bcryptjs");
const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const router = express.Router();
const auth = require("../middleware/auth");

const common_methods = require('../common/common_methods/common_methods')
const messages = require('../common/common_messages/return_messages')
//const bcrypt = require('bcrypt');

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

//  generate && send new password
const forgetPassword = async (req, res) => {
    const user = await User.findOne({ email: req.params.email })
    console.log(user);
    try {
        if (user) {
            //  user found
            const newPassword = common_methods.generateRandomPassword()
            const updatedUser = await User.findOneAndUpdate({ email: req.params.email }, {
                $set: {
                    password: newPassword.toUpperCase()
                }
            }, { lean: true })

            if (updatedUser) {
                //  password updated successfully
                common_methods.sendMail(req.params.email, newPassword.toUpperCase())
                return res.status(201).json({
                    ok: true,
                    message: messages.returnMessages.MAIL_SUCCESS + " " + newPassword.toUpperCase()
                });
            }

        } else {
            //  invalid mail address
            return res.status(404).json({
                ok: false,
                message: messages.returnMessages.NOT_FOUND
            })
        }
    } catch (error) {
        return res.status(500).json({
            ok: false,
            message: messages.returnMessages.SERVER_ERROR
        })
    }
}


  module.exports = {UpdateUser,forgetPassword};
