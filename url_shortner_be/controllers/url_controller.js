const mongoose = require("mongoose");
const shortid = require("shortid");
const URL = require("../models/url_model");
const { BASE_URL } = require("../constants/global_const")

const urlRegex = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;

function isValidUrl(url) {
  return urlRegex.test(url);
}

async function handleAndCreateShortURL(req, res) {
  if (!req.body || !req.body.long_url)
    return res.status(400).json({ error: "Please provide a long_url" });
  const long_url = req.body.long_url;
  if(!(isValidUrl(long_url))){
    return res.status(400).json({ error: "Please Enter a Valid URL" });
  }
  const short_url = shortid.generate();
  const url = new URL({
    _id: new mongoose.Types.ObjectId(),
    long_url,
    short_url,
    visit_history: [],
  });
  try {
    await url.save();
    return res.status(201).json({ short_url: `${BASE_URL}${short_url}` });
  } catch (err) {
    return res.status(500).json({ error: err });
  }
}

async function handleAndRedirect(req, res) {
  const short_id = req.params.short_id;
  try {
    const entry = await URL.findOneAndUpdate(
      { short_url: short_id },
      { $push: { visit_history: { timestamp: Date.now() } } }
    );
    if (!entry) return res.status(404).json({ error: "URL not found" });
    return res.redirect(entry.long_url);
  } catch (err) {
    return res.status(500).json({ error: err });
  }
}

async function handleUrlAnalytics(req, res) {
  const short_id = req.params.short_id;
  try {
    const entry = await URL.findOne({ short_url: short_id });
    if (!entry) return res.status(404).json({ error: "URL not found" });
    return res.status(200).json(entry);
  } catch (err) {
    return res.status(500).json({ error: err });
  }
}

module.exports = { handleAndCreateShortURL, handleAndRedirect, handleUrlAnalytics };
