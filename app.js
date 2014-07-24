// Generated by CoffeeScript 1.7.1
(function() {
  var Bear, app, bodyParser, express, mongoose, port, router;

  express = require('express');

  app = express();

  bodyParser = require('body-parser');

  mongoose = require('mongoose');

  Bear = require('./models/bear');

  mongoose.connect('mongodb://node:node@novus.modulusmongo.net:27017/Iganiq8o');

  app.use(bodyParser());

  port = process.env.PORT || 8080;

  router = express.Router();

  router.use(function(req, res, next) {
    console.log('something is happening');
    return next();
  });

  router.get('/', function(req, res) {
    return res.json({
      message: 'hooray! welcome to our api!'
    });
  });

  router.route('/bears').post(function(req, res) {
    var bear;
    bear = new Bear();
    bear.name = req.body.name;
    return bear.save(function(err) {
      if (err) {
        res.send(err);
      }
      return res.json({
        message: 'Bear with name ' + bear.name + ' created!'
      });
    });
  }).get(function(req, res) {
    return Bear.find(function(err, bears) {
      if (err) {
        res.send(err);
      }
      return res.json(bears);
    });
  });

  router.route('/bears/:bear_id').get(function(req, res) {
    return Bear.findById(req.params.bear_id, function(err, bear) {
      if (err) {
        res.send(err);
      }
      return res.json(bear);
    });
  }).put(function(req, res) {
    return Bear.findById(req.params.bear_id, function(err, bear) {
      if (err) {
        res.send(err);
      }
      bear.name = req.body.name;
      return bear.save(function(err) {
        if (err) {
          res.send(err);
        }
        return res.json({
          message: 'Bear with name ' + bear.name + ' updated!'
        });
      });
    });
  })["delete"](function(req, res) {
    return Bear.remove({
      _id: req.params.bear_id
    }, function(err, bear) {
      if (err) {
        res.send(err);
      }
      return res.json({
        message: 'Bear deleted!'
      });
    });
  });

  app.use('/api', router);

  app.listen(port);

  console.log('Magic happens on port ' + port);

}).call(this);
