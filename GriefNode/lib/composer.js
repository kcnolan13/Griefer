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

var SOCKETS = "sock"

//LOAD MODULES
var log = require('./logger.js');
//var dealer_module = require('./build/Release/dealer');
//var dealer = new dealer_module.dealer(5);

//EXPORTS
var hash_string = function(string) {
	return string;
	/*
    var hash = 0;
    if (string.length == 0) return hash;
    for (var i = 0; i < string.length; i++) {
        var c = string.charCodeAt(i);
        hash = ((hash<<5)-hash)+c;
        //log.log(STD,"intermediary hash: "+hash)
        hash |= 0; // Convert to 32bit integer
        //log.log(STD,"after anding: "+hash)
    }
    //log.log(STD,"HASHED "+string+" ---> "+hash);
	hash = Math.abs(hash);
    //log.log(STD,"final result: "+hash);
    return hash;
    */
}
exports.hash_string = hash_string;

var ensureJSON = function(possibleStr)
{
	if (typeof possibleStr == "string")
  	{
  		possibleStr = possibleStr.substring(0,Math.max(possibleStr.length,possibleStr.indexOf("}")));
  		possibleStr = JSON.parse(possibleStr);
  	}
  	return possibleStr;
};
exports.ensureJSON = ensureJSON

var stripOuterCurlies = function(obj)
{
	var serialized = JSON.stringify(obj);
	if (serialized.indexOf('{') < serialized.indexOf('['))
	{
		var stripped = serialized.substring(serialized.indexOf('{'),serialized.lastIndexOf('}'));
		log.log(STD,'outer curlies stripped: '+stripped)
		return stripped
	}
	else 
	{
		log.log(STD,'outer curlies stripped: '+serialized);
		return serialized;
	}
}
exports.stripOuterCurlies = stripOuterCurlies

var generate_uniqueMatchId = function()
{
	return Math.ceil(Math.random()*1000000);
}
exports.generate_uniqueMatchId = generate_uniqueMatchId

var objUpdate = function(obj_index, unique_id, var_name, value, fl) {
	var message = {
			name: "objUpdate",
			oid_string: obj_index.toString()+":"+unique_id.toString(),
			object_index: obj_index,
			uniqueId: unique_id.toString(),
			netvar: var_name,
			val: value,
			flag: fl
		}
		//if (var_name == "pNum")
		//	log.log(CUPID,message);
	return message;
};
exports.objUpdate = objUpdate;

var objCreate = function(obj_index, unique_id, x, y) {
	var message = {
		name: "objCreate",
		object_index: obj_index,
		uniqueId: unique_id,
		myX: x,
		myY: y
	};
	return message
}
exports.objCreate = objCreate

var genMessage = function(message,value)
{
	var mess = {
		name: "generalMessage",
		msg: message,
		val: value
	}
	return mess
}
exports.genMessage = genMessage

var bigMessage = function(message,value1, value2, value3)
{
	var mess = {
		name: "bigMessage",
		msg: message,
		val1: value1,
		val2: value2,
		val3: value3
	}
	return mess
}
exports.bigMessage = bigMessage

var createPkg = function() {
	this.messages = [];
}
exports.createPkg = createPkg

//prints basic socket player info
var printPlayer = function(thePlayer) {
	return (thePlayer.pName+": "+thePlayer.gameMode+", "+thePlayer.room);
}
exports.printPlayer = printPlayer