const Commande = require("../model/Commande");
const asyncHandler = require("express-async-handler");
const express = require("express");
const router = express.Router();




const CreateCommande = asyncHandler(async (req, res) => {
  
    const { id, total} = req.body;
  
      
       let commande = new Commande({
            id,
            total
         });
         await commande.save();
  
      res.json({ 
        id: commande.id,
        total:commande.total,
 });

   
});


const UpdateCommande = asyncHandler(async (req, res) => {
    const {id} = req.body;
  
    let commande = await Commande.findOne({id});
    
  
    if (commande) {
      
     
      commande.total= req.body.total || commande.total;
      
     
      

      
    
     
      
  
      const updatedCommande = await commande.save();
  
      res.json({
        
        id: updatedCommande.id,
        total:updatedCommande.total,
        

       
        
      });
    } else {
      res.status(404);
      throw new Error("Commande Not Found");
    }
});
module.exports = {UpdateCommande,CreateCommande};