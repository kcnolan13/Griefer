var io = require('socket.io-client');
var socket = io.connect('http://www.puddlesquid.com:8080',{'connect timeout':5000, 'transports':['websocket']});

console.log("starting keepup utility");

socket.on("connect",function(){
	console.log("connected");
	setInterval(function(){
		//console.log(".");
		socket.emit("PING");
	}, 30000);
});

socket.on("disconnect",function(err){
	console.log("disconnected");
	if (err)
		console.log(err);
});

socket.on("PONG", function() {
	//console.log("p");
});