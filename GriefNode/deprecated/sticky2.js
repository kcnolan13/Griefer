var sticky =  require('sticky-session'),
	cluster = require('cluster'),
	redis =  require('socket.io-redis');

var server = require('http').createServer(function(req, res) {
  res.end('worker: ' + process.env.NODE_WORKER_ID);
});

if (!sticky.listen(server, 8081)) {
  //MASTER CODE
  server.once('listening', function() {
    console.log('server started on 8081 port');
  });

  var io = require('socket.io').listen(server);
  io.adapter(redis({ host: 'localhost', port: 6379 }));

  setInterval(function() {
    // all workers will receive this in Redis, and emit
    io.emit('ping', 'butt ass donkey chicken');
  }, 5000);


} else {

  //WORKER CODE

  var express = require('express');
  var app = express();
  var http = require('http');
  var server2 = http.createServer(app);
  io = require('socket.io').listen(server2);

  server2.listen(8080, function(err) {
    if (err) {
      console.log(err);
    } else {
      console.log('worker is listening on: *'+8080);
    }
  });

  io.on('connection', function(socket){
      console.log('socket connected to worker '+cluster.worker.id);
      socket.emit('ping','fecal urgency');
  });

  io.adapter(redis({ host: 'localhost', port: 6379 }));
}