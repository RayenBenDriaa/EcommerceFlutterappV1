const express = require("express");
const bodyParser = require("body-parser");
const user = require("./routes/user");
const commande= require("./routes/commande");
const InitiateMongoServer = require("./config/db");
const cors = require('cors');


// Initiate Mongo Server
InitiateMongoServer();

const app = express();
app.use(cors());

// PORT
const PORT = process.env.PORT || 4000;

// Middleware
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.json({ message: "API Working" });
});

/**
 * Router Middleware
 * Router - /user/*
 * Method - *
 */
app.use("/user", user);
app.use("/commande",commande);

app.listen(PORT, (req, res) => {
  console.log(`Server Started at PORT ${PORT}`);
});
