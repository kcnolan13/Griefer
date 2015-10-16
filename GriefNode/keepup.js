var io = require('socket.io-client');
var fs = require('fs');
var cs = require('console-stamp')(console, 'HH:MM:ss');

var target = 'http://griefer.cloudapp.net:8080';
var arg = process.argv[2];
if (arg == "puddlesquid") {
	target = 'http://www.puddlesquid.com:8080';
}

var socket = io.connect(target,{'connect timeout':5000, 'transports':['websocket']});
process.stdout.write("\n");
console.log("starting keepup: "+target);

socket.on("connect",function(){
	console.log("connected");
	setInterval(function(){
		process.stdout.write(".");
		socket.emit("PING");
	}, 10000);
});

setTimeout(function(){
	console.log("ending keepup\n");
	process.exit();
},50000);

socket.on("disconnect",function(err){
	console.log("disconnected prematurely\n");
	if (err)
		console.log(err);
	process.exit();
});

socket.on("PONG", function() {
	process.stdout.write("p");
});

if (arg == "puddlesquid")
{
	var log = fs.statSync('/var/log/keepup');
	var fsize_mb = log["size"]/1000000.0;
	if (fsize_mb > 5)
	{
		console.log("Clearing Keepup Log. Size was: "+fsize_mb+" MB\n\n");
		log_std = fs.createWriteStream('/var/log/keepup', {flags : 'w'});
	}

	log = fs.statSync('/var/log/keepup_azure');
	var fsize_mb = log["size"]/1000000.0;
	if (fsize_mb > 5)
	{
		console.log("Clearing Keepup Log. Size was: "+fsize_mb+" MB\n\n");
		log_std = fs.createWriteStream('/var/log/keepup', {flags : 'w'});
	}

	log = fs.statSync('/var/log/griefer');
	fsize_mb = log["size"]/1000000.0;
	if (fsize_mb > 5)
	{
		console.log("Clearing Griefer Log. Size was: "+fsize_mb+" MB\n\n");
		log_std = fs.createWriteStream('/var/log/griefer', {flags : 'w'});
	}
}