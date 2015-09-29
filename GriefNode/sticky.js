var cluster = require('cluster');
var sticky = require('sticky-session');
var http   = require('http');

if (cluster.isMaster) {
  for (var i = 0; i < 4; i++) {
    cluster.fork();
  }

  Object.keys(cluster.workers).forEach(function(id) {
    console.log("Worker running with ID : " + 
      cluster.workers[id].process.pid);
  });
}

if (cluster.isWorker) {
  var anotherServer = http.createServer(function(req, res) {
    res.end('hello world!');
  });
  anotherServer.listen(8081);
  console.log('http server on 8081');
}

sticky(function() {
  var io = require('socket.io')();

  var server = http.createServer(function(req, res) {
    res.end('socket.io');
  });

  io.listen(server);

  io.on('connection', function onConnect(socket) {
    console.log('someone connected.');

    socket.on('sync', sync);
    socket.on('send', send);

    function sync(id) {
      socket.join(id);
      console.log('someone joined ' + id);
    }

    function send(id, msg) {
      io.sockets.in(id).emit(msg);
      console.log('someone sent ' + msg + ' to ' + id);
    }
  });

  return server;
}).listen(8080, function() {
  console.log('socket.io server on 8080')
});