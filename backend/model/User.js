const mongoose = require("mongoose");

const UserSchema = mongoose.Schema({
  username: {
    type: String,
    required: true
  },
  fullname: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  telephone: {
    type: Number,
    required: true
  },
  adresse: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  pdp: {
    type: String,
    required: false
  },
  date_naissance:{
    type: String, 
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now()
  } 
});

// export model user with UserSchema
module.exports = mongoose.model("user", UserSchema);
