var express = require('express');

var app = express();

var state = 'ok';

app.get('/', function (req, res) {
	if (state === 'ok') {
		res.send('hello');	
	} else {
		// hang
	}
});

app.get('/error', function (req, res) {
	state = 'error';
	throw new Error('here is some error');
});

app.use(function (err, req, res, next) {
  	console.log('got to my error handler');
  	res.send('Error. Exiting process.');
  	process.exit(1);
});

var port = process.env.PORT || 4000;
app.listen(port);
console.log('Server listening on port', port);
