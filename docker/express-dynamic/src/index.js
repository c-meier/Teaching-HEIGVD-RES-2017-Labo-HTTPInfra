var express = require('express');
var app = express();

var Chance = require('chance');
var chance = new Chance();

app.get('/', function (req, res) {
	res.send( generateStreetNames() );
});

app.listen(3000, function () {
	console.log("Accepts http requests on port 3000");
});

function generateStreetNames() {
	var numberOfStreetNames = chance.integer({min: 1, max: 15});
	console.log("Generating " + numberOfStreetNames + " street names.");

	var streetNames = [];
	for(var i = 0; i < numberOfStreetNames; i++) {
		streetNames.push({
			streetname: chance.street(),
			city: chance.city()
		});
	}
	return streetNames;
}
