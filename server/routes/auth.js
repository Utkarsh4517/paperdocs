const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth")
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

    const token = jwt.sign({ id: user._id }, "key1");

    res.status(200).json({ user: user, token: token });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ user, token: req.token });
});

module.exports = authRouter;
