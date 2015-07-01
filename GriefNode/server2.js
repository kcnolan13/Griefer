ioClient = require('socket.io-client')
var socket = ioClient.connect('http://puddlesquid.com:8080');

emitMessage(socket);

/*socket.on('connect', function () {
  // socket connected
  console.log('connected, BITCH');
  //socket.emit('server custom event', { my: 'data' });

	var response = {
	  		name: "generalMessage",
	  		msg: "pint",
	  		val: 0
		};

	socket.emit('general_message',response);
});

socket.on('general_message',function() {
	console.log('\nPING\n');
});*/

function emitMessage( socket ){
        socket.emit('my other event', { my: 'data' });
        setTimeout(function(){emitMessage(socket)}, 1000);
        console.log("connected: "+socket.connected);
    }

socket.on('ping',function(){
	console.log("PING!!!");
})

/*
socket.on('connect', function () {
  // socket connected
  socket.emit('server custom event', { my: 'data' });
});



   if ( app.get('port') == 3000 ){

io.listen(server).sockets.on('connection', function (socket) {
      socket.on('my other event', function (data) {
        console.log(data);
      });
    });
}else{
    function emitMessage( socket ){
        socket.emit('my other event', { my: 'data' });
        setTimeout(function(){emitMessage(socket)}, 1000);
    }
    var socket = ioClient.connect("http://localhost:3000");
    emitMessage(socket);
}*/