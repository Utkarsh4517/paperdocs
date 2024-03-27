const express = require("express");
const mongoose = require("mongoose");
const DB = require("config/dbConfig.js")

const PORT = process.env.PORT || 3001;

const app = express();

mongoose.connect(DB).then(() => console.log('Database connected')).catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => console.log("Server connected"));
