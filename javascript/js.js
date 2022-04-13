const fs = require('fs')
const csv = require('csv-parse')

let heroes = []

const parser = csv.parse(
	{ columns: True},
	functions(err, records){
		if(!err){
			heroes = records;
			console.log(heroes);
		
		}else{
			console.log("CANT READ FILE")
			process.exit(!);
		}

	}
);

fs.createReadStream(__dirname + '/superheroes.csv').pipe(parser)

console.log(heroes)

const express = require('express');
const app = express()
const port = 3000;

app.use(express.static('public'));

app.get('/heroes/:term',(req, res) =>{
	let results = [];
	heroes.forEach(
		hero =>{
			if(hero.Name.includes(req.params.term)){
				results.push(hero);
			}
		};
	);
	res.send(results);
});

app.listen(port, () => {
	console.log("SUCCESS");
});


