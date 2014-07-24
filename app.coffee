# BASE SETUP

# packages we need
express = require 'express'
app = express()
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
Bear = require './models/bear'

# connect to database
mongoose.connect 'mongodb://node:node@novus.modulusmongo.net:27017/Iganiq8o'

# CONFIGURE

app.use bodyParser()
port = process.env.PORT || 8080

# ROUTES

router = express.Router() # an instance of the express router

# middleware
router.use (req, res, next) ->
	console.log('something is happening')
	next()

# test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/', (req, res) ->
		res.json { message: 'hooray! welcome to our api!'}
	)

router.route '/bears' 
	# create a bear (accessed at POST http://localhost:8080/api/bears)
	.post (req, res) ->
		bear = new Bear()
		bear.name = req.body.name

		# save the bear and check for errors
		bear.save (err) ->
			res.send err if err
			res.json  { message: 'Bear with name ' + bear.name + ' created!' }
	# get all the bears (accessed at GET http://localhost:8080/api/bears)
	.get (req, res) ->
		Bear.find (err, bears) ->
			res.send err if err
			res.json bears

router.route '/bears/:bear_id'
	# get the bear with that id (accessed at GET http://localhost:8080/api/bears/:bear_id)
	.get (req, res) ->
		Bear.findById(req.params.bear_id, (err, bear) ->
				res.send err if err 
				res.json bear
			)
	# update the bear with this id (accessed at PUT http://localhost:8080/api/bears/:bear_id)
	.put (req, res) ->
		Bear.findById(req.params.bear_id, (err, bear) ->
				res.send err if err 
				# update the bear
				bear.name  = req.body.name
				# save the bear
				bear.save (err) ->
					res.send err if err 
					res.json { message: 'Bear with name ' + bear.name + ' updated!'}
			)
	# delete the bear with this id (accessed at DELETE http://localhost:8080/api/bears/:bear_id)
	.delete (req, res) ->
		Bear.remove({ _id: req.params.bear_id}, (err, bear) ->
				res.send err if err
				res.json { message: 'Bear deleted!'}
			)

# REGISTER OUR ROUTES 
# all routes will be prefixed with /api
app.use('/api', router)

# START THE SERVER
app.listen(port)
console.log('Magic happens on port ' + port)