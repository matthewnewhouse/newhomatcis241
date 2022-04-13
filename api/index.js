const fs = require('fs')
const csv = require('csv-parse')

let heroes = {};

const parser = csv.parse(
	{ columns: true }, 
	function(err, records){
		heroes = records;
	}
);

fs.createReadStream(__dirname + '/superheroes.csv').pipe(parser)

const express = require('express');
const app = express()
const port = 3000;

app.use(express.static('public'))

app.get('/', 
	(req, res) => {
		res.send('<h1>Welcome to our awesome Superhero API!</h1>');
	}
);

app.get('/heroes',
	(req, res) => {
		res.send(heroes);
	}
);

app.get('/search/:term',
	(req, res) => {
		let selected = [];
		heroes.forEach(
			e => {
				if(e.Name.includes(req.params.term)){
					selected.push(e);
				}
			}
		)
		res.send(selected);
	}
);

app.get('/:term/:universe',
	(req, res) => {
		res.send(heroes.filter((hero)=> 
			hero.Name.toLowerCase().includes
			(req.params.term.toLowerCase()) 
			&& hero.Universe.toLowerCase().includes
			(req.params.universe.toLowerCase())));
	});

app.listen(port, () => {
	console.log("I've become aware.");
});
