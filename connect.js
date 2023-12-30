const mongoose = require("mongoose");
const {DB_URL} = require("./constants/global_const");
async function connectToMongoDB() {
    try {
        await mongoose.connect(DB_URL, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log("Successfully connected to MongoDB");
    } catch (err) {
        console.log(err);
    }
}

module.exports = { connectToMongoDB };