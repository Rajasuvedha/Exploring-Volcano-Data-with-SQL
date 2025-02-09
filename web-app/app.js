const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const mustacheExpress = require('mustache-express');

const app = express();
const port = 3000;

app.engine('html', mustacheExpress());
app.set('view engine', 'html');
app.set('views', './templates');
app.use(bodyParser.urlencoded({ extended: true }));

var dbcon = mysql.createConnection({
    host: 'localhost',
    user: 'user',
    password: 'singapore',
    database: 'volcano_eruptions'
})

function templateRenderer(template, res) {
    return function (error, results, fields) {
        if (error)
            throw error;

        res.render(template, { data: results });
    }
}

app.get('/', function (req, res) {
    res.render("index.html")
})

app.get('/volcano-cty', function (req, res) {
    dbcon.query("SELECT DISTINCT country.country_name, volcano.volcano_name \
                FROM country\
                INNER JOIN locations\
                ON country.country_id = locations.country_id\
                INNER JOIN erupted\
                ON locations.location_id = erupted.location_id\
                INNER JOIN volcano\
                ON erupted.volcano_id = volcano.volcano_id; ",
        templateRenderer('volcano-cty', res));
})

app.get('/volcano-type', function (req, res) {
    dbcon.query("SELECT volcano_name, primary_volcano_type FROM volcano;",
        templateRenderer('volcano-type', res));
})

app.get('/volcano-year', function (req, res) {
    dbcon.query("SELECT volcano.volcano_name, eruption.last_eruption_year\
                FROM volcano\
                INNER JOIN eruption\
                ON volcano.eruption_id = eruption.eruption_id\
                WHERE (last_eruption_year > 1000); ",
        templateRenderer('volcano-year', res));
})

app.listen(port, function () {
    console.log('The app is listening at http://localhost:' + port + '.');
})
