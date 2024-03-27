const express = require("express");
const User = require("../models/user")

const authRouter = express.Router();

authRouter.post("/api/signup", async(req, res) => {
  try {
    const {name, email, profileImg} = req.body;
    let user = User.findOne({email: email});
    if(user != null){
      user = new User({
        name: name,
        email: email,
        profileImg: profileImg,
      });
      user = await user.save();
    }

    res.json({user: user});
  } catch (e) {}
});

module.exports = authRouter;