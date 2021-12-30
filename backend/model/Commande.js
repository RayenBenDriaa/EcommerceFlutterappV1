const mongoose = require("mongoose");
const CommandeSchema = mongoose.Schema({
    id: {
      type: Number,
      required: true
    },
    total: {
      type: Number,
      required: true,
      default: 0
    },
   
  });
  
  // export model Commande with CommandeSchema
  module.exports = mongoose.model("Commande", CommandeSchema);