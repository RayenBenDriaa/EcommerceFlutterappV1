const express = require("express");
const Commande = require("../model/Commande");
const router = express.Router();
const {UpdateCommande,CreateCommande} = require("../Controllers/CommandeController");
router.post("/editCommande",UpdateCommande);
router.post("/NewCmd",CreateCommande);
router.get("/getcmdbyid",  async (req, res) => {
    const {id} = req.body;
  
    let commande = await Commande.findOne({id});
   
      
      res.json(commande);
   
  });
  
module.exports = router;
