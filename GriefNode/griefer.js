//---- GLOBALS ----//
var globals = require('./lib/globals.js')
var FL_NORMAL = global.FL_NORMAL; var FL_DECREMENT = global.FL_DECREMENT; var FL_INSTANCE_DESTROY = global.FL_INSTANCE_DESTROY;
var FL_SQL = global.FL_SQL; var FL_BOT = global.FL_BOT; var FL_MULTIPLE = global.FL_MULTIPLE; var FL_COMPETITIVE = global.FL_COMPETITIVE;
var FL_WIPE = global.FL_WIPE; var SQL = global.SQL; var CUPID = global.CUPID; var STD = global.STD; var CRITICAL = global.CRITICAL;
var num_game_rooms = global.num_game_rooms; var num_maps = global.num_maps; var avatarObjIndex = global.avatarObjIndex; var playerObjIndex = global.playerObjIndex;
var netManObjIndex = global.netManObjIndex; var lobby_wait_time = global.lobby_wait_time; var default_avatar_uniqueId = global.default_avatar_uniqueId
var default_netman_uniqueId = global.default_netman_uniqueId; var numTdm = global.numTdm; var numFfa = global.numFfa; var numVersus = global.numVersus;
var	numMenu = global.numMenu; var numBot = global.numBot; var numSockets = global.numSockets; var numBotFfa = global.numBotFfa; var numBotTdm = global.numBotTdm;
var NUM_BPARTS = global.NUM_BPARTS; var NUM_STATS = global.NUM_STATS; var clients = global.clients; var rooms = global.rooms;
var SOCKETS = "sock"

var conn;

//WIPE DB AS DESIRED
var users_2kill = [];
users_2kill.push(FL_WIPE);

//---- LOAD MODULES ----//
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var mysql = require('mysql');
var fs = require('fs');
var util = require('util');
var log = require('./lib/logger.js');
var composer = require('./lib/composer.js');
var dbman = require('./lib/dbman.js');
var cupid = require('./lib/cupid.js');

//establish a Connection to the griefer users database
dbman.connect(conn, function() {
	dbman.delete_users(users_2kill)
});

//distribute access to the io instance
dbman.setIo(io);
cupid.setIo(io);

//initialize all of the socket rooms
cupid.initGameRooms();

//set logging intervals
setInterval(cupid.manageSockets,1000);
setInterval(cupid.syncPlayersConnected,4*5010);
setInterval(cupid.makeMatches,5000);

//---- PRIMARY EVENT-DRIVEN SERVER LOGIC ----//
io.on('connection', function(socket){

	//initialize a web-socket Connection to the client
	log.log(STD,'NEW CLIENT');
	socket.myPlayer = new cupid.player();
	clients.push(socket);


	//---- A PLAYER LOGS IN TO THE SERVER ----//
	socket.on('login_player',function(pName) {

		//create a player object to house all data needed for this socket/player
		socket.myPlayer.pName = pName;
		socket.myPlayer.uniqueId = composer.hash_string(pName);
		socket.myPlayer.pNum = -1;
		socket.myPlayer.timeoutHandle = null;

		//join the main_menu group --> aka no matchmaking currently happening
		socket.myPlayer.room = 'main_menu';
		socket.join(socket.myPlayer.room);

		log.log(STD,composer.printPlayer(socket.myPlayer));

		socket.broadcast.to(socket.myPlayer.room).emit('new_player_in_group', socket.myPlayer);

		//give player his info, and let others in his group know he connected
		socket.emit('heres_your_player_info', socket.myPlayer);
		socket.broadcast.to(socket.myPlayer.room).emit('new_player_in_group', socket.myPlayer);

		//send challenge data + control maps after 500 ms second delay
		setTimeout(function(socket) {
			log.log(STD,"sending"+socket.myPlayer.pName+" challenge stats");
			dbman.sendPermaChallenges(socket);
			dbman.sendControlMaps(socket);
		}, 500, socket);

	  	//send player stats after 35 ms delay
	  	setTimeout(function(socket) {

	  		log.log(STD,"sending "+socket.myPlayer.pName+" stats to local net manager");
	  		dbman.sendNetManPlayerStats(socket,netManObjIndex, default_netman_uniqueId);

	  		//create the local avatar
	  		cupid.objCreate(socket,avatarObjIndex,socket.myPlayer.uniqueId,Math.random()*1024,Math.random()*768);
			cupid.objUpdate(socket,avatarObjIndex,socket.myPlayer.uniqueId,"pName",socket.myPlayer.pName,0);
	
			//send complete AVATAR statistics
			dbman.sendNetManPlayerStats(socket, avatarObjIndex, socket.myPlayer.uniqueId);

			//sync connected players for everyone... cause why not
			cupid.manageSockets();
			cupid.syncPlayersConnected();

  	}, 35, socket);

  });

  //---- START MATCHMAKING ----//
  socket.on('start_matchmaking',function(gameMode){
  	socket.myPlayer.gameMode = gameMode;
  	log.log(STD,socket.myPlayer.pName+" moving to: "+socket.myPlayer.gameMode+"_lobby");

  	socket.broadcast.to(socket.myPlayer.room).emit('player_left_room', socket.myPlayer);
  	//move to the lobby for your game type
  	socket.leave(socket.myPlayer.room);
  	socket.myPlayer.room = (socket.myPlayer.gameMode+"_lobby");
  	socket.join(socket.myPlayer.room);

  });


  //---- CANCEL MATCHMAKING ----//
  socket.on('cancel_matchmaking',function(arg1) {
  	if (socket.myPlayer.room != "main_menu")
  	{
	  	socket.broadcast.to(socket.myPlayer.room).emit('player_left_matchmaking', socket.myPlayer);
	  	log.log(STD,socket.myPlayer.pName+" Leaving Matchmaking")
	  	socket.myPlayer.uniqueMatchId = -51;

	  	socket.leave(socket.myPlayer.room);
	  	socket.myPlayer.room = "main_menu";
	  	socket.join('main_menu');

	  	//if this is a party, promote some other player to party leader
  	}
  });

  //---- A PLAYER DISCONNECTS FROM THE SERVER ----//
  socket.on('disconnect', function() {
  	clients.splice(clients.indexOf(socket),1);
  	log.log(STD,socket.myPlayer.pName+": disconnected");
  	socket.broadcast.to(socket.myPlayer.room).emit('disconnected_player_from_server', socket.myPlayer);
	socket.myPlayer.uniqueMatchId = -51;

  	log.log(STD,"deleting "+socket.myPlayer.pName+"'s socket");
  	socket.myPlayer.room = "main_menu";
  	socket.join('main_menu');
  	socket.myPlayer.pName = "John Doe";
  	//socket.disconnect('unauthorized');
  	delete socket; 

  	//sync connected players for everyone... cause why not
	cupid.manageSockets();
	cupid.syncPlayersConnected();

  });

  socket.on('PING', function () {
        log.log(STD,'PING!');
        log.log(STD,'pong . . .\n');
        socket.emit('PONG');
      });

  socket.on('JSON_test', function(message) {
  	log.log(STD,"\nReceived JSON Test");
  	log.log(STD,"original message: "+message);

  	if (typeof message == "string")
  	{
  		log.log(STD,"string JSON detected");
  		message = JSON.parse(message);
  	}
  	
  	log.log(STD,"val1 = "+message.val1);

  	var reply = [{name: "generalMessage", msg: "greetings", val: 99},{name: "generalMessage", msg: "blah", val: "plaza"},"stringBean"];
  	log.log(STD,reply);
  	socket.emit('JSON_test',reply);
  	socket.emit('pkg',reply);
  });

  //---- BIG MESSAGES ----//
  socket.on('big_message', function(message) {
	  	message = composer.ensureJSON(message);

	  	if (message.msg=="control_map")
	  	{
	  		//example usage
	  		var statement = "UPDATE controls set control_code="+message.val2+" WHERE username='"+socket.myPlayer.pName+"' AND control_index="+message.val1+" AND using_gamepad="+message.val3;
	  		log.log(STD,"USER-DEFINED CONTROL MAPPING:\n"+statement+"\n\n");
			conn.query(statement, function(err,rows) {
				//log any errors
				if (err)
					log.log(STD,err);
			});
	  	}

	  	if (message.msg == "accolade_update")
	  	{
	  		if (message.val3 == FL_SQL)
	  			dbman.updateAccolade(socket.myPlayer.pName, message.val1, message.val2, FL_SQL);
	  		else
	  			dbman.updateAccolade(socket.myPlayer.pName, message.val1, message.val2, message.val3);
	  	}

	  	if (message.msg == "start_party")
	  	{
	  		var mode = message.msg.val1;
	  		var groupName = "party"+"_"+socket.myPlayer.uniqueId;
	  		var roomType = cupid.roomOfType(mode);
	  		var newRoom = new cupid.room(groupName, mode, roomType.maxPlayers, roomType.minPlayers);
	  		rooms.push(newRoom);

	  		newRoom.joinable = false;
	  		newRoom.party = true;
	  		
	  		socket.leave(socket.myPlayer.room);
	  		socket.myPlayer.room = groupName;
	  		socket.join(groupName);

	  		var firstMsg = composer.genMessage("goto_lobby",FL_NORMAL);
			log.log(CUPID,firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
			socket.emit('general_message',firstMsg);
	  	}

	  	if (message.msg == "start_match")
	  	{
	  		var obj_room = cupid.room_with_name(socket.myPlayer.room);
	  		var socks = cupid.socketsInRoom(socket.myPlayer.room); //uses room name
	  		cupid.configure_match(socks,socket.myPlayer.room,30000);
	  	}

	  	if (message.msg = "join_party")
	  	{
	  		var groupName = message.msg.val1;
	  		if (cupid.partyExpired(groupName) == false)
	  		{
	  			socket.leave(socket.myPlayer.room);
		  		socket.myPlayer.room = groupName;
		  		socket.join(groupName);

		  		var firstMsg = composer.genMessage("goto_lobby",FL_NORMAL);
				log.log(CUPID,firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
				socket.emit('general_message',firstMsg);
	  		}
	  		else
	  		{
	  			cupid.genMessage(socket,"party_expired",FL_NORMAL);
	  		}
	  	}

	});

  //---- GENERAL MESSAGES ----//
  socket.on('general_message', function(message) {
  	message = composer.ensureJSON(message);
  	if (message.msg=="end_match")
  	{
  		//forward the message
  		socket.broadcast.to(socket.myPlayer.room).emit('general_message',message);
  		//socket.broadcast.to(socket.myPlayer.room).emit('cancel_matchmaking',"blah");
  		//socket.emit('cancel_matchmaking',"blah");

  		//configure the next match after a short delay
  		setTimeout(function(playerSubGroup, gameRoom) {
  			cupid.configure_match(playerSubGroup, gameRoom, lobby_wait_time);
  		},2000,cupid.socketsInRoom(socket.myPlayer.room),socket.myPlayer.room);

	}
	else if (message.msg =="ping")
	{
		var response = {
	  		name: "generalMessage",
	  		msg: "ack",
	  		val: message.val
		};
		socket.emit('ping',response);
		//log.log(STD,"\nPING\n");
	} else if (message.msg == "perma_challenge")
	{
		log.log(STD,"adding perma challenge: "+message.val);
		dbman.addPermaChallenge(socket,message.val);
	}
	else if (message.msg == "get_personal_stats")
	{
		dbman.getPersonalStats(socket,message.val);
	}
	else if (message.msg == "get_global_stats")
	{
		dbman.getGlobalStats(socket);
	}
	else if (message.msg == "get_accolades")
	{
		dbman.sendAccolades(socket,message.val,true)
	}
	else {
		//OTHERWISE, FORWARD THE MESSAGE TO OTHER PLAYERS
		socket.broadcast.to(socket.myPlayer.room).emit('general_message',message);
	}

	if (message.msg == "syncPlayersConnected")
	{
		cupid.manageSockets();
		cupid.syncPlayersConnected();
	}

  });

  //---- CREATE USER REQUEST ----//
  socket.on('create_user', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);

  	var message = {
  		name: "generalMessage",
  		msg: "user_create_result",
  		val: false
  	};

  	dbman.userExists(datMessage.username, function (result) {
  		if (result) {
  			socket.emit('general_message',message);
  			log.log(STD,'sending user exists');
  		} else
  		{
  			log.log(STD,'sending first user');
	  		dbman.userCreate(socket, datMessage.username, datMessage.password);
	  		message.val = 1;
	  		socket.emit('general_message',message);
  		}
  	});
  });

  //---- LOG IN REQUEST ----//
  socket.on('authenticate', function(datMessage) {
  	log.log(STD,"received authentication request:");
  	log.log(STD,datMessage);

  	datMessage = composer.ensureJSON(datMessage);

  	var message = {
  		name: "generalMessage",
  		msg: "authentication_result",
  		val: 0
  	};

  	dbman.correctPassword(socket, datMessage.username, datMessage.password, function (result) {
  		if (result==1) {
  			log.log(STD,"correct password");

  			dbman.alreadyLoggedIn(datMessage.username, function(res) {
  				if (res==false) {
  					log.log(STD,"unique login for: "+datMessage.username);
  					message.val = 1;
  					socket.emit('general_message',message);
  				} else
  				{
  					log.log(STD,"login failure: "+datMessage.username);
  					message.val = FL_MULTIPLE;
  					socket.emit('general_message',message);
  				}
  			});

  		} else if (result==0)
  		{
  			log.log(STD,"INCORRECT password");
  			socket.emit('general_message',message);
  		} else if (result==2)
  		{
  			//user did not exist --> log him right in
  		}
  	});

  });

  //---- EXPLICIT STAT UPDATE ----//
  socket.on('stat_update', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);
  	var term = datMessage.netvar;
  	if (term.indexOf("history") != -1)
  	{
  		dbman.appendHistoryStat(socket,term,datMessage.val,datMessage.flag);
  	}
  	else if (datMessage.flag ==FL_SQL)
  	{
  		dbman.updateStat(socket.myPlayer.pName, term, datMessage.val, FL_SQL);
  	}
  	else
  	{
  		dbman.updateStat(socket.myPlayer.pName, term, datMessage.val, datMessage.flag);
  	}
  });

  socket.on('other_player_stat_update', function(datMessage) {
  	var term = datMessage.netvar;
  	dbman.updateStat(datMessage.pname, term, datMessage.val, datMessage.flag);
  });

  //---- TRANSPORT KCLIENT MESSAGES TO OTHER CLIENTS ----//
  socket.on('obj_update', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);
  	//intercept hats_Fd
  	var term = datMessage.netvar;
  	if (term=="hats_Fd")
  	{
  		//sendHatStats(socket,default_netman_uniqueId,netManObjIndex)
  		return true;
  	}

  	//log.log(STD,"obj_update from "+socket.myPlayer.pName+" : "+JSON.stringify(datMessage));

  	if (term=="compute_global_rank")
  	{
  		return true;
  	}

  	//---- FORWARD ON TO OTHER CLIENTS ----//
  	//log.log(STD,'obj_update: manual');
  	socket.broadcast.to(socket.myPlayer.room).emit('obj_update', datMessage);

	  //---- POSSIBLY UPDATE A DATABASE STAT ----//
	  for (var i=0; i<dbman.stats.length; i++)
	  {
	  	if (term==dbman.stats[i] && 1==0)
	  	{
			dbman.updateStat(socket.myPlayer.pName, term, datMessage.val, FL_NORMAL);
	  	}
	  }
  });

  socket.on('obj_create', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);
  	//log.log(STD,'obj_create: manual');
  	socket.broadcast.to(socket.myPlayer.room).emit('obj_create', datMessage);
  });

  socket.on('pkg', function(datPkg) {
  	datPkg = composer.ensureJSON(datPkg);
  	//log.log(STD,'dat package do: '+JSON.stringify(datPkg));
  	socket.broadcast.to(socket.myPlayer.room).emit('pkg', datPkg);
  });


});


//---- LISTEN ON PORT 8080 ----//

http.listen(8080, function(){
  log.log(STD,'listening on *:8080');
});
