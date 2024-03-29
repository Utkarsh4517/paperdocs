const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, profileImg } = req.body;
    let user = User.findOne({ email: email });
    if (user != null) {
      user = new User({
        name: name,
        email: email,
        profileImg: profileImg,
      });
      user = await user.save();
    }

    res.status(200).json({ user: user });
  } catch (e) {
    console.log(e.message);
    res.status(500).json({ error: e.message });

  }
});

module.exports = authRouter;
