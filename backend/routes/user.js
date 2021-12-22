const express = require("express");
const { check, validationResult } = require("express-validator/check");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const router = express.Router();
const auth = require("../middleware/auth");

const User = require("../model/User");
const {UpdateUser } = require("../Controllers/UserController");

/**
 * @method - POST
 * @param - /signup
 * @description - User SignUp
 */

 router.post(
  "/signup",
  [
    check("username", "Entrez un nom d'utilisateur valide")
      .not()
      .isEmpty(),
    check("fullname", "Entrez un nom et prénom valide")
      .not()
      .isEmpty(),
    check("adresse", "Entrez une adresse valide")
      .not()
      .isEmpty(),
    check("email", "Entrez une adresse mail valide").isEmail(),
    check("telephone", "Entrez un numéro de téléphone valide").isLength(8),
    check("password", "Votre mot de passe doit contenir au minimum 8 caractères").isLength({
      min: 8
    }), 
    check("date_naissance", "Entrez une date de naissance valide").not().isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        errors: errors.array()
      });
    }

    const { username, fullname, email, telephone, adresse, pdp, password, date_naissance, role } = req.body;
    try {
      let user = await User.findOne({
        email
      });
      let usernam = await User.findOne({username});
      if (user) {
        return res.status(400).json({
          msg: "Cette adresse email a déjà été utilisée !"
        });
      }
      if (usernam) {
        return res.status(400).json({
          msg: "Ce nom d'utilisateur existe déjà !"
        });
      }

      user = new User({
        username,
        fullname,
        email,
        telephone, 
        adresse,
        pdp,
        date_naissance,
        password, 
        role
      });

      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(password, salt);

      await user.save();

      const payload = {
        user: {
          id: user.id
        }
      };

      jwt.sign(
        payload,
        "randomString",
        {
          expiresIn: 10000
        },
        (err, token) => {
          if (err) throw err;
          res.status(200).json({
            token
          });
        }
      );
    } catch (err) {
      console.log(err.message);
      res.status(500).send("Error in Saving");
    }
  }
);

router.route("/checkUsername/:username").get((req,res) => {
  User.findOne({ username : req.params.username}, (err, Result) => {
    if (err) return res.status(500).json({ msg : err });
    if (Result !== null){
      return res.json({ 
        Status: true,
      })
    }else return res.json({
      Status: false,
    });
  });
})
router.route("/checkEmail/:email").get((req,res) => {
  User.findOne({ email : req.params.email}, (err, Result) => {
    if (err) return res.status(500).json({ msg : err });
    if (Result !== null){
      return res.json({ 
        Status: true,
      })
    }else return res.json({
      Status: false,
    });
  });
})

router.post(
  "/login",
  [
    check("email", "Please enter a valid email").isEmail(),
    check("password", "Please enter a valid password").isLength({
      min: 6
    })
  ],
  async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({
        errors: errors.array()
      });
    }

    const { email, password } = req.body;
    try {
      let user = await User.findOne({
        email
      });
      if (!user)
        return res.status(400).json({
          message: "User Not Exist"
        });

      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch)
        return res.status(400).json({
          message: "Incorrect Password !"
        });

      const payload = {
        user: {
          id: user.id
        }
      };

      jwt.sign(
        payload,
        "randomString",
        {
          expiresIn: 3600
        },
        (err, token) => {
          if (err) throw err;
          res.status(200).json({
            token
          });
        }
      );
    } catch (e) {
      console.error(e);
      res.status(500).json({
        message: "Server Error"
      });
    }
  }
);

/**
 * @method - POST
 * @description - Get LoggedIn User
 * @param - /user/me
 */

router.get("/me", auth, async (req, res) => {
  try {
    // request.user is getting fetched from Middleware after token authentication
    const user = await User.findById(req.user.id);
    res.json(user);
  } catch (e) {
    res.send({ message: "Error in Fetching user" });
  }
});

router.post("/editUser",UpdateUser);


module.exports = router;
