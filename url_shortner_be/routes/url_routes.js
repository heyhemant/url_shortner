const express = require('express');
const { handleAndCreateShortURL,handleAndRedirect, handleUrlAnalytics } = require('../controllers/url_controller');
const URL = require('../models/url_model');

const router = express.Router();

router.get('/:short_id', handleAndRedirect);
router.post('/',handleAndCreateShortURL);
router.get('/analytics/:short_id', handleUrlAnalytics);

module.exports = router;