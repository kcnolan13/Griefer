var cluster = require('cluster');
var os = require('os');

//---- LISTEN ON PORT 3000 ----//
/*
http.listen(8080, function(){
  console.log('listening on *:'+8080);
});

//---- PRIMARY SERVER LOGIC ----//
io.on('connection', function(socket){
  socket.emit('ping','fecal urgency');
});
*/

if (cluster.isMaster) {
  // we create a HTTP server, but we do not use listen
  // that way, we have a socket.io server that doesn't accept connections
  var server = require('http').createServer();
  var io = require('socket.io').listen(server);
  var redis = require('socket.io-redis');

  io.adapter(redis({ host: 'localhost', port: 6379 }));

  setInterval(function() {
    // all workers will receive this in Redis, and emit
    io.emit('ping', 'butt ass donkey chicken');
  }, 1000);

  for (var i = 0; i < os.cpus().length; i++) {
    cluster.fork();
  }

  cluster.on('exit', function(worker, code, signal) {
    console.log('worker ' + worker.process.pid + ' died');
  }); 
}

if (cluster.isWorker) {
 
  var express = require('express');
  var app = express();
  var http = require('http');
  var server = http.createServer(app);
  io = require('socket.io').listen(server);

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
  
  //var adapter = adapter('localhost:6379');
  //adapter.pubClient.on('error', function(){});
  //adapter.subClient.on('error', function(){});
}

