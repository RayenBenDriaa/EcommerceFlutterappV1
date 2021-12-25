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
    const {username} = req.body;
  
    let user = await User.findOne({username});
    
  
    if (user) {
      
      user.email = req.body.email || user.email;
      user.fullname= req.body.fullname || user.fullname;
      user.telephone=req.body.telephone || user.telephone;
      user.date_naissance= req.body.date_naissance|| user.date_naissance;
      user.adresse=req.body.adresse|| user.adresse;
      const salt = await bcrypt.genSalt(10);
      const pwd =req.body.password;
      user.password = await bcrypt.hash(pwd, salt);

      
    
     
      
  
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
