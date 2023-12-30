const mongoose = require("mongoose");

const URLSchema = mongoose.Schema(
  {
    long_url: {
      type: String,
      required: true,
    },
    short_url: {
      type: String,
      required: true,
      unique: true,
    },
    visit_history: [{ timestamp: { type: Date, default: Date.now } }],
  },
  { timestamp: true }
);

const URL = mongoose.model("URL", URLSchema);

module.exports = URL;