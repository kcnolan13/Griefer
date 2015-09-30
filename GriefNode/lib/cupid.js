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
var gravatarObjIndex = global.gravatarObjIndex; var SOCKETS = "sock"

var io;
var conn;

//LOAD MODULES
var util = require('util');
var log = require('./logger.js');
var dbman = require('./dbman.js');
var composer = require('./composer.js');

//default 'main_menu' group ----> all room objects in the rooms array should have these properties
var main_menu = {
	groupName: "main_menu",
	modeName: "no mode",
	maxPlayers: "-1",
	minPlayers: "-1"
};
main_menu.fsockets = [];
rooms.push(main_menu);

//this basically makes player objects
var player = function(){
	this.pName = "John Doe";
	this.gameMode = "no_mode"; //can be ffa, tdm, or versus
	this.room = "no_room";
	this.uniqueId = "-1";
	this.uniqueMatchId = -51;
	this.nextMap1 = -54;
	this.nextMap2 = -54;
	this.nextMap3 = -54;
	this.nextMapVote = -1;
	this.nextMap = -54;
}
exports.player = player

//this basically makes room objects
var room = function(groupName, modeName, maxPlayers, minPlayers) {
	this.groupName = groupName;
	this.modeName = modeName;
	this.maxPlayers = maxPlayers;
	this.minPlayers = minPlayers;
	this.joinable = false;
	this.party = false;
	this.match_countdown_timeout = null;
	this.match_start_timeout = null;
	this.fsockets = [];
};
exports.room = room

var myTimeout = function(fn, ms, arg1, arg2, arg3, arg4) {
    this.ms = ms;
    this.fn = fn;
    this.arg1 = arg1; //player subgroup
    this.arg2 = arg2; //unique match id
    this.arg3 = arg3; //gameRoom name
    this.arg4 = arg4; //shuffler id
    this.timer = null;
    this.init();
};
exports.myTimeout = myTimeout

myTimeout.prototype.init = function() {
    this.cancel();
    this.timer = setTimeout(this.fn, this.ms, this.arg1, this.arg2, this.arg3, this.arg4);
    log.log("verbose","initialized myTimeout for "+this.ms+" ms");
    return this;
};

myTimeout.prototype.change = function(ms) {
	//log.log(STD,"changing ms from "+this.ms+" to "+ms);
    this.ms = ms;
    this.init();
    return this;
};

myTimeout.prototype.cancel = function() {
    if ( this.timer != null ) {
    	log.log("verbose", "clearing a timeout");
        clearTimeout(this.timer);
        this.timer = null;
    }
    return this;
};

//define game mode constants as vars in these global objects
var tdm = new room("tdm", "tdm", 4, 2);
var ffa = new room("ffa", "ffa", 3, 2);
var versus = new room("versus", "versus", 2, 2);
var party = new room("party", "party", 4, 1);
var bot_tdm = new room("bot_tdm", "bot_tdm", 4, 1);
var bot_ffa = new room("bot_ffa", "bot_ffa", 3, 1);
var bot_versus = new room("bot_versus", "bot_versus", 2, 1);

//acquire connection to db when ready
var getConn = setInterval(function(){
	if (global.conn_ready = true)
	{
		conn = dbman.getConn();
		clearInterval(getConn);
	}
	},100);

//EXPORTS
exports.setIo = function(io_2set) {
	io = io_2set
};

var objUpdate = function(socket, obj_index, unique_id, var_name, value, fl) {
	var message = composer.objUpdate(obj_index, unique_id, var_name, value, fl);
	socket.emit('obj_update',message);
};
exports.objUpdate = objUpdate;

var objCreate = function(socket, obj_index, unique_id, x, y) {
	var message = composer.objCreate(obj_index, unique_id, x, y);
	socket.emit('obj_create',message);
}
exports.objCreate = objCreate

var genMessage = function(socket, message, value) {
	var msg = composer.genMessage(message,value);
	socket.emit('general_message',msg);
}
exports.genMessage = genMessage

var bigMessage = function(socket, message, value1, value2, value3) {
	var msg = composer.bigMessage(message, value1, value2, value3);
	socket.emit('big_message',msg);
}
exports.bigMessage = bigMessage

//returns an array of the sockets grouped in a certain room
var socketsInRoom = function(roomName) {

	if (!global.MULTITHREAD) {
		namespace = "/";
		var theSockets = [];
		var roomsweep = [];
		if (roomName=="all")
		{
			for (var i=0; i<rooms.length; i++)
			{
				roomsweep.push(rooms[i].groupName);
			}
		}
		else
		{
			roomsweep.push(roomName);
		}
		for (var i=0; i<roomsweep.length; i++)
		{
			var datRoom = roomsweep[i];
			for (var socketId in io.nsps[namespace].adapter.rooms[datRoom]) {
				if (io.sockets.connected[socketId]!=undefined) //was myPlayer.pName
			    	theSockets.push(io.sockets.connected[socketId]);
			}
		}
		return theSockets;

	}
	else {
		if (roomName == "all") {
			var theSockets = [];
			for (var i=0; i<global.rooms.length; i++) {
				for (var j=0; j<global.rooms[i].fsockets.length; j++) {
					theSockets.push(global.rooms[i].fsockets[j]);
				}
			}
			return theSockets;
		} 
		else 
		{
			var room = ds_find_room(roomName);
			if (room) {
				return room.fsockets;
			} else {
				log.log(CRITICAL,"socketsInRoom has no handle to "+roomName);
			}
		}
	}
}
exports.socketsInRoom = socketsInRoom;

//WORKER ONLY
var worker_join_room = function(socket, groupNameTo) {
	var groupNameFrom = socket.myPlayer.room;

	if (socket.myPlayer.room != "") {
		socket.leave(socket.myPlayer.room);
	}
	socket.myPlayer.room = groupNameTo;
	socket.join(groupNameTo);

	if (global.MULTITHREAD) {
  		process.send({id:'player_join_room',fsocket:composer.fsocket(socket),groupNameFrom:groupNameFrom,groupNameTo:groupNameTo});
  	}
};
exports.worker_join_room = worker_join_room;

//MASTER ONLY
var master_join_room = function(socket, groupName) {
	if (global.MULTITHREAD) {
		io.to(player.room).emit('player_join_room',socket.myPlayer.pName,groupName);
		ds_migrate_player(socket.myPlayer.pName, socket.myPlayer.room, groupName)
	}
	else {
		socket.myPlayer.room = groupName;
		socket.leave(groupName);
		socket.join(groupName);
	}
};
exports.master_join_room = master_join_room;

var ds_migrate_player = function(pName, groupNameFrom, groupNameTo) {
	var roomFrom = ds_find_room(groupNameFrom);
	var roomTo = ds_find_room(groupNameTo);
	var fsocket_index = ds_find_fsocket_index(pName, roomFrom)
	if (roomFrom && roomTo && fsocket_index >= 0) {
		var fsocket = roomFrom.fsockets.splice(fsocket_index,1);
		fsocket.myPlayer.room = groupNameTo;
		roomTo.fsockets.push(fsocket);
		log.log(CUPID,pName+" ds_migrated from "+roomFrom.groupName+" to "+roomTo.groupName);
	}
	else {
		log.log(CRITICAL, "Unable to ds_migrate player "+pName+" from "+groupNameFrom+" to "+groupNameTo);
		return false;
	}
} 
exports.ds_migrate_player = ds_migrate_player;

var ds_find_room = function(groupName) {
	for (var i=0; i<global.rooms.length; i++) {
		if (global.rooms[i].groupName == groupName) {
			return global.rooms[i];
		}
	}
	log.log(CRITICAL,"Unable to locate ds_room with groupName "+groupName);
	return null;
} 
exports.ds_find_room = ds_find_room;

var ds_find_fsocket_index = function(pName, room) {
	for (var i=0; i<room.fsockets.length; i++) {
		if (room.fsockets[i].myPlayer.pName == pName) {
			return i;
		}
	}
	log.log(CRITICAL,"Unable to find "+pName+" fsocket in room "+room.groupName);
	return -1;
} 
exports.ds_find_fsocket_index = ds_find_fsocket_index;

var ds_find_fsocket = function(pName, room) {
	if (room) {
		for (var i=0; i<room.fsockets.length; i++) {
			if (room.fsockets[i].myPlayer.pName = pName) {
				return room.fsockets[i];
			}
		}
		log.log(CRITICAL,"Unable to find "+pName+" fsocket in room "+room.groupName);
		return null;
	} else {
		var rcount = 0;
		var fcount = 0;
		for (var i=0; i<global.rooms.length; i++) {
			rcount++;
			var r = global.rooms[i];
			for (var j=0; j<r.fsockets.length; j++) {
				fcount++;
				if (r.fsockets[j].myPlayer.pName == pName) {
					return r.fsockets[j];
				}
			}
		}
		log.log(CRITICAL,"Unable to find "+pName+" in any room (searched "+rcount+" rooms, "+fcount+" fsockets)");
		return null;
	}
}

var ds_destroy_fsocket = function(pName, room) {
	if (room) {
		console.log("looking to destroy "+pName+"'s fsocket in room "+room.groupName);
		for (var i=0; i<room.fsockets.length; i++) {
			if (room.fsockets[i].myPlayer.pName = pName) {
				room.fsockets.splice(i,1);
				return true;
			}
		}
		log.log(CRITICAL,"Unable to destroy "+pName+" fsocket in room "+room.groupName);
	} 

	//looks everywhere if not narrowed to a particular room or not found there
	var rcount = 0;
	var fcount = 0;
	for (var i=0; i<global.rooms.length; i++) {
		rcount++;
		var r = global.rooms[i];
		for (var j=0; j<r.fsockets.length; j++) {
			fcount++;
			if (r.fsockets[j].myPlayer.pName == pName) {
				r.fsockets.splice(j,1);
				console.log("destroyed "+pName+"'s fsocket in room "+r.groupName);
				return true;
			}
		}
	}
	log.log(CRITICAL,"Unable to destroy "+pName+" fsocket in any room (searched "+rcount+" rooms, "+fcount+" fsockets)");
	return false;
}
exports.ds_destroy_fsocket = ds_destroy_fsocket;

var roomOfMode = function(mode_name) {
	if (mode_name == "tdm")
		return tdm;
	else if (mode_name == "ffa")
		return ffa;
	else if (mode_name == "versus")
		return versus;
	else if (mode_name == "party")
		return party;
	else if (mode_name == "bot_tdm")
		return bot_tdm;
	else if (mode_name == "bot_ffa")
		return bot_ffa;
	else if (mode_name == "bot_versus")
		return bot_versus;
	else log.log(CRITICAL,"ERROR: roomOfMode passed: "+mode_name);
}
exports.roomOfMode = roomOfMode;

var room_player1 = function(gameRoom)
{
	var playerSubGroup = socketsInRoom(gameRoom);

	if (playerSubGroup.length > 0)
	{
		return playerSubGroup[0].myPlayer;
	} else return null;
	
	/*var p1 = null;

	for (var i=0; i<playerSubGroup.length; i++)
	{
		if (playerSubGroup[i].myPlayer.pNum == 0)
		{
			p1 = playerSubGroup[i].myPlayer;
			return p1;
		}
	}

	return null;*/
} 
exports.room_player1 = room_player1;

exports.initGameRooms = function() {
	//create several game socket groups and 1 lobby socket group for each game mode
	for (var i=0; i<6; i++)
	{
		for (var j=0; j<1+num_game_rooms; j++)
		{
			var newRoom, fromType;
			if (i==0)
				fromType=tdm;
			else if (i==1)
				fromType=ffa;
			else if (i==2)
				fromType=versus;
			else if (i==3)
				fromType=bot_tdm;
			else if (i==4)
				fromType=bot_ffa;
			else if (i==5)
				fromType=bot_versus;

			newRoom = new room(fromType.groupName, fromType.modeName, fromType.maxPlayers, fromType.minPlayers);

			if (j==0)
				newRoom.groupName+="_lobby";
			else
				newRoom.groupName+=j;

			rooms.push(newRoom);
		}
	}
};

var switchPartyMode = function(socket,room,new_mode) {
	var roomType = roomOfMode(new_mode);
	if (socktesInRoom(room).length > roomType.maxPlayers)
	{
		genMessage(socket,"too_many_players",FL_NORMAL);
		log.log(CUPID,"too many players to switch party type to "+new_mode+" for room: "+room);
		return false;
	}
	else
	{
		room.modeName = new_mode;
		room.maxPlayers = roomType.maxPlayers;
		room.minPlayers = roomType.minPlayers;
		return true;
	}
}

//prints players in each room / socket group and shows general net stats
exports.manageSockets = function() {

	numSockets = 0;
	numTdm = 0;
	numFfa = 0;
	numVersus = 0;
	numMenu = 0;
	numBot = 0;
	numBotFfa = 0;
	numBotTdm = 0;

	var socket_str = "\n\nNew Socket Report:\n";

	for (var i=0; i<global.rooms.length; i++)
	{
		var sockets = [];
		sockets = socketsInRoom(global.rooms[i].groupName);

		//collect network stats
		numSockets += sockets.length;

		if ((global.rooms[i].groupName.indexOf("bot") < 0)&&(global.rooms[i].groupName.indexOf("ffa") > -1))
			numFfa += sockets.length;
		else if ((global.rooms[i].groupName.indexOf("bot") < 0)&&(global.rooms[i].groupName.indexOf("tdm") > -1))
			numTdm += sockets.length;
		else if ((global.rooms[i].groupName.indexOf("bot") < 0)&&(global.rooms[i].groupName.indexOf("versus") > -1))
			numVersus += sockets.length;
		else if (global.rooms[i].groupName.indexOf("bot_versus") > -1)
			numBot += sockets.length;
		else if (global.rooms[i].groupName.indexOf("bot_ffa") > -1)
			numBotFfa += sockets.length;
		else if (global.rooms[i].groupName.indexOf("bot_tdm") > -1)
			numBotTdm += sockets.length;
		else if (global.rooms[i].groupName.indexOf("menu") > -1)
			numMenu += sockets.length;

		//end network stats
		var playerNames = "";
		for (var j=0; j<sockets.length; j++) {
			playerNames += sockets[j].myPlayer.pName+" ["+sockets[j].myPlayer.uniqueId+", # "+sockets[j].myPlayer.pNum+"]";

			if (j<sockets.length-1)
				playerNames += ", ";
		}
		socket_str += "\n\t"+rooms[i].groupName+": "+playerNames;
	}

	socket_str += "\n"+"\n\nPlayers Online: "+numSockets+"\nPlaying TDM: "+numTdm+"\nPlaying FFA: "+numFfa+"\nPlaying Verus: "+numVersus+"\nPlaying Bot_Verus: "+numBot+"\nPlaying Bot_Ffa: "+numBotFfa+"\nPlaying Bot_Tdm: "+numBotTdm+"\n\n\n"
	if (global.socket_str != socket_str) {
		log.log(SOCKETS,socket_str);
		global.socket_str = socket_str;
	} else {
		log.log("verbose","no new data ... skipping socket report");
	}
}

exports.syncPlayersConnected = function(){
	log.log(CUPID,"SYNCHRONIZING PLAYERS CONNECTED");
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "ffa_players_online", numFfa, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "ffa_players_online", numFfa, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "versus_players_online", numVersus, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "tdm_players_online", numTdm, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "bot_versus_players_online", numBot, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "bot_ffa_players_online", numBotFfa, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "bot_tdm_players_online", numBotTdm, FL_NORMAL));
	io.emit('obj_update',composer.objUpdate(netManObjIndex, -1, "players_online", numSockets, FL_NORMAL));
}

var partyExpired = function(groupName) {
	for (var i=0; i<rooms.length; i++)
	{
		if (rooms[i].groupName == groupName)
		{
			log.log(CUPID,"party has not expired: "+groupName);
			return false;
		}
	}
	log.log(CUPID,"party has EXPIRED: "+groupName);
	return true;
}
exports.partyExpired = partyExpired;

function check_match_expired(playerSubGroup, uniqueMatchId, gameRoom)
{
	var pCount = 0;
	//make sure match is still valid
	for (var i=0; i<playerSubGroup.length; i++)
	{
		//abort this operation if none of the players are in this room anymore
		if (playerSubGroup[i])
		{
			if ((playerSubGroup[i].myPlayer.room == gameRoom)&&(playerSubGroup[i].myPlayer.uniqueMatchId == uniqueMatchId))
			{
				pCount++;
				log.log(CUPID,playerSubGroup[i].myPlayer.pName+": match still good");
			}
		}
	}

	if (pCount < room_with_name(gameRoom).minPlayers)
	{
		log.log(CUPID,"THIS MATCH HAS EXPIRED");
		return true;
	} else {
		return false;
	}
}

var shuffle_teams = function(room)
{
	var playas = [];
	playas = socketsInRoom(room.groupName);

	if (playas.length == 1)
	{
		log.log(CUPID,"Bot match -- no need to shuffle");
		return false;
	}

	var playa_names = "";
	for (var i=0; i<playas.length; i++)
	{
		playa_names += "  ... "+playas[i].myPlayer.pName;
	}

	log.log(CUPID,"Shuffling Teams for match group "+playa_names);

	var possible_nums = []
	for (var i=0; i<playas.length; i++)
	{
		possible_nums.push(i);
	}

	for (var i=0; i<playas.length; i++)
	{
		var ind = Math.floor(Math.random()*(possible_nums.length-0.0000001));

		var dirty_num = possible_nums.splice(ind,1);
		var num = dirty_num[0]

		log.log(CUPID,"Reassigning pNum for "+playas[i].myPlayer.pName+" : "+playas[i].myPlayer.pNum+" ---> "+num);
		playas[i].myPlayer.pNum = num;
		var message = composer.objUpdate(avatarObjIndex,playas[i].myPlayer.uniqueId,"pNum",playas[i].myPlayer.pNum,FL_NORMAL);
		log.log("verbose",message);
		io.to(room.groupName).emit('obj_update',message);
	}
	return true;
}
exports.shuffle_teams = shuffle_teams

function find_joinable_game_room(starting_room_offset, mode_name, playerSubGroup)
{
	var i = starting_room_offset+1; //don't want to include the friggin lobby, so add 1
	var datRoom = rooms[i];

	//BOT MATCHES NOT JOINABLE AT THIS POINT
	if (datRoom.groupName.indexOf("bot") > -1)
		return false;

	while (datRoom.groupName.indexOf(mode_name) > -1)
	{
		log.log(CUPID,"\t..checking: "+datRoom.groupName);
		log.log(CUPID,"\t\tjoinable: "+datRoom.joinable+", socketsInRoom: "+socketsInRoom(datRoom.groupName).length);
		if ((datRoom.joinable)&&(socketsInRoom(datRoom.groupName).length > 0))
		{
			//are there few enough players to support this many additions
			var num_incoming_players = playerSubGroup.length;
			log.log(CUPID,"\t\t"+num_incoming_players+" prospective incoming players ... ");
			if (datRoom.maxPlayers >= socketsInRoom(datRoom.groupName).length+num_incoming_players)
			{
				log.log(CUPID,"\t\t\t"+datRoom.groupName+" is joinable for "+num_incoming_players);
				return datRoom;
			}
		}
		i++;
		if (i<rooms.length)
			datRoom = rooms[i];
		else break;
	}
	return false;
}

var room_with_name = function(roomName)
{
	for (var i=0; i<rooms.length; i++)
	{
		if (rooms[i].groupName == roomName)
		{
			return rooms[i];
		}
	}	
	return false;
}
exports.room_with_name = room_with_name

var player_in_array = function(player,array)
{
	for (var i=0; i<array.length; i++)
	{
		if (array[i].myPlayer.pName == player.myPlayer.pName)
			return true;
	}		
	return false;
}
exports.player_in_array = player_in_array

var force_sync_doll = function(socket)
{
	genMessage(socket,"force_sync_doll",FL_NORMAL);
}
exports.force_sync_doll = force_sync_doll


var configure_match = function(playerSubGroup, gameRoom, wait_time) {
	//generate unique match id for intelligent timeout function expiration
	var dat_num = composer.generate_uniqueMatchId();
	var obj_gameRoom = room_with_name(gameRoom);

	//make this room joinable
	if (obj_gameRoom.party == false)
		room_with_name(gameRoom).joinable = true;

	//determine the next map
	var mapNum1 = Math.floor((Math.random() * num_maps));

	var mapNum2 = Math.floor((Math.random() * num_maps));
	var loops = 0;
	while (mapNum2 == mapNum1 && loops < 100)
	{
		mapNum2 = Math.floor((Math.random() * num_maps));
		loops++
	}
	
	var mapNum3 = Math.floor((Math.random() * num_maps));
	loops = 0;
	while (loops < 100 && (mapNum3 == mapNum1 || mapNum3 == mapNum2))
	{
		mapNum3 = Math.floor((Math.random() * num_maps));
		loops ++;
	}

	var dat_wait_time = wait_time;
	log.log(CUPID,"dat_wait_time was: "+dat_wait_time);

	for (var s=0; s<playerSubGroup.length; s++)
	{
		var eachSocket = playerSubGroup[s];
		eachSocket.myPlayer.uniqueMatchId = dat_num;
		eachSocket.myPlayer.nextMap1 = mapNum1;
		eachSocket.myPlayer.nextMap2 = mapNum2;
		eachSocket.myPlayer.nextMap3 = mapNum3;
		eachSocket.myPlayer.nextMapVote = -1;
		eachSocket.myPlayer.nextMap = -54;
	}

	setTimeout(function(gameRoom,waitin_time) {
		
		//update next_map
		var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map1",mapNum1,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);
		message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map2",mapNum2,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);
		message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map3",mapNum3,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);

		//update lobby wait time
		var new_wait_time = Math.ceil((waitin_time-1000)/1000*30)
		log.log(CUPID,"waitin_time: "+waitin_time+" ---> "+new_wait_time);
		var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"lobby_wait_time",new_wait_time,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);
		log.log(CUPID,"sending lobby_wait_time: "+message);
	},1000,gameRoom,dat_wait_time);
	
	//send save and quit armory message with plenty of time left over (10 seconds)
	obj_gameRoom.match_countdown_timeout = new myTimeout(function(playerSubGroup, uniqueMatchId, gameRoom) {

		log.log(CUPID,"recomputing playerSubGroup to be inclusive of newly joined players");
		playerSubGroup = socketsInRoom(gameRoom);
		log.log(CUPID,"new playerSubGroup: "+playerSubGroup.length+" players");

		if (check_match_expired(playerSubGroup, uniqueMatchId, gameRoom))
		{
			log.log(CUPID,"aborting the save/quit armory command");
			return false;
		}

		var blah = composer.genMessage("lock_armory",0);
		log.log(CUPID,blah.name+" : "+blah.msg+" : "+blah.val);
		io.to(gameRoom).emit('general_message',blah);

		//send starting match countdown wait time
		var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"lobby_wait_time",global.starting_match_time/1000*global.fps,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);
		log.log(CUPID,"sending lobby_wait_time to room "+gameRoom+" for starting match coutdown time:");
		log.log(CUPID,message);

		//perform next map voting
		var votes1 = 0;
		var votes2 = 0;
		var votes3 = 0;
		var next_map = -54;

		//total up votes
		for (var p=0; p<playerSubGroup.length; p++)
		{
			var playa = playerSubGroup[p].myPlayer;
			log.log(CUPID,"nextMapVote = "+playa.nextMapVote+"nextMap1 = "+playa.nextMap1+", nextMap2 = "+playa.nextMap2+", nextMap3 = "+playa.nextMap3);
			if (playa.nextMapVote == playa.nextMap1)
			{
				votes1++;
			} else if (playa.nextMapVote == playa.nextMap2)
			{
				votes2++;
			} else if (playa.nextMapVote == playa.nextMap3)
			{
				votes3++;
			}
		}

		//determine next map

		//default to first map
		if (votes1 == votes2 && votes2 >= votes3)
			next_map = playerSubGroup[0].myPlayer.nextMap1;
		else
		{
			if (votes1 > votes2 && votes1 >= votes3)
				next_map = playerSubGroup[0].myPlayer.nextMap1;
			else if (votes2 > votes1 && votes2 >= votes3)
				next_map = playerSubGroup[0].myPlayer.nextMap2;
			else if (votes3 > votes1 && votes3 > votes2)
				next_map = playerSubGroup[0].myPlayer.nextMap3;
			else
				next_map = playerSubGroup[0].myPlayer.nextMap3;
		}

		if (next_map < 0)
		{
			log.log(CRITICAL,"bad next map picked: "+next_map);
		}

		log.log(CUPID, "VOTING RESULTS: next map is "+next_map+", votes1 was "+votes1+", votes2 was "+votes2+", votes3 was "+votes3+", map1 was "+playerSubGroup[0].myPlayer.nextMap1+", map2 was "+playerSubGroup[0].myPlayer.nextMap2+", map3 was "+playerSubGroup[0].myPlayer.nextMap3);

		//tell everyone which map was picked
		for (var p=0; p<playerSubGroup.length; p++)
		{
			var playa = playerSubGroup[p].myPlayer;
			playa.nextMap = next_map;
		}

		var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map",next_map,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);

		//make lobby no longer joinable
		room_with_name(gameRoom).joinable = false;

		//shuffle around people's uniqueIds based on who is still in the match
		var possible_nums = []
		for (var i=0; i<playerSubGroup.length; i++)
		{
			possible_nums.push(i);
		}

		for (var i=0; i<playerSubGroup.length; i++)
		{
			var ind = Math.floor(Math.random()*(possible_nums.length-0.0000001));

			var dirty_num = possible_nums.splice(ind,1);
			var num = dirty_num[0]

			log.log(CUPID,"Reassigning pNum for "+playerSubGroup[i].myPlayer.pName+" : "+playerSubGroup[i].myPlayer.pNum+" ---> "+num);
			playerSubGroup[i].myPlayer.pNum = num;
			var message = composer.objUpdate(avatarObjIndex,playerSubGroup[i].myPlayer.uniqueId,"pNum",playerSubGroup[i].myPlayer.pNum,FL_NORMAL);
			log.log("verbose",message);
			io.to(gameRoom).emit('obj_update',message);
		}

	}, wait_time-global.starting_match_time, playerSubGroup, dat_num, gameRoom);

	//THIS IS A NEW LOBBY --> GET READY AND SET TO MAX WAIT TIME
	obj_gameRoom.match_start_timeout = new myTimeout (function(playerSubGroup, gameRoom, uniqueMatchId) {
		//now that everyone is in the right game socket group and lobby wait time is over, let's trigger the game maker match to start
		
		//playerSubGroup should be recomputed since people might have joined
		log.log(CUPID,"recomputing playerSubGroup to be inclusive of newly joined players");
		playerSubGroup = socketsInRoom(gameRoom);
		log.log(CUPID,"new playerSubGroup: "+playerSubGroup.length+" players");
		
		//BAIL OUT IF MATCH HAS EXPIRED
		if (check_match_expired(playerSubGroup,uniqueMatchId, gameRoom))
		{
			log.log(CUPID,"ABORTING --> this match has expired");
			return false;
		}

		//figure out which map to go to -- should already be computed
		var mapNum = playerSubGroup[0].myPlayer.nextMap;

		log.log(CUPID,"after voting, map number is:  "+mapNum);

		//make everyone go to the map
		var firstMsg = composer.genMessage("goto_map",mapNum);
		log.log(CUPID,firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
		io.to(gameRoom).emit('general_message',firstMsg);

		setTimeout(function(playerSubGroup, gameRoom) {

			//create all of the players
			for (var s=0; s<playerSubGroup.length; s++)
			{
				var eachSocket = playerSubGroup[s];
				eachSocket.myPlayer.timeoutHandle = null;

				//construct player object with all known attributes of socket
				var message = composer.objCreate(playerObjIndex,eachSocket.myPlayer.uniqueId,Math.random()*1024,Math.random()*768)
				io.to(gameRoom).emit('obj_create',message);

				message = composer.objUpdate(playerObjIndex,eachSocket.myPlayer.uniqueId,"pName",eachSocket.myPlayer.pName,0);
				io.to(gameRoom).emit('obj_update',message);

				message = composer.objUpdate(playerObjIndex,eachSocket.myPlayer.uniqueId,"pNum",eachSocket.myPlayer.pNum,0);
				log.log(CUPID,"creating player "+eachSocket.myPlayer.pName+", #"+eachSocket.myPlayer.pNum);
				io.to(gameRoom).emit('obj_update',message);

				//send complete player statistics to everyone
				dbman.sendCompletePlayerStats(eachSocket, gameRoom, playerObjIndex, false);
			}

		}, 10, playerSubGroup, gameRoom);

	}, wait_time, playerSubGroup, gameRoom, dat_num);
}
exports.configure_match = configure_match

var join_match = function(playerSubGroup, gameRoom)
{
	//JOIN THIS MATCH!!
	log.log(CUPID,"found joinable preexisting match for "+playerSubGroup.length+" new players");
	log.log(CUPID,"attempting to join room: "+gameRoom);

	//grab the first player already in this lobby from which to extract some data
	var p1 = socketsInRoom(gameRoom)[0];
	log.log(CUPID,"using "+p1.myPlayer.pName+" for newly joined player data synchronization");

	log.log(CUPID,"bringing "+playerSubGroup.length+" players to game room: "+gameRoom);

	//make everyone go to the lobby -- where stuff is going to get real
	var firstMsg = composer.genMessage("goto_lobby",0);
	log.log(CUPID,firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);

	//migrate all players in the subgroup to the empty game room
	for (var s=0; s<playerSubGroup.length; s++)
	{
		var eachSocket = playerSubGroup[s];

		//sync up the uniqueMatchId and map vote settings
		eachSocket.myPlayer.uniqueMatchId = p1.myPlayer.uniqueMatchId;
		eachSocket.myPlayer.nextMap1 = p1.myPlayer.nextMap1
		eachSocket.myPlayer.nextMap2 = p1.myPlayer.nextMap2
		eachSocket.myPlayer.nextMap3 = p1.myPlayer.nextMap3
		eachSocket.myPlayer.nextMapVote = -1;
		eachSocket.myPlayer.nextMap = p1.myPlayer.nextMap;

		eachSocket.broadcast.to(eachSocket.myPlayer.room).emit('player_left_room', eachSocket.myPlayer);
		eachSocket.leave(eachSocket.myPlayer.room);
		eachSocket.join(gameRoom);
		eachSocket.myPlayer.room = gameRoom;
		eachSocket.emit('you_joined_match', eachSocket.myPlayer);

		log.log(CUPID,firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
		eachSocket.emit('general_message',firstMsg);

		eachSocket.broadcast.to(eachSocket.myPlayer.room).emit('new_player_in_group', eachSocket.myPlayer);
	}

	//sort room uniqueIds
	shuffle_teams(room_with_name(gameRoom),FL_NORMAL);

	//CREATE ALL NEEDED AVATARS
	setTimeout(function(playerSubGroup, gameRoom) {

			//create all of the new avatars for everyone
			for (var s=0; s<playerSubGroup.length; s++)
			{
				var eachSocket = playerSubGroup[s];

				//CREATE THIS AVATAR FOR EVERYONE (EXCEPT LOCAL PLAYER)
				var message = composer.objCreate(avatarObjIndex,eachSocket.myPlayer.uniqueId,Math.random()*1024,Math.random()*0);
				eachSocket.broadcast.to(gameRoom).emit('obj_create',message);

				message = composer.objUpdate(avatarObjIndex,eachSocket.myPlayer.uniqueId,"pName",eachSocket.myPlayer.pName,0);
				io.to(gameRoom).emit('obj_update',message);

				message = composer.objUpdate(avatarObjIndex,eachSocket.myPlayer.uniqueId,"pNum",eachSocket.myPlayer.pNum,0);
				io.to(gameRoom).emit('obj_update',message);

				//send complete AVATAR statistics to everyone
				dbman.sendCompletePlayerStats(eachSocket, gameRoom, avatarObjIndex, true);
			}

			//create the preexisting avatars for the newly joined players
			log.log(CUPID,"recreating preexisting avatars for newly joined players");
			var allPlayers = socketsInRoom(gameRoom);
			for (var m=0; m<allPlayers.length; m++)
			{
				var somePlayer = allPlayers[m];
				if (player_in_array(somePlayer,playerSubGroup) == false)
				{
					log.log(CUPID,"\trecreating "+somePlayer.myPlayer.pName);
					for (var k=0; k<playerSubGroup.length; k++)
					{
						
						var eachSocket = playerSubGroup[k];
						log.log(CUPID,"\t\t..for "+eachSocket.myPlayer.pName);

						if (eachSocket.myPlayer.pName==somePlayer.myPlayer.pName)
						{
							log.log(CUPID,"\t\t\tBAIL same pName");
							continue;
						}

						if (eachSocket.myPlayer.uniqueId==somePlayer.myPlayer.uniqueId)
						{
							log.log(CUPID,"\t\t\tBAIL same uniqueId");
							continue;
						}

						//this is not a new player, so create his avatar for this new player
						var message = composer.objCreate(avatarObjIndex,somePlayer.myPlayer.uniqueId,Math.random()*1024,Math.random()*0)
						log.log(CUPID,"\t\t\temitted create");
						eachSocket.emit('obj_create',message);

						message = composer.objUpdate(avatarObjIndex,somePlayer.myPlayer.uniqueId,"pName",somePlayer.myPlayer.pName,0);
						eachSocket.emit('obj_update',message);

						message = composer.objUpdate(avatarObjIndex,somePlayer.myPlayer.uniqueId,"pNum",somePlayer.myPlayer.pNum,0);
						eachSocket.emit('obj_update',message);
					}
				}
				else
				{
					log.log(CUPID,"\tNOT recreating "+somePlayer.myPlayer.pName);
				}

				//ask for a complete avatar resync
				//var message = composer.genMessage("force_sync_doll",0);
				//io.to(gameRoom).emit('general_message',message);
			}

		}, 500, playerSubGroup, gameRoom);

	//make damn-well sure everyone knows everyone's pnum
	setTimeout(function(gameRoom) {
		var roomGroup = socketsInRoom(gameRoom);
		for (var i=0; i<roomGroup.length; i++)
		{
			var eachSocket = roomGroup[i];
			var message = composer.objUpdate(avatarObjIndex,eachSocket.myPlayer.uniqueId,"pNum",eachSocket.myPlayer.pNum,0);
			io.to(gameRoom).emit('obj_update',message);
			log.log(CUPID,message);
			var message = composer.objUpdate(avatarObjIndex,eachSocket.myPlayer.uniqueId,"pName",eachSocket.myPlayer.pName,0);
			io.to(gameRoom).emit('obj_update',message);
			log.log(CUPID,message+ " gameRoom = "+gameRoom);
		}
	},50,gameRoom);

	//update that stuff that was set for everyone else in match_configure
	setTimeout(function(playerSubGroup, gameRoom) {
		var p1 = room_player1(gameRoom);
		if (p1 != null)
		{
			//update next_map
			for (var i=0; i<playerSubGroup.length; i++)
			{
				var eachSocket = playerSubGroup[i];
				//update next_map
				var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map1",p1.nextMap1,FL_NORMAL);
				eachSocket.emit('obj_update',message);
				message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map2",p1.nextMap2,FL_NORMAL);
				eachSocket.emit('obj_update',message);
				message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map3",p1.nextMap3,FL_NORMAL);
				eachSocket.emit('obj_update',message);
			}
		}
		else
		{
			log.log(CRITICAL,"cannot update next map options for joining players --> p1 = "+p1);
		}	
	}, 1000, playerSubGroup, gameRoom);
		
}
exports.join_match = join_match

//---- PERFORMS MATCHMAKING ----//
var makeMatches = function(){
	//go through each room
	for (var i=0; i<rooms.length; i++)
	{
		//only do matchmaking for lobbies
		if (rooms[i].groupName.indexOf("lobby") > -1)
		{
			var lobbyMembers = [];
			lobbyMembers = socketsInRoom(rooms[i].groupName);

			if ((lobbyMembers.length < rooms[i].minPlayers)&&(lobbyMembers.length > 0))
			{
				log.log(CUPID,"not enough players in "+rooms[i].groupName+" to start a fresh match");
				//FIRST FIND ANY JOINABLE EXISTING LOBBIES OUT THERE
				log.log(CUPID,"checking for joinable matches");
				var candidate = find_joinable_game_room(i, rooms[i].modeName, lobbyMembers);
				if (candidate)
				{
					log.log(CUPID,"found a joinable room");
					gameRoom = candidate.groupName;
					join_match(lobbyMembers, gameRoom);
					continue;
				} else log.log(CUPID,"\t...none found");
			}
			else if (lobbyMembers.length > 0)
			{

				log.log(CUPID,"\nenough players in "+rooms[i].groupName+" to start a match");

				//divide lobby players into groups of acceptable size for this match type
				while (lobbyMembers.length >= rooms[i].minPlayers)
				{
					log.log(CUPID,"grouping "+rooms[i].groupName+" sockets");
					var playerSubGroup = [];
					//make the biggest group of players you can based on how many left in lobby
					while ((playerSubGroup.length<rooms[i].maxPlayers)&&(lobbyMembers.length>0))
						playerSubGroup.push(lobbyMembers.pop());

					//find a game lobby for this player group
					var roomOffset = 1;
					var gameRoom = rooms[i+roomOffset].groupName;

					//log.log(CUPID,"gameRoom = "+gameRoom);
					//log.log(CUPID,"rooms[i].modeName = "+rooms[i].modeName);
					log.log(CUPID,"looking for a joinable game room...");

					//FIRST FIND ANY JOINABLE EXISTING LOBBIES OUT THERE
					var candidate = find_joinable_game_room(i, rooms[i].modeName, playerSubGroup);
					log.log(CUPID,"done searching");
					if (candidate)
					{
						log.log(CUPID,"found a joinable room");
						gameRoom = candidate.groupName;
						join_match(playerSubGroup, gameRoom);

					}
					else //search for empty matches b/c none were joinable / in progress
					{
						log.log(CUPID,"no joinable game rooms ... looking for an empty game room...");
						whileLoop:
						while (gameRoom.indexOf(rooms[i].modeName) > -1)
						{

							//EMPTY PROSPECTIVE MATCHES ONLY -- NO PLAYER WAITING IN A 'LOBBY' OR ANYTHING
							if (socketsInRoom(gameRoom).length == 0)
							{
								log.log(CUPID,"migrating "+playerSubGroup.length+" players to game room: "+gameRoom);
								//migrate all players in the subgroup to the empty game room
								for (var s=0; s<playerSubGroup.length; s++)
								{
									var eachSocket = playerSubGroup[s];

									eachSocket.broadcast.to(eachSocket.myPlayer.room).emit('player_left_room', eachSocket.myPlayer);
									eachSocket.leave(eachSocket.myPlayer.room);
									eachSocket.join(gameRoom);
									eachSocket.myPlayer.room = gameRoom;
									eachSocket.emit('you_joined_match', eachSocket.myPlayer);
		  							eachSocket.broadcast.to(eachSocket.myPlayer.room).emit('new_player_in_group', eachSocket.myPlayer);
								}

								//make everyone go to the lobby -- where stuff is going to get real
								var firstMsg = composer.genMessage("goto_lobby",FL_NORMAL);
								log.log(CUPID,firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
								io.to(gameRoom).emit('general_message',firstMsg);

								//CREATE ALL PLAYER AVATARS
								setTimeout(function(playerSubGroup, gameRoom) {

										//create all of the avatars
										for (var s=0; s<playerSubGroup.length; s++)
										{
											var eachSocket = playerSubGroup[s];

											//CREATE THIS AVATAR FOR EVERYONE (EXCEPT LOCAL PLAYER)
											var message = composer.objCreate(avatarObjIndex,eachSocket.myPlayer.uniqueId,Math.random()*1024,Math.random()*0)

											//s will now be the pNum of this socket's player for the duration of the match
											eachSocket.myPlayer.pNum = s;
											eachSocket.broadcast.to(gameRoom).emit('obj_create',message);

											message = composer.objUpdate(avatarObjIndex,eachSocket.myPlayer.uniqueId,"pName",eachSocket.myPlayer.pName,FL_NORMAL);
											io.to(gameRoom).emit('obj_update',message);

											message = composer.objUpdate(avatarObjIndex,eachSocket.myPlayer.uniqueId,"pNum",eachSocket.myPlayer.pNum,FL_NORMAL);
											io.to(gameRoom).emit('obj_update',message);

											//send complete AVATAR statistics to everyone
											dbman.sendCompletePlayerStats(eachSocket, gameRoom, avatarObjIndex, true);
										}

									}, 10, playerSubGroup, gameRoom);

								//THIS IS WHERE IT REALLY ALL GOES DOWN
								configure_match(playerSubGroup, gameRoom, lobby_wait_time*1/2);

								break whileLoop;
								//return true;
							}

							roomOffset++;
							gameRoom = rooms[i+roomOffset].groupName;

						}
					}
				}
			}

		}
	}
}
exports.makeMatches = makeMatches;