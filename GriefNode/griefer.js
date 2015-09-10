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
var SOCKETS = "sock"; var gravatarObjIndex = global.gravatarObjIndex;

var conn;

//WIPE DB AS DESIRED
var users_2kill = [];
users_2kill.push("0");
//users_2kill.push(FL_WIPE);

var random_users_2create = 2;

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
  for (var i=0; i<random_users_2create; i++)
  {
    var name = composer.generateName();
    console.log("Auto-Creating User: "+name)
    dbman.userCreate(null,name,"abc123");
  }
});

//distribute access to the io instance
dbman.setIo(io);
cupid.setIo(io);

//initialize all of the socket rooms
cupid.initGameRooms();

//set logging intervals
setInterval(dbman.rankPlayers,60000);
setInterval(cupid.manageSockets,1000);
setInterval(cupid.syncPlayersConnected,4*5010);
setInterval(cupid.makeMatches,5000);

//---- PRIMARY EVENT-DRIVEN SERVER LOGIC ----//
io.on('connection', function(socket){

	//initialize a web-socket Connection to the client
	log.log(STD,'NEW CLIENT');
	socket.myPlayer = new cupid.player();
	global.clients.push(socket);

	//---- A PLAYER LOGS IN TO THE SERVER ----//
	socket.on('login_player',function(pName) {

		//create a player object to house all data needed for this socket/player
		socket.myPlayer.pName = pName;
		socket.myPlayer.uniqueId = pName;//composer.hash_string(pName);
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
			log.log(STD,"sending "+socket.myPlayer.pName+" challenge stats");
			dbman.sendPermaChallenges(socket);
			dbman.sendControlMaps(socket);
			dbman.loadSettings(socket);
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
    	global.clients.splice(global.clients.indexOf(socket),1);
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

  //KEEPALIVE
  socket.on('keepalive', function () {
  		socket.emit('keepalive');
  });

  socket.on('PING', function () {
        log.log(STD,'PING!');
        log.log(STD,'pong . . .\n');
        socket.emit('PONG');
      });

  //---- BIG MESSAGES ----//
  socket.on('big_message', function(message) {
	  	message = composer.ensureJSON(message);

	  	if (message.msg=="control_map")
	  	{
	  		//example usage
	  		var statement = "UPDATE controls set control_code="+message.val2+" WHERE username='"+conn.escape(socket.myPlayer.pName)+"' AND control_index="+message.val1+" AND using_gamepad="+message.val3;
	  		log.log(SQL,"USER-DEFINED CONTROL MAPPING:\n"+statement+"\n\n");
			dbman.execute(statement);
	  	}
	  	else if (message.msg == "accolade_update")
	  	{
	  		if (message.val3 == FL_SQL)
	  			dbman.updateAccolade(socket.myPlayer.pName, message.val1, message.val2, FL_SQL);
	  		else
	  			dbman.updateAccolade(socket.myPlayer.pName, message.val1, message.val2, message.val3);
	  	}
	  	else if (message.msg == "get_accolades")
  		{
  			dbman.getGravatarAccolades(socket,message.val1,message.val2,true)
  		}
  		else if (message.msg == "get_personal_stats")
  		{
  			dbman.getGravatarStats(socket,message.val1,message.val2);
  		} 
      else if (message.msg == "save_setting")
  		{
  			dbman.saveSetting(socket, message.val1, message.val2, message.val3);
  			log.log("verbose", "GENERAL SETTING:\n"+message);
  		} 
      else if (message.msg == "kill_feed")
  		{
  			log.log("verbose", "forwarding KILL_FEED: "+message);
  			socket.broadcast.to(socket.myPlayer.room).emit('big_message',message);
  		}
  		else if (message.msg == "chat_feed")
  		{
  			log.log("verbose", "forwarding CHAT_FEED: "+message);
  			socket.broadcast.to(socket.myPlayer.room).emit('big_message',message);
  		}
      else if (message.msg == "user_try_create")
      {
        log.log(STD, "received user_try_create: "+message.val1+", "+message.val2+", "+message.val3);
        dbman.userTryCreate(socket, message.val1, message.val2);
      }
      else if (message.msg == "page_leaderboards")
      {
        log.log(STD, "received page_leaderboards: "+message.val1+", "+message.val2+", "+message.val3);
        dbman.getGlobalStats(socket, message.val1, message.val2);
      }

	});

  //---- GENERAL MESSAGES ----//
  socket.on('general_message', function(message) {
  	message = composer.ensureJSON(message);
  	if (message.msg=="end_match")
  	{
  		//forward the message
  		socket.broadcast.to(socket.myPlayer.room).emit('general_message',message);

  		//trigger a player re-ranking
  		if (message.val != FL_BOT)
  			setTimeout(function() {dbman.rankPlayers()},5000);

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
	}
	else if (message.msg == "shuffle_pnums")
	{
		console.log("Player 0 Has Quit. Reshuffling pNum's");

		//shuffle around people's uniqueIds based on who is still in the match
		var possible_nums = []
		var playerSubGroup = cupid.socketsInRoom(socket.myPlayer.room)
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
			io.to(socket.myPlayer.room).emit('obj_update',message);
		}
	} 
	else if (message.msg == "perma_challenge")
	{
		log.log(STD,"adding perma challenge: "+message.val);
		dbman.addPermaChallenge(socket,message.val);
	}
	else if (message.msg == "syncPlayersConnected")
	{
		cupid.manageSockets();
		cupid.syncPlayersConnected();
	}
	else if (message.msg == "everyone_ready") {
		//initiate match start countdown
		var obj_room = cupid.room_with_name(socket.myPlayer.room);
		if (globals.exists(obj_room.match_countdown_timeout) == true)
		{
			if (obj_room.match_countdown_timeout != null)
			{
				if (globals.exists(obj_room.match_countdown_timeout.change) == true)
				{
					log.log(STD,"forcing start match countdown: rescheduling room "+obj_room.groupName+" to start match in: "+Math.round(global.starting_match_time/1000)+" seconds");
					log.log(STD,"previous time: "+obj_room.match_countdown_timeout.ms);
          			obj_room.match_countdown_timeout.change(10);
					obj_room.match_start_timeout.change(global.starting_match_time);
					log.log(STD,"new time: "+obj_room.match_countdown_timeout.ms);

				} else log.log(CRITICAL,"obj_room.match_countdown_timeout.change does not exist!");
			} else log.log(CRITICAL,"everyone_ready room has invalid match_countdown_timeout handle");
		} else log.log(CRITICAL,"everyone_ready has nonexistent match_countdown_timeout var");
	}
	 else if (message.msg == "get_top_gravatars")
	 {
	    log.log(STD, socket.myPlayer.pName+" asked for get_top_gravatars");
	    dbman.getTopGravatars(socket);
	 }
	else {
		//OTHERWISE, FORWARD THE MESSAGE TO OTHER PLAYERS
		socket.broadcast.to(socket.myPlayer.room).emit('general_message',message);
	}

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
  			//user did not exist --> try to create?
        log.log(STD, "sending 2 as authentication result (can create user)");
        message.val = 2;
        socket.emit('general_message',message);
  		}
  	});

  });

  //---- EXPLICIT STAT UPDATE ----//
  socket.on('stat_update', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);
  	var term = datMessage.netvar;
  	if (term.indexOf("history") != -1)
  	{
  		dbman.appendHistoryStat(socket.myPlayer.pName,term,datMessage.val,datMessage.flag);
  	}
  	else
  	{
  		if (global.calcColumns.indexOf(term) > -1 && global.calcColumnsTimeout == null)
  		{
  			//console.log("setting calc column timeout");
  			global.calcColumnsTimeout = setTimeout(dbman.updateCalcColumns,2500);
  		}
	  	else 
  		{
  			//console.log(term+" not in: ");
	  		//console.log(global.calcColumns);

			if (datMessage.flag == FL_SQL)
		  	{
		  		dbman.updateStat(socket.myPlayer.pName, term, datMessage.val, FL_SQL);
		  	}
		  	else
		  	{
		  		dbman.updateStat(socket.myPlayer.pName, term, datMessage.val, datMessage.flag);
		  	}
	  	}
  	}
  });

  socket.on('other_player_stat_update', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);
  	var term = datMessage.netvar;
  	if (term.indexOf("history") != -1)
  	{
  		dbman.appendHistoryStat(datMessage.pname,term,datMessage.val,datMessage.flag);
  	}
  	else
  	{
	  	if (term in global.calcColumns && global.calcColumnsTimeout == null)
	  	{
	  		console.log("setting calc column timeout");
	  		global.calcColumnsTimeout = setTimeout(dbman.updateCalcColumns,2500);
	  	}
	  	else
	  	{
	  		dbman.updateStat(datMessage.pname, term, datMessage.val, datMessage.flag);
	  	}
  	}
  });

  //---- TRANSPORT GRIEFPLUSPLUS MESSAGES TO OTHER CLIENTS ----//
  socket.on('obj_update', function(datMessage) {
  	datMessage = composer.ensureJSON(datMessage);
  	
  	//intercept netvar for preprocessing
  	var term = datMessage.netvar;

  	//deprecated messages
  	if (term=="hats_Fd" || term=="compute_global_rank")
  		return true;

  	//keep track of which map you voted for
  	if (term == "nextMapVote")
  	{
  		socket.myPlayer.nextMapVote = datMessage.val;
  	}

  	//---- FORWARD ON TO OTHER CLIENTS ----//
  	socket.broadcast.to(socket.myPlayer.room).emit('obj_update', datMessage);
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
http.listen(global.gamePort, function(){
  log.log(STD,'listening on *:'+global.gamePort);
});
