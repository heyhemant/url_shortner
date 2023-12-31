const express = require('express');
const {PORT} = require('./constants/global_const');
const { connectToMongoDB } = require('./connect');
const urlRoute = require('./routes/root_routes');

const app = express();

app.listen(PORT, () => {
    connectToMongoDB().then(() => {
        console.log("Connected to MongoDB");
    });    
    console.log(`Server listening on port ${PORT}`);
});

app.use(express.json());
app.use(express.urlencoded());
app.use('/', urlRoute);
