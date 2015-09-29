//---- GLOBALS ----//
var globals = require('./globals.js');
var FL_NORMAL = global.FL_NORMAL; var FL_DECREMENT = global.FL_DECREMENT; var FL_INSTANCE_DESTROY = global.FL_INSTANCE_DESTROY;
var FL_SQL = global.FL_SQL; var FL_BOT = global.FL_BOT; var FL_MULTIPLE = global.FL_MULTIPLE; var FL_COMPETITIVE = global.FL_COMPETITIVE;
var FL_WIPE = global.FL_WIPE; var SQL = global.SQL; var CUPID = global.CUPID; var STD = global.STD; var CRITICAL = global.CRITICAL;
var num_game_rooms = global.num_game_rooms; var num_maps = global.num_maps; var avatarObjIndex = global.avatarObjIndex; var playerObjIndex = global.playerObjIndex;
var netManObjIndex = global.netManObjIndex; var lobby_wait_time = global.lobby_wait_time; var default_avatar_uniqueId = global.default_avatar_uniqueId
var default_netman_uniqueId = global.default_netman_uniqueId; var numTdm = global.numTdm; var numFfa = global.numFfa; var numVersus = global.numVersus;
var	numMenu = global.numMenu; var numBot = global.numBot; var numSockets = global.numSockets; var numBotFfa = global.numBotFfa; var numBotTdm = global.numBotTdm;
var NUM_BPARTS = global.NUM_BPARTS; var NUM_STATS = global.NUM_STATS; var clients = global.clients; var rooms = global.rooms;
var gravatarObjIndex = global.gravatarObjIndex;

var fs = require('fs');
var util = require('util');

//log flags
var SQL = "sql"
var CUPID = "cupid"
var STD = "std"
var CRITICAL = "err"
var SOCKETS = "sock"
var VERBOSE = "verbose"

var log_std;// = fs.createWriteStream(__dirname + '/../log/std.log', {flags : 'w'});
var log_cupid;// = fs.createWriteStream(__dirname + '/../log/cupid.log', {flags : 'w'});
var log_critical;// = fs.createWriteStream(__dirname + '/../log/critical.log', {flags : 'w'});
var log_sockets;// = fs.createWriteStream(__dirname+ '/../log/sockets.log', {flags : 'w'});
var log_sql;// = fs.createWriteStream(__dirname + '/../log/sql.log', {flags : 'w'});
var log_verbose;// = fs.createWriteStream(__dirname + '/../log/verbose.log', {flags : 'w'});
var log_stdout;// = process.stdout;
var initialized = false;

exports.init = function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""
	log_std = fs.createWriteStream(__dirname + '/../log/std.log'+wid, {flags : 'w'});
	log_cupid = fs.createWriteStream(__dirname + '/../log/cupid.log'+wid, {flags : 'w'});
	log_critical = fs.createWriteStream(__dirname + '/../log/critical.log'+wid, {flags : 'w'});
	log_sockets = fs.createWriteStream(__dirname+ '/../log/sockets.log'+wid, {flags : 'w'});
	log_sql = fs.createWriteStream(__dirname + '/../log/sql.log'+wid, {flags : 'w'});
	log_verbose = fs.createWriteStream(__dirname + '/../log/verbose.log'+wid, {flags : 'w'});
	log_stdout = process.stdout;
	initialized = true;
};



exports.log = function(flag,text) { 
	if (initialized)
	{
		if (flag == SQL)
			log_sql.write(util.format(text) + '\n');
		else if (flag == CUPID)
			log_cupid.write(util.format(text) + '\n');
		else if (flag == CRITICAL) {
			log_critical.write(util.format(text) + '\n');
			console.log("ERROR: "+text);
		}
		else if (flag == STD)
			log_std.write(util.format(text) + '\n');
		else if (flag == SOCKETS)
			log_sockets.write(util.format(text) + '\n');
		else if (flag == VERBOSE)
			log_verbose.write(util.format(text) + '\n');
		else
			log_stdout.write(util.format(text) + '\n');
	}
	else
	{
		//console.log(text);
	}
};

var std_cleaner = setInterval(function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""

	var stats = fs.statSync(__dirname + '/../log/std.log'+wid);
	var fsize_mb = stats["size"]/1000000.0;
	//console.log("\n\nLog File Size: "+fsize_mb+" MegaBytes\n\n");
	if (fsize_mb > 5)
	{
		log_std = fs.createWriteStream(__dirname + '/../log/std.log'+wid, {flags : 'w'});
	}
}, 100000);

var verbose_cleaner = setInterval(function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""

	var stats = fs.statSync(__dirname + '/../log/verbose.log'+wid);
	var fsize_mb = stats["size"]/1000000.0;
	//console.log("\n\nLog File Size: "+fsize_mb+" MegaBytes\n\n");
	if (fsize_mb > 5)
	{
		log_std = fs.createWriteStream(__dirname + '/../log/verbose.log'+wid, {flags : 'w'});
	}
}, 100000);

var cupid_cleaner = setInterval(function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""

	var stats = fs.statSync(__dirname + '/../log/cupid.log'+wid);
	var fsize_mb = stats["size"]/1000000.0;
	//console.log("\n\nLog File Size: "+fsize_mb+" MegaBytes\n\n");
	if (fsize_mb > 5)
	{
		log_cupid = fs.createWriteStream(__dirname + '/../log/cupid.log'+wid, {flags : 'w'});
	}
}, 101000);

var critical_cleaner = setInterval(function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""

	var stats = fs.statSync(__dirname + '/../log/critical.log'+wid);
	var fsize_mb = stats["size"]/1000000.0;
	//console.log("\n\nLog File Size: "+fsize_mb+" MegaBytes\n\n");
	if (fsize_mb > 5)
	{
		log_critical = fs.createWriteStream(__dirname + '/../log/critical.log'+wid, {flags : 'w'});
	}
}, 102000);

var sql_cleaner = setInterval(function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""

	var stats = fs.statSync(__dirname + '/../log/sql.log'+wid);
	var fsize_mb = stats["size"]/1000000.0;
	//console.log("\n\nLog File Size: "+fsize_mb+" MegaBytes\n\n");
	if (fsize_mb > 10)
	{
		log_sql = fs.createWriteStream(__dirname + '/../log/sql.log'+wid, {flags : 'w'});
	}
}, 103000);

var sockets_cleaner = setInterval(function() {
	if (!global.cluster.isMaster)
		var wid = global.cluster.worker.id;
	else
		var wid = ""

	var stats = fs.statSync(__dirname + '/../log/sockets.log'+wid);
	var fsize_mb = stats["size"]/1000000.0;
	//console.log("\n\nLog File Size: "+fsize_mb+" MegaBytes\n\n");
	if (fsize_mb > 5)
	{
		log_sockets = fs.createWriteStream(__dirname + '/../log/sockets.log'+wid, {flags : 'w'});
	}
}, 104000);




var syncVersionHash = function() {
	fs.readFile('C:\\inetpub\\wwwroot\\griefer\\release\\config.txt','utf8', function(err, data) {
		if (err) {
			return console.log(err);
		}
		else {
			exports.log(STD,"Current Griefer Version: "+data);
			global.version_hash = data;
		}
	});
}
exports.syncVersionHash = syncVersionHash;