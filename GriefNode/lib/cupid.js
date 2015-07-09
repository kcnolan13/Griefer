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

var io;
var conn;

//LOAD MODULES
var util = require('util');
var log = require('./logger.js');
var dbman = require('./dbman.js');
var composer = require('./composer.js');

//default 'main_menu' group ----> all room objects in the rooms array should have these properties
rooms.push( {
	groupName: "main_menu",
	modeName: "no mode",
	maxPlayers: "-1",
	minPlayers: "-1"
});

//this basically makes player objects
var player = function(){
	this.pName = "John Doe";
	this.gameMode = "no_mode"; //can be ffa, tdm, or versus
	this.room = "no_room";
	this.uniqueId = -1;
	this.uniqueMatchId = -51;
	this.nextMapNum = -54;
}
exports.player = player

//this basically makes room objects
var room = function(groupName, modeName, maxPlayers, minPlayers) {
	this.groupName = groupName;
	this.modeName = modeName;
	this.maxPlayers = maxPlayers;
	this.minPlayers = minPlayers;
	this.joinable = false;
}
exports.room = room

//define game mode constants as vars in these global objects
var tdm = new room("tdm", "tdm", 4, 2);
var ffa = new room("ffa", "ffa", 4, 2);
var versus = new room("versus", "versus", 2, 2);
var bot_tdm = new room("bot_tdm", "bot_tdm", 4, 1);
var bot_ffa = new room("bot_ffa", "bot_ffa", 4, 1);
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
	namespace = "/";
	var theSockets = [];
	for (var socketId in io.nsps[namespace].adapter.rooms[roomName]) {
		if (io.sockets.connected[socketId]!=undefined) //was myPlayer.pName
	    	theSockets.push(io.sockets.connected[socketId]);
	}

return theSockets;
}
exports.socketsInRoom = socketsInRoom;

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

//prints players in each room / socket group and shows general net stats
exports.showSocketGroups = function(){

	numSockets = 0;
	numTdm = 0;
	numFfa = 0;
	numVersus = 0;
	numMenu = 0;
	numBot = 0;
	numBotFfa = 0;
	numBotTdm = 0;

	log.log(CUPID,"\n\nSocket Groups:\n");
	for (var i=0; i<rooms.length; i++)
	{
		var sockets = [];
		sockets = socketsInRoom(rooms[i].groupName);

		//collect network stats
		numSockets += sockets.length;

		if ((rooms[i].groupName.indexOf("bot") < 0)&&(rooms[i].groupName.indexOf("ffa") > -1))
			numFfa += sockets.length;
		else if ((rooms[i].groupName.indexOf("bot") < 0)&&(rooms[i].groupName.indexOf("tdm") > -1))
			numTdm += sockets.length;
		else if ((rooms[i].groupName.indexOf("bot") < 0)&&(rooms[i].groupName.indexOf("versus") > -1))
			numVersus += sockets.length;
		else if (rooms[i].groupName.indexOf("bot_versus") > -1)
			numBot += sockets.length;
		else if (rooms[i].groupName.indexOf("bot_ffa") > -1)
			numBotFfa += sockets.length;
		else if (rooms[i].groupName.indexOf("bot_tdm") > -1)
			numBotTdm += sockets.length;
		else if (rooms[i].groupName.indexOf("menu") > -1)
			numMenu += sockets.length;

		//end network stats
		var playerNames = "";
		for (var j=0; j<sockets.length; j++) {
			playerNames += sockets[j].myPlayer.pName;

			if (j<sockets.length-1)
				playerNames += ", ";
		}
		log.log(CUPID,"\t"+rooms[i].groupName+": "+playerNames);
	}
	log.log(CUPID,"\n\nPlayers Online: "+numSockets+"\nPlaying TDM: "+numTdm+"\nPlaying FFA: "+numFfa+"\nPlaying Verus: "+numVersus+"\nPlaying Bot_Verus: "+numBot+"\nPlaying Bot_Ffa: "+numBotFfa+"\nPlaying Bot_Tdm: "+numBotTdm+"\n\n");
	log.log(CUPID,"\n");
}

exports.syncPlayersConnected = function(){
	log.log(CUPID,"SYNCHRONIZING PLAYERS CONNECTED");
	for (var i=0; i<rooms.length; i++)
	{
		var sockets = [];
		sockets = socketsInRoom(rooms[i].groupName);
		for (var j=0; j<sockets.length; j++)
		{
			var socket = sockets[j];
			objUpdate(socket, netManObjIndex, -1, "ffa_players_online", numFfa, FL_NORMAL);
			objUpdate(socket, netManObjIndex, -1, "versus_players_online", numVersus, FL_NORMAL);
			objUpdate(socket, netManObjIndex, -1, "tdm_players_online", numTdm, FL_NORMAL);
			objUpdate(socket, netManObjIndex, -1, "bot_versus_players_online", numBot, FL_NORMAL);
			objUpdate(socket, netManObjIndex, -1, "bot_ffa_players_online", numBotFfa, FL_NORMAL);
			objUpdate(socket, netManObjIndex, -1, "bot_tdm_players_online", numBotTdm, FL_NORMAL);
			objUpdate(socket, netManObjIndex, -1, "players_online", numSockets, FL_NORMAL);
		}
	}
}

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

var sort_uniqueIds = function(room, interval_handle)
{
	var playas = [];
	playas = socketsInRoom(room.groupName);

	if (playas.length == 0)
	{
		log.log(CUPID,"ALERT: no players in "+room.groupName+" anymore. closing down.");
		room.joinable = false;
		clearInterval(interval_handle);
		return false;
	}

	for (var i=0; i<playas.length; i++)
	{
		if (playas[i].myPlayer.uniqueId != i)
		{
			log.log(CUPID,"Reassigning uniqueId: "+playas[i].myPlayer.pName+" : "+i);
			var message = composer.objUpdate(avatarObjIndex,playas[i].myPlayer.uniqueId,"uniqueId",i,FL_NORMAL);
			playas[i].myPlayer.uniqueId = i;
			playas[i].emit('obj_update',message);
		}
	}
	return true;
}
exports.sort_uniqueIds = sort_uniqueIds

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
		if (array[i].pName == player.myPlayer.pName)
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

	//make this room joinable
	room_with_name(gameRoom).joinable = true;

	//determine the next map
	var mapNum = Math.floor((Math.random() * num_maps));

	for (var s=0; s<playerSubGroup.length; s++)
	{
		var eachSocket = playerSubGroup[s];
		eachSocket.myPlayer.uniqueMatchId = dat_num;
		eachSocket.myPlayer.nextMapNum = mapNum;
	}

	setTimeout(function() {
		//update next_map
		var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map",mapNum,FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);

		//update lobby wait time
		var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"lobby_wait_time",Math.ceil((wait_time-1000)/1000*30),FL_NORMAL);
		io.to(gameRoom).emit('obj_update',message);
	},1000);

	//shuffle around people's uniqueIds based on who is still in the match
	id_shuffler = setInterval(function(gameRoom){
		sort_uniqueIds(room_with_name(gameRoom), id_shuffler);
	},1000,gameRoom);
	
	//send save and quit armory message with plenty of time left over (10 seconds)
	setTimeout(function(playerSubGroup, uniqueMatchId, gameRoom, id_shuffler) {
		
		log.log(CUPID,"id_shuffler = "+id_shuffler);
		clearInterval(id_shuffler);

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

		//make lobby no longer joinable
		room_with_name(gameRoom).joinable = false;

	}, wait_time-10000, playerSubGroup, dat_num, gameRoom, id_shuffler);

	//THIS IS A NEW LOBBY --> GET READY AND SET TO MAX WAIT TIME
	setTimeout(function(playerSubGroup, gameRoom, mapNum, uniqueMatchId) {
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
		log.log(CUPID,"selected map number:  "+mapNum);

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

				//send complete player statistics to everyone
				dbman.sendCompletePlayerStats(eachSocket, gameRoom, playerObjIndex, false);
			}

		}, 10, playerSubGroup, gameRoom);

	}, wait_time, playerSubGroup,gameRoom, mapNum, dat_num);
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

		//sync up the uniqueMatchId
		eachSocket.myPlayer.uniqueMatchId = p1.myPlayer.uniqueMatchId;

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
	sort_uniqueIds(room_with_name(gameRoom));

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

				//update the avatar's uniqueId locally
				var datStr = composer.hash_string(eachSocket.myPlayer.pName);
				message = composer.objUpdate(avatarObjIndex,datStr,"uniqueId",eachSocket.myPlayer.uniqueId,0);
				eachSocket.emit('obj_update',message);

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
					}

					//send complete AVATAR statistics to everyone
					force_sync_doll(somePlayer);
				}
				else
				{
					log.log(CUPID,"\tNOT recreating "+somePlayer.myPlayer.pName);
				}
			}

		}, 500, playerSubGroup, gameRoom);

	//update that stuff that was set for everyone else in match_configure
	setTimeout(function(p1) {
			//update next_map
			var message = composer.objUpdate(netManObjIndex,default_netman_uniqueId,"next_map",p1.myPlayer.nextMapNum,0);
			io.to(gameRoom).emit('obj_update',message);
		},1000, p1);

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
											var message = composer.objCreate(avatarObjIndex,s,Math.random()*1024,Math.random()*0)

											//s will now be the uniqueId of this socket's player for the duration of the match
											eachSocket.myPlayer.uniqueId = s;
											eachSocket.broadcast.to(gameRoom).emit('obj_create',message);

											message = composer.objUpdate(avatarObjIndex,s,"pName",eachSocket.myPlayer.pName,FL_NORMAL);
											io.to(gameRoom).emit('obj_update',message);

											//update the avatar's uniqueId locally
											message = composer.objUpdate(avatarObjIndex,default_avatar_uniqueId,"uniqueId",s,FL_NORMAL);
											eachSocket.emit('obj_update',message);

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