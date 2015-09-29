var cluster = require('cluster');
var os = require('os');
var http = require('http');
var redis = require("socket.io-redis");
var sio = require('socket.io');

if (cluster.isMaster) {
  // we create a HTTP server, but we do not use listen
  // that way, we have a socket.io server that doesn't accept connections
  var server = http.createServer();
  var io = sio.listen(server);
  io.adapter(redis({ host: 'localhost', port: 6379 }));

  setInterval(function() {
    // all workers will receive this in Redis, and emit
    io.emit('ping', 'butt ass donkey chicken');
  }, 5000);


  for (var i = 0; i < os.cpus().length; i++) {
    cluster.fork();
  }

  cluster.on('exit', function(worker, code, signal) {
    console.log('worker ' + worker.process.pid + ' died');
  }); 
}

if (cluster.isWorker) {
  var app = require("express")();
  var server = http.createServer(app);
  var io = sio.listen(server);

  server.listen(8080, function(err) {
    if (err) {
      console.log(err);
    } else {
      console.log('worker '+cluster.worker.id+' is listening on: *'+8080);
    }
  });

  io.on('connection', function(socket){
      console.log('socket connected to worker '+cluster.worker.id);
      socket.emit('ping','fecal urgency');
  });
  
  io.adapter(redis({ host: 'localhost', port: 6379 }));
}

