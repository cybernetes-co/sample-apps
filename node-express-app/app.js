'use strict';

var express = require('express'),

    app = express();
app.set('views', 'views');
app.set('view engine', 'pug');


const port = process.env.PORT || 8080;
app.get('/', function (req, res) {
    console.log("Request received on /");
    res.render('home', {
    });
});

console.log("running on port: " + port);
app.listen(port);
module.exports.getApp = app;
