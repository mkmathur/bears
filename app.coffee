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

router = express.Router()

# test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/', (req, res) ->
		res.json { message: 'hooray! welcome to our api!'}
	)

# REGISTER OUR ROUTES 
# all routes will be prefixed with /api
app.use('/api', router)

# START THE SERVER
app.listen(port)
console.log('Magic happens on port ' + port)