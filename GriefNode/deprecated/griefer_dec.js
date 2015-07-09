//---- GLOBALS ----//
var FL_NORMAL = 0;
var FL_DECREMENT = 1;
var FL_INSTANCE_DESTROY = 2;
var FL_SQL = 9;
var FL_BOT = 15;
var FL_MULTIPLE = 2;

var num_game_rooms = 3;
var num_maps = 1;
var avatarObjIndex = 2;
var playerObjIndex = 1;
var netManObjIndex = 0;
var lobby_wait_time = 45000 //in miliseconds
var default_avatar_uniqueId = -52
var default_netman_uniqueId = -1

//define game mode constants as vars in these global objects
var tdm = new room("tdm", "tdm", 4, 2);
var ffa = new room("ffa", "ffa", 4, 2);
var versus = new room("versus", "versus", 2, 2);
var bot_tdm = new room("bot_tdm", "bot_tdm", 4, 1);
var bot_ffa = new room("bot_ffa", "bot_ffa", 4, 1);
var bot_versus = new room("bot_versus", "bot_versus", 2, 1);

var clients = [];
var players = []; //not sure what this is for anymore
var rooms = [];

//default 'main_menu' group ----> all room objects in the rooms array should have these properties
rooms.push( {
	groupName: "main_menu",
	modeName: "no mode",
	maxPlayers: "-1",
	minPlayers: "-1"
})


//---- STARTUP SEQUENCE ----//

var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var mysql = require('mysql');
var fs = require('fs');

//how to remake the users table when you need to
var statement = 'create table users (username VARCHAR(20), password VARCHAR(32), rank real, bot_rank real, global_rank real, wins real, losses real, headshots real, sprees real, kills real, deaths real, assists real, ';
var parts = ['hat','helmet','torso','shoulder','forearm','leg','shin','foot','prop'];
for (var i=0; i<10; i++)
{
	for (var j=0; j<parts.length; j++)
	{
		statement += parts[j]+i;
		statement += ' TEXT';
		if ((i<9)||(j<parts.length-1))
			statement += ', ';
	}
}
statement += ');';
console.log(statement);


//establish a Connection to the griefer users database
var dbConnection = mysql.createConnection({
	host	: 	'localhost',
	user	: 	'kserver',
	password : 	'boomer92',
	database : 	'griefer'
})

dbConnection.connect(function(err) {
	if (err) {
		console.error('ERROR: database dbConnection failed: '+err.stack);
		return;
	}

	console.log('CONNECTED to griefer database, as id: '+dbConnection.threadId);
});

dbConnection.on('error', function(err) {
  console.log(err.code); // 'ER_BAD_DB_ERROR'
});


//create 3 game socket groups and 1 lobby socket group for each game mode
for (var i=0; i<6; i++)
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


//show the latest socket groups every 5 seconds
setInterval(showSocketGroups,12000);

//perform matchmaking every 2 seconds
setInterval(makeMatches,2000);

//update everyone's global rank periodically
setInterval(recomputeAllGlobalRanks,120000);

//update the website stats every once in a while
setInterval(writeDb,10000);



//---- PRIMARY EVENT-DRIVEN SERVER LOGIC ----//

io.on('connection', function(socket){

	//initialize a web-socket Connection to the client
    console.log('NEW CLIENT');
    socket.myPlayer = new player();
    clients.push(socket);


 //----------- THE REST OF THESE ARE ASYNCHRONOUS-EVENT-DRIVEN -------------//


  //---- A PLAYER LOGS IN TO THE SERVER ----//
  socket.on('login_player',function(pName) {

  	//create a player object to house all data needed for this socket/player
  	socket.myPlayer.pName = pName;
  	socket.myPlayer.timeoutHandle = null;

  	//join the main_menu group --> aka no matchmaking currently happening
  	socket.myPlayer.room = 'main_menu';
  	socket.join(socket.myPlayer.room);

  	console.log(printPlayer(socket.myPlayer));

  	//give player his info, and let others in his group know he connected
  	socket.emit('heres_your_player_info', socket.myPlayer);
  	socket.broadcast.to(socket.myPlayer.room).emit('new_player_in_group', socket.myPlayer);

  	//send player stats after 1 second delay
  	setTimeout(function(socket) {
  		console.log("sending "+socket.myPlayer.pName+" stats to local net manager");
  		sendNetManPlayerStats(socket,netManObjIndex, default_netman_uniqueId);

  		//CREATE THE LOCAL AVATAR
  		var message = {
			name: "objCreate",
			object_index: avatarObjIndex,
			uniqueId: default_avatar_uniqueId,
			myX: Math.random()*1024,
			myY: Math.random()*768
		};

		socket.emit('obj_create',message);

		message = {
			name: "objUpdate",
			object_index: avatarObjIndex,
			uniqueId: default_avatar_uniqueId,
			netvar: "pName",
			val: socket.myPlayer.pName,
			flag: 0
		}
		socket.emit('obj_update',message);

		//send complete AVATAR statistics to everyone
		sendNetManPlayerStats(socket, avatarObjIndex, default_avatar_uniqueId);

  	}, 35, socket);

  });


  //---- START MATCHMAKING ----//
  socket.on('start_matchmaking',function(gameMode){
  	socket.myPlayer.gameMode = gameMode;
  	console.log(socket.myPlayer.pName+" moving to: "+socket.myPlayer.gameMode+"_lobby");

  	socket.broadcast.to(socket.myPlayer.room).emit('player_left_room', socket.myPlayer);
  	//move to the lobby for your game type
  	socket.leave(socket.myPlayer.room);
  	socket.myPlayer.room = (socket.myPlayer.gameMode+"_lobby");
  	socket.join(socket.myPlayer.room);

  });


  //---- CANCEL MATCHMAKING ----//
  socket.on('cancel_matchmaking',function(arg1) {
  	socket.broadcast.to(socket.myPlayer.room).emit('player_left_matchmaking', socket.myPlayer);
  	console.log(socket.myPlayer.pName+" Leaving Matchmaking")
  	socket.myPlayer.uniqueMatchId = -51;

  	socket.leave(socket.myPlayer.room);
  	socket.myPlayer.room = "main_menu";
  	socket.join('main_menu');
  });


  //---- A PLAYER DISCONNECTS FROM THE SERVER ----//
  socket.on('disconnect', function() {
  	clients.splice(clients.indexOf(socket),1);
  	console.log(socket.myPlayer.pName+": disconnected");
  	socket.broadcast.to(socket.myPlayer.room).emit('disconnected_player_from_server', socket.myPlayer);
	socket.myPlayer.uniqueMatchId = -51;

  	console.log("deleting "+socket.myPlayer.pName+"'s socket");
  	socket.myPlayer.room = "blah";
  	delete socket; 
  });


  //---- GENERAL MESSAGES ----//
  socket.on('general_message', function(message) {
  	if (message.msg=="end_match")
  	{
  		//forward the message
  		socket.broadcast.to(socket.myPlayer.room).emit('general_message',message);
  		//socket.broadcast.to(socket.myPlayer.room).emit('cancel_matchmaking',"blah");
  		//socket.emit('cancel_matchmaking',"blah");

  		//configure the next match after a short delay
  		setTimeout(function(playerSubGroup, gameRoom) {
  			configure_match(playerSubGroup, gameRoom, lobby_wait_time);
  		},2000,socketsInRoom(socket.myPlayer.room),socket.myPlayer.room);

	}

	//forward the message
	socket.broadcast.to(socket.myPlayer.room).emit('general_message',message);

  });

  //---- CREATE USER REQUEST ----//
  socket.on('create_user', function(datMessage) {
  	var message = {
  		name: "generalMessage",
  		msg: "user_create_result",
  		val: false
  	};

  	userExists(datMessage.username, function (result) {
  		if (result) {
  			socket.emit('general_message',message);
  			console.log('sending user exists');
  		} else
  		{
  			console.log('sending first user');
	  		userCreate(socket, datMessage.username, datMessage.password);
	  		message.val = true;
	  		socket.emit('general_message',message);
  		}
  	});
  });

  //---- LOG IN REQUEST ----//
  socket.on('authenticate', function(datMessage) {
  	var message = {
  		name: "generalMessage",
  		msg: "authentication_result",
  		val: false
  	};

  	correctPassword(datMessage.username, datMessage.password, function (result) {
  		if (result) {
  			console.log("correct password");

  			alreadyLoggedIn(datMessage.username, function(res) {
  				if (res==false) {
  					console.log("unique login for: "+datMessage.username);
  					message.val = true;
  					socket.emit('general_message',message);
  				} else
  				{
  					console.log("login failure: "+datMessage.username);
  					message.val = FL_MULTIPLE;
  					socket.emit('general_message',message);
  				}
  			});

  		} else
  		{
  			console.log("INCORRECT password");
  			socket.emit('general_message',message);
  		}
  	});

  });

  //---- EXPLICIT STAT UPDATE ----//
  socket.on('stat_update', function(datMessage) {
  	var term = datMessage.netvar;
  	if (datMessage.flag ==FL_SQL)
  		updateStat(socket.myPlayer.pName, term, datMessage.val, FL_SQL);
  	else
  		updateStat(socket.myPlayer.pName, term, datMessage.val, FL_NORMAL);
  });

  socket.on('other_player_stat_update', function(datMessage) {
  	var term = datMessage.netvar;
  	updateStat(datMessage.pname, term, datMessage.val, FL_NORMAL);
  });

  //---- TRANSPORT KCLIENT MESSAGES TO OTHER CLIENTS ----//
  socket.on('obj_update', function(datMessage) {
  	//intercept hats_Fd
  	var term = datMessage.netvar;
  	if (term=="hats_Fd")
  	{
  		//sendHatStats(socket,default_netman_uniqueId,netManObjIndex)
  		return true;
  	}

  	if (term=="compute_global_rank")
  	{
  		console.log("\n\n\nRECIEVED RECOMPUTE GLOBAL RANK SIGNAL for "+socket.myPlayer.pName+"\n\n\n");


  		setTimeout(function(socket, datMessage) {

  			console.log("recomputing global rank for: "+socket.myPlayer.pName);
  			recomputeGlobalRank(socket.myPlayer.pName, socket, -1);

		},1000, socket, datMessage);

		setTimeout(function(socket, datMessage) {

  			console.log("sending global rank to: "+socket.myPlayer.pName);
  			resendGlobalRank(socket.myPlayer.pName, socket);

		},2000, socket, datMessage);


  		//MAKE SURE NOT TO GIVE THIS TO OTHER PLAYERS
  		return true;
  	}


  	//---- FORWARD ON TO OTHER CLIENTS ----//
  	//console.log('obj_update: manual');
  	socket.broadcast.to(socket.myPlayer.room).emit('obj_update', datMessage);

	  //---- POSSIBLY UPDATE A DATABASE STAT ----//
	  if ((term=="rank")||(term=="wins")||(term=="losses")||(term=="headshots")||(term=="sprees")||(term=="kills")||(term=="deaths")||(term=="assists"))
	  {
	  	if (datMessage.flag != FL_BOT)
	  		updateStat(socket.myPlayer.pName, term, datMessage.val, FL_NORMAL);
	  	else
	  		console.log("almost updated a bot stat.. phew..");
	  }
  });
  socket.on('obj_create', function(datMessage) {
  	//console.log('obj_create: manual');
  	socket.broadcast.to(socket.myPlayer.room).emit('obj_create', datMessage);
  });
  socket.on('pkg', function(datPkg) {
  	//console.log('dat package do');
  	socket.broadcast.to(socket.myPlayer.room).emit('pkg', datPkg);
  });


});




//---- LISTEN ON PORT 8080 ----//

http.listen(8080, function(){
  console.log('listening on *:8080');
});




//---- FUNCTION DEFINITIONS ----//
function recomputeAllGlobalRanks()
{
	console.log("\n\n\n------------------------\nRECOMPUTING ALL GLOBAL RANKS\n------------------------\n")
	//get a listing of all the users out there and all their ranks
	var statement = "SELECT username,rank FROM users;";

	dbConnection.query(statement, function(err,rows) {

		var usernames = [];
		var ranks = [];

			//log any errors
			if (err)
				console.log(err);

			//construct all the object updates and add to package
			for (var j=0; j<rows.length; j++)
			{
				usernames.push(rows[j]['username']);
				ranks.push(rows[j]['rank']);

				//console.log("rows["+j+"]['username'] = "+rows[j]['username']);
				//console.log("rows["+j+"]['rank'] = "+rows[j]['rank']);
			}
			
			//now recompute global rank for all of these usersnames and ranks
			for (var p=0; p<usernames.length; p++)
			{
				recomputeGlobalRank(usernames[p], -1, ranks[p]);
			}

		});

}

function writeDb()
{
	dbConnection.query("SELECT * from users ORDER BY global_rank", function(err,rows) {

			//log any errors
			if (err)
				console.log(err);

			var str = [];

			//construct the string to write to the file
			for (var k=0; k<rows.length; k++)
			{
				str[k] = "";
				str[k] += rows[k]['username']+" :: ";
				str[k] += rows[k]['global_rank']+" :: ";
				str[k] += rows[k]['rank']+" :: ";
				str[k] += rows[k]['wins']+" :: ";
				str[k] += rows[k]['losses']+" :: ";
				str[k] += rows[k]['kills']+" :: ";
				str[k] += rows[k]['deaths']+" :: ";
				str[k] += rows[k]['assists']+" :: ";
				console.log("deaths = "+rows[k]['deaths']);
				console.log('assists = '+rows[k]['assists']);
			}
			
			var master_str = "";

			//compose the real string
			for (var i=0; i<str.length; i++)
			{
				master_str += str[i]+"\n";
			}

			//write out to the file
			fs.writeFile('griefer_stats_raw.txt',master_str, function (err) {
				if (err) return console.log(err);
				console.log(master_str+' > griefer_stats_raw.txt');
			});

		});

}

function resendGlobalRank(pName, socket)
{
	console.log("previously computed new global rank for: "+pName+" : now following through");
	var statement = "SELECT global_rank FROM users where username='"+pName+"'";
	console.log(statement);

	var pkgDude = new createPkg();

	//perform the query, obtain results, and send off to the local player
	dbConnection.query(statement, function(err,rows) {

		//log any errors
		if (err)
			console.log(err);

			var param = 'global_rank';
			var result = rows[0][param];

			var message = {
				name: "objUpdate",
				object_index: netManObjIndex,
				uniqueId: default_netman_uniqueId,
				netvar: "global_rank",
				val: result,
				flag: 0
				};

			pkgDude.messages.push(message);
			
			//send package
			socket.emit('pkg', pkgDude);
			console.log("SENDING NEW GLOBAL RANK TO "+pName+" : "+result);

	});
}


function recomputeGlobalRank(pName, socket, current_rank)
{

	if (current_rank < 0)
	{
		//need to find out his rank from the database
		console.log("rank is less than zero --> using an extra SELECT"+pName);
	}

	var username = pName;
	console.log("Recomputing Global Rank for: "+username);


	//construct the query
	if (current_rank < 0)
		var statement = "SELECT count(*) FROM users WHERE rank>(select rank from users where username='"+pName+"');";
	else
		var statement = "SELECT count(*) FROM users WHERE (rank>"+current_rank+");";
		console.log(statement);

		//perform the query, obtain results, and send off to the local player
		dbConnection.query(statement, function(err,rows) {

			//log any errors
			if (err)
				console.log(err);

			//get the result
			var param = 'count(*)';
			var result = rows[0][param];
			//console.log("rows[0]["+param+"] = "+result);
			result = result+1;
			//console.log("\n"+username+"'s Global Rank:"+result+"\n");

			//update database with new value
			statement = "UPDATE users SET global_rank="+result+" WHERE username='"+username+"'";
			//console.log(statement);

			dbConnection.query(statement, function (err, rows) {
				//log any errors
				if (err)
					console.log(err);
				else {
					console.log("---Stored data in DB: "+username+": global_rank = "+result);
					return true;
				}
				return false;
			});
		});

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
				console.log(playerSubGroup[i].myPlayer.pName+": match still good");
			}
		}
	}

	if (pCount < room_with_name(gameRoom).minPlayers)
	{
		console.log("THIS MATCH HAS EXPIRED");
		return true;
	} else {
		return false;
	}
}

function generate_uniqueMatchId()
{
	return Math.ceil(Math.random()*1000000);
}


function updateStat(username, stat, value, flag)
{
	var statement;

	if (typeof(value) != "string")
		statement = "UPDATE users SET "+stat+" ="+value+" WHERE username='"+username+"'";
	else
		statement = "UPDATE users SET "+stat+" = '"+value+"' WHERE username='"+username+"'";

	if (flag==FL_SQL)
		statement = stat;

	//if (stat='rank')
		console.log(statement);

	dbConnection.query(statement, function (err, rows) {

		//log any errors
		if (err)
			console.log(err);
		else {
			//console.log(username+": "+stat+" = "+value);
			return true;
		}
		return false;
	});
}


function userExists(username, callback)
{
	var result = 0;
	dbConnection.query("SELECT * from users WHERE username='"+username+"'", result, function (err,rows) {
		//log any errors
		if (err)
			console.log(err);

		if (rows.length > 0)
		{
			console.log("USER ALREADY EXISTS....");
			result = 1;
		} else {
			console.log("USER DOES NOT EXIST!");
			result = 0;
		}

		callback(result);

	});

	return result;
}

function correctPassword(username, password, callback)
{
	var statement = "SELECT * from users WHERE username='"+username+"' AND password=MD5('"+password+"')";
	//console.log(statement);

	var result = 0;

	dbConnection.query(statement, function (err, rows) {

		//console.log("rows.length = "+rows.length);

		result = rows.length;

		if (rows.length > 0)
		{
			console.log("good password");
			result = 1;
		} else {
			console.log("bad password");
			result = 0;
		}

		callback(result);

	});

}

function alreadyLoggedIn(username, callback)
{
	var res = false;

	for (var i=0; i<clients.length; i++)
	{
		if (clients[i].myPlayer.pName == username)
		{
			console.log("MULTIPLE LOGINS detected for: "+username);
			res = true;
		}
	}

	callback(res);
}

function userCreate(socket, username, password)
{
	//compose the query
	var columns = ['username','password','rank','bot_rank','global_rank','wins','losses','headshots','sprees','kills','deaths','assists'];
	var parts = ['hat','helmet','torso','shoulder','forearm','leg','shin','foot','prop'];
	for (var i=0; i<10; i++)
	{
		for (var j=0; j<parts.length; j++)
			columns.push(parts[j]+i);
	}
	var starting_parts = ['0013_new-user','0009_new-user','0010_new-user','0014_new-user','0015_new-user','0011_new-user','0012_new-user','0016_new-user','0017_new-user'];
	var str_starting_limbs = "";
	//10 indices
	for (var i=0; i<10; i++)
	{
		//8 body parts
		for (var j=0; j<9; j++)
		{
			str_starting_limbs += "\'";

			if (i==0)
				str_starting_limbs += starting_parts[j];
			else
				str_starting_limbs += '9999_empty';

			str_starting_limbs += "\'";

			if ((j<8)||(i<9))
				str_starting_limbs += ',';
		}
	}

	var vals = "('"+username+"', MD5(\'"+password+"\'), 1,1,0,0,0,0,0,0,0,0,"; //5,-1,-1,0,-1,-1,1,-1,-1,6,-1,-1,7,-1,-1,2,-1,-1,3,-1,-1,4,-1,-1)";
	vals += str_starting_limbs+')'

	var statement = "INSERT INTO users ("+columns+") VALUES "+vals;
	console.log("user create:\n"+statement+"\n\n");
	
	//execute the query
	dbConnection.query(statement, function(err,rows) {

		//log any errors
		if (err)
			console.log(err);

	});

	setTimeout(function(socket) {

  			console.log("recomputing global rank for: "+socket.myPlayer.pName);
  			recomputeGlobalRank(socket.myPlayer.pName, socket, -1);

		},1000, socket);

		setTimeout(function(socket) {

  			console.log("sending global rank to: "+socket.myPlayer.pName);
  			resendGlobalRank(socket.myPlayer.pName, socket);

		},2000, socket);

}

function sendHatStats(socket, objIndex, uniqueId)
{

	console.log("\n"+socket.myPlayer.pName+"'s hats are F'd\n");
	var columns = [];
	for (var i=0; i<10; i++)
	{
		columns.push("hat"+i);
	}

	//create package for this player to receive all his stats
	var pkgDude = new createPkg();

	//construct the query
	var statement = "SELECT ";
	for (var i=0; i<columns.length; i++)
	{
		var param = columns[i];
		statement += param;
		if (i<columns.length-1)
			statement += ", ";
	}
	statement += " FROM users where username='"+socket.myPlayer.pName+"'";

		//console.log(statement);

		//perform the query, obtain results, and send off to the local player
		dbConnection.query(statement, function(err,rows) {

			//log any errors
			if (err)
				console.log(err);

			//console.log("%j",rows[0]);

			//construct all the object updates and add to package
			for (var j=0; j<columns.length; j++)
			{
				var param = columns[j];
				var result = rows[0][param];

				//console.log("rows[0]["+param+"] = "+result);

				var message = {
				name: "objUpdate",
				object_index: objIndex,
				uniqueId: uniqueId,
				netvar: param,
				val: result,
				flag: 0
				};

				pkgDude.messages.push(message);
			}
			
			//send package
			socket.emit('pkg', pkgDude);

		});

}

function sendNetManPlayerStats(socket, objIndex, uniqueId)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;
	var columns = ['rank','bot_rank','global_rank','wins','losses','headshots','sprees','kills','deaths','assists'];
	var parts = ['hat','helmet','torso','shoulder','forearm','leg','shin','foot','prop'];
	for (var i=0; i<10; i++)
	{
		for (var j=0; j<parts.length; j++)
			columns.push(parts[j]+i);
	}


	//create package for this player to receive all his stats
	var pkgDude = new createPkg();

	//construct the query
	var statement = "SELECT ";
	for (var i=0; i<columns.length; i++)
	{
		var param = columns[i];
		statement += param;
		if (i<columns.length-1)
			statement += ", ";
	}
	statement += " FROM users where username='"+theDude.pName+"'";

		//console.log(statement);

		//perform the query, obtain results, and send off to the local player
		dbConnection.query(statement, function(err,rows) {

			//log any errors
			if (err)
				console.log(err);

			//console.log("%j",rows[0]);

			//construct all the object updates and add to package
			for (var j=0; j<columns.length; j++)
			{
				var param = columns[j];
				var result = rows[0][param];

				if (param=="rank")
				{
					//get him his starting global rank
					recomputeGlobalRank(theDude.pName,socket,result);
				}

				//console.log("rows[0]["+param+"] = "+result);

				var message = {
				name: "objUpdate",
				object_index: objIndex,
				uniqueId: uniqueId,
				netvar: param,
				val: result,
				flag: 0
				};

				pkgDude.messages.push(message);
			}
			
			//send package
			socket.emit('pkg', pkgDude);

		});
}

function sendCompletePlayerStats(socket, gameRoom, objIndex, broadcast_only)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;

	var columns = ['rank','bot_rank','global_rank','wins','losses','headshots','sprees','kills','deaths','assists'];
	var parts = ['hat','helmet','torso','shoulder','forearm','leg','shin','foot','prop'];
	for (var i=0; i<10; i++)
	{
		for (var j=0; j<parts.length; j++)
			columns.push(parts[j]+i);
	}

	//create package for this player to receive all his stats
	var pkgDude = new createPkg();

	//create package for others to receive a subset of all the stats -- they don't really need to know about everything
	var pkgAll = new createPkg();

	//construct the query
	var statement = "SELECT ";
	for (var i=0; i<columns.length; i++)
	{
		var param = columns[i];
		statement += param;
		if (i<columns.length-1)
			statement += ", ";
	}
	statement += " FROM users where username='"+theDude.pName+"'";

	console.log("full query: "+statement);

	//perform the query, obtain results, and send off to the local player
	dbConnection.query(statement, function(err,rows) {

		//log any errors
		if (err)
			console.log(err);

		//console.log("%j",rows[0]);

		//construct all the object updates and add to package
		for (var j=0; j<columns.length; j++)
		{
			var param = columns[j];
			var result = rows[0][param];

			//console.log("rows[0]["+param+"] = "+result);

			var message = {
				name: "objUpdate",
				object_index: objIndex,
				uniqueId: theDude.uniqueId,
				netvar: param,
				val: result,
				flag: 0
			};

			//push this statistic
			if (param.indexOf("1") > -1 || param.indexOf("2") > -1 || param.indexOf("3") > -1 || param.indexOf("4") > -1 || param.indexOf("5") > -1 || param.indexOf("6") > -1 || param.indexOf("7") > -1 || param.indexOf("8") > -1 || param.indexOf("9") > -1)
			{
				//push to the everyone package --> which we apparently aren't sending now......? ever....?
				pkgAll.messages.push(message);
			} else {
				//only send to the one dude
				pkgDude.messages.push(message);
			}

		}

		//SEND THE PACKAGE 
		if (broadcast_only)
			socket.broadcast.to(gameRoom).emit('pkg',pkgDude);
		else
			io.to(gameRoom).emit('pkg',pkgDude);

	});	

}


function createPkg() {
	this.messages = [];
}


//this basically makes player objects
function player(){
	this.pName = "John Doe";
	this.gameMode = "no_mode"; //can be ffa, tdm, or versus
	this.room = "no_room";
	this.uniqueId = -1;
	this.uniqueMatchId = -51;
	this.nextMapNum = -54;
}


//this basically makes room objects
function room(groupName, modeName, maxPlayers, minPlayers) {
	this.groupName = groupName;
	this.modeName = modeName;
	this.maxPlayers = maxPlayers;
	this.minPlayers = minPlayers;
	this.joinable = false;
}


//prints basic socket player info
function printPlayer(thePlayer) {
	return (thePlayer.pName+": "+thePlayer.gameMode+", "+thePlayer.room);
}


//returns an array of the sockets grouped in a certain room
function socketsInRoom(roomName) {
	namespace = "/";
	var theSockets = [];
	for (var socketId in io.nsps[namespace].adapter.rooms[roomName]) {
		if (io.sockets.connected[socketId].myPlayer.pName)
	    	theSockets.push(io.sockets.connected[socketId]);
	}

return theSockets;
}


//prints players in each room / socket group and shows general net stats
function showSocketGroups() {

	var numSockets = 0;
	var numTdm = 0;
	var numFfa = 0;
	var numVersus = 0;
	var numMenu = 0;

	console.log("\n\n\n\n\n\n\n\n\n\n\n\n\nSocket Groups:\n");
	for (var i=0; i<rooms.length; i++)
	{
		var sockets = [];
		sockets = socketsInRoom(rooms[i].groupName);

		//collect network stats

		numSockets += sockets.length;

		if ((rooms[i].groupName.indexOf("lobby") < 0)&&(rooms[i].groupName.indexOf("ffa") > -1))
			numFfa += sockets.length;
		else if ((rooms[i].groupName.indexOf("lobby") < 0)&&(rooms[i].groupName.indexOf("tdm") > -1))
			numTdm += sockets.length;
		else if ((rooms[i].groupName.indexOf("lobby") < 0)&&(rooms[i].groupName.indexOf("versus") > -1))
			numVersus += sockets.length;
		else if (((rooms[i].groupName.indexOf("lobby") < 0)))
			numMenu += sockets.length;

		//end network stats

		var playerNames = "";
		for (var j=0; j<sockets.length; j++) {
			playerNames += sockets[j].myPlayer.pName;

			if (j<sockets.length-1)
				playerNames += ", ";
		}
		console.log("\t"+rooms[i].groupName+": "+playerNames);
	}
	console.log("\n\nPlayers Online: "+numSockets+"\nPlayers Matchmaking: "+(numSockets - numVersus - numTdm - numFfa - numMenu)+"\nPlaying TDM: "+numTdm+"\nPlaying FFA: "+numFfa+"\nPlaying Verus: "+numVersus+"\n\n");
	console.log("\n\n\n");
}

function sort_uniqueIds(room, interval_handle)
{
	var playas = [];
	playas = socketsInRoom(room.groupName);

	//console.log('..sorting uniqueIds for '+room.groupName);

	if (playas.length == 0)
	{
		console.log("ALERT: no players in "+room.groupName+" anymore. closing down.");
		room.joinable = false;
		clearInterval(interval_handle);
		return false;
	}

	for (var i=0; i<playas.length; i++)
	{
		if (playas[i].myPlayer.uniqueId != i)
		{
			console.log("Reassigning uniqueId: "+playas[i].myPlayer.pName+" : "+i);
			
			var message = {
				name: "objUpdate",
				object_index: avatarObjIndex,
				uniqueId: playas[i].myPlayer.uniqueId,
				netvar: "uniqueId",
				val: i, //multiplied by room speed!
				flag: FL_NORMAL
			}

			playas[i].myPlayer.uniqueId = i;

			playas[i].emit('obj_update',message);
		}
	}
	return true;
}

function find_joinable_game_room(starting_room_offset, mode_name, playerSubGroup)
{
	var i = starting_room_offset+1; //don't want to include the friggin lobby, so add 1
	var datRoom = rooms[i];

	//BOT MATCHES NOT JOINABLE AT THIS POINT
	if (datRoom.groupName.indexOf("bot") > -1)
		return false;

	while (datRoom.groupName.indexOf(mode_name) > -1)
	{
		console.log("\t..checking: "+datRoom.groupName);
		console.log("\t\tjoinable: "+datRoom.joinable+", socketsInRoom: "+socketsInRoom(datRoom.groupName).length);
		if ((datRoom.joinable)&&(socketsInRoom(datRoom.groupName).length > 0))
		{
			//are there few enough players to support this many additions
			var num_incoming_players = playerSubGroup.length;
			console.log("\t\t"+num_incoming_players+" prospective incoming players ... ");
			if (datRoom.maxPlayers >= socketsInRoom(datRoom.groupName).length+num_incoming_players)
			{
				console.log("\t\t\t"+datRoom.groupName+" is joinable for "+num_incoming_players);
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

function room_with_name(roomName)
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

function player_in_array(player,array)
{
	for (var i=0; i<array.length; i++)
	{
		if (array[i].pName == player.myPlayer.pName)
			return true;
	}		
	return false;
}

function force_sync_doll(socket)
{
	var msg = {
				name: "generalMessage",
				msg: "force_sync_doll",
				val: 0
			};

	socket.emit("general_message",msg);
}

function configure_match(playerSubGroup, gameRoom, wait_time) {
	//generate unique match id for intelligent timeout function expiration
	var dat_num = generate_uniqueMatchId();

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
		var message = {
				name: "objUpdate",
				object_index: netManObjIndex,
				uniqueId: default_netman_uniqueId,
				netvar: "next_map",
				val: mapNum,
				flag: 0
		}
		io.to(gameRoom).emit('obj_update',message);

		//update lobby wait time
		var message = {
				name: "objUpdate",
				object_index: netManObjIndex,
				uniqueId: default_netman_uniqueId,
				netvar: "lobby_wait_time",
				val: Math.ceil((wait_time-1000)/1000*30), //multiplied by room speed!
				flag: 0
		}
		io.to(gameRoom).emit('obj_update',message);
	},1000);

	//shuffle around people's uniqueIds based on who is still in the match
	id_shuffler = setInterval(function(gameRoom){
		sort_uniqueIds(room_with_name(gameRoom), id_shuffler);
	},1000,gameRoom);
	

	//send save and quit armory message with plenty of time left over (3 seconds)
	setTimeout(function(playerSubGroup, uniqueMatchId, gameRoom, id_shuffler) {
		
		console.log("id_shuffler = "+id_shuffler);
		clearInterval(id_shuffler);

		console.log("recomputing playerSubGroup to be inclusive of newly joined players");
		playerSubGroup = socketsInRoom(gameRoom);
		console.log("new playerSubGroup: "+playerSubGroup.length+" players");

		if (check_match_expired(playerSubGroup, uniqueMatchId, gameRoom))
		{
			console.log("aborting the save/quit armory command");
			return false;
		}

		var blah = {
			name: "generalMessage",
			msg: "lock_armory",
			val: 0
		};
		console.log(blah.name+" : "+blah.msg+" : "+blah.val);
		io.to(gameRoom).emit('general_message',blah);

		//make lobby no longer joinable
		room_with_name(gameRoom).joinable = false;

	}, wait_time-5000, playerSubGroup, dat_num, gameRoom, id_shuffler);

	//THIS IS A NEW LOBBY --> GET READY AND SET TO MAX WAIT TIME
	setTimeout(function(playerSubGroup, gameRoom, mapNum, uniqueMatchId) {
		//now that everyone is in the right game socket group and lobby wait time is over, let's trigger the game maker match to start
		//pick a random map from 1 --> num_maps

		//playerSubGroup should be recomputed since people might have joined
		console.log("recomputing playerSubGroup to be inclusive of newly joined players");
		playerSubGroup = socketsInRoom(gameRoom);
		console.log("new playerSubGroup: "+playerSubGroup.length+" players");
		
		if (check_match_expired(playerSubGroup,uniqueMatchId, gameRoom))
		{
			console.log("ABORTING --> this match has expired");
			return false;
		}

		console.log("selected map number:  "+mapNum);

		//make everyone go to the map
		var firstMsg = {
			name: "generalMessage",
			msg: "goto_map",
			val: mapNum
		};
		console.log(firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
		io.to(gameRoom).emit('general_message',firstMsg);

		setTimeout(function(playerSubGroup, gameRoom) {

			//create all of the players
			for (var s=0; s<playerSubGroup.length; s++)
			{
				var eachSocket = playerSubGroup[s];

				eachSocket.myPlayer.timeoutHandle = null;

				//construct player object with all known attributes of socket

				var message = {
					name: "objCreate",
					object_index: playerObjIndex,
					uniqueId: eachSocket.myPlayer.uniqueId,
					myX: Math.random()*1024,
					myY: Math.random()*768
				};

				//s will now be the uniqueId of this socket's player for the duration of the match
				//eachSocket.myPlayer.uniqueId = s;

				io.to(gameRoom).emit('obj_create',message);

				message = {
					name: "objUpdate",
					object_index: playerObjIndex,
					uniqueId: eachSocket.myPlayer.uniqueId,
					netvar: "pName",
					val: eachSocket.myPlayer.pName,
					flag: 0
				}

				io.to(gameRoom).emit('obj_update',message);

				//send complete player statistics to everyone
				sendCompletePlayerStats(eachSocket, gameRoom, playerObjIndex, false);

			}

		}, 10, playerSubGroup, gameRoom);

	}, wait_time, playerSubGroup,gameRoom, mapNum, dat_num);
}

function join_match(playerSubGroup, gameRoom)
{

	//JOIN THIS MATCH!!
	console.log("found joinable preexisting match for "+playerSubGroup.length+" new players");
	console.log("attempting to join room: "+gameRoom);

	//grab the first player already in this lobby from which to extract some data
	var p1 = socketsInRoom(gameRoom)[0];
	console.log("using "+p1.myPlayer.pName+" for newly joined player data synchronization");

	console.log("bringing "+playerSubGroup.length+" players to game room: "+gameRoom);

	//make everyone go to the lobby -- where stuff is going to get real
			var firstMsg = {
				name: "generalMessage",
				msg: "goto_lobby",
				val: 0
			};
			console.log(firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);

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

		console.log(firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
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
				var message = {
					name: "objCreate",
					object_index: avatarObjIndex,
					uniqueId: eachSocket.myPlayer.uniqueId,	//already established by sort_uniqueIds
					myX: Math.random()*1024,
					myY: Math.random()*0
				};

				eachSocket.broadcast.to(gameRoom).emit('obj_create',message);

				message = {
					name: "objUpdate",
					object_index: avatarObjIndex,
					uniqueId: eachSocket.myPlayer.uniqueId,
					netvar: "pName",
					val: eachSocket.myPlayer.pName,
					flag: 0
				}
				io.to(gameRoom).emit('obj_update',message);

				//update the avatar's uniqueId locally
				message = {
					name: "objUpdate",
					object_index: avatarObjIndex,
					uniqueId: eachSocket.myPlayer.pName,
					netvar: "uniqueId",
					val: eachSocket.myPlayer.uniqueId, 	//wanted to be s
					flag: 0
				}
				eachSocket.emit('obj_update',message);

				//send complete AVATAR statistics to everyone
				sendCompletePlayerStats(eachSocket, gameRoom, avatarObjIndex, true);
			}

			//create the preexisting avatars for the newly joined players
			console.log("recreating preexisting avatars for newly joined players");
			var allPlayers = socketsInRoom(gameRoom);
			for (var m=0; m<allPlayers.length; m++)
			{
				var somePlayer = allPlayers[m];
				if (player_in_array(somePlayer,playerSubGroup) == false)
				{
					console.log("\trecreating "+somePlayer.myPlayer.pName);
					for (var k=0; k<playerSubGroup.length; k++)
					{
						
						var eachSocket = playerSubGroup[k];

						console.log("\t\t..for "+eachSocket.myPlayer.pName);

						if (eachSocket.myPlayer.pName==somePlayer.myPlayer.pName)
						{
							console.log("\t\t\tBAIL same pName");
							continue;
						}

						if (eachSocket.myPlayer.uniqueId==somePlayer.myPlayer.uniqueId)
						{
							console.log("\t\t\tBAIL same uniqueId");
							continue;
						}

						//this is not a new player, so create his avatar for this new player
						var message = {
							name: "objCreate",
							object_index: avatarObjIndex,
							uniqueId: somePlayer.myPlayer.uniqueId,
							myX: Math.random()*1024,
							myY: Math.random()*0
						};

						console.log("\t\t\temitted create");

						eachSocket.emit('obj_create',message);

						message = {
							name: "objUpdate",
							object_index: avatarObjIndex,
							uniqueId: somePlayer.myPlayer.uniqueId,
							netvar: "pName",
							val: somePlayer.myPlayer.pName,
							flag: 0
						}
						eachSocket.emit('obj_update',message);
					}

					//send complete AVATAR statistics to everyone
					force_sync_doll(somePlayer);
				}
				else
				{
					console.log("\tNOT recreating "+somePlayer.myPlayer.pName);
				}
			}

		}, 500, playerSubGroup, gameRoom);

	//update that stuff that was set for everyone else in match_configure
	setTimeout(function(p1) {
			//update next_map
			var message = {
					name: "objUpdate",
					object_index: netManObjIndex,
					uniqueId: default_netman_uniqueId,
					netvar: "next_map",
					val: p1.myPlayer.nextMapNum,
					flag: 0
			}
			io.to(gameRoom).emit('obj_update',message);
		},1000, p1);

}

//---- PERFORMS MATCHMAKING ----//

function makeMatches(){
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
				console.log("not enough players in "+rooms[i].groupName+" to start a fresh match");
				//FIRST FIND ANY JOINABLE EXISTING LOBBIES OUT THERE
				console.log("checking for joinable matches");
				var candidate = find_joinable_game_room(i, rooms[i].modeName, lobbyMembers);
				if (candidate)
				{
					console.log("found a joinable room");
					gameRoom = candidate.groupName;
					join_match(lobbyMembers, gameRoom);
					continue;
				} else console.log("\t...none found");
			}
			else if (lobbyMembers.length > 0)
			{

				console.log("\nenough players in "+rooms[i].groupName+" to start a match");

				//divide lobby players into groups of acceptable size for this match type
				while (lobbyMembers.length >= rooms[i].minPlayers)
				{
					console.log("grouping "+rooms[i].groupName+" sockets");
					var playerSubGroup = [];
					//make the biggest group of players you can based on how many left in lobby
					while ((playerSubGroup.length<rooms[i].maxPlayers)&&(lobbyMembers.length>0))
						playerSubGroup.push(lobbyMembers.pop());

					//find a game lobby for this player group
					var roomOffset = 1;
					var gameRoom = rooms[i+roomOffset].groupName;

					//console.log("gameRoom = "+gameRoom);
					//console.log("rooms[i].modeName = "+rooms[i].modeName);
					console.log("looking for a joinable game room...");

					//FIRST FIND ANY JOINABLE EXISTING LOBBIES OUT THERE
					var candidate = find_joinable_game_room(i, rooms[i].modeName, playerSubGroup);
					console.log("done searching");
					if (candidate)
					{
						console.log("found a joinable room");
						gameRoom = candidate.groupName;
						join_match(playerSubGroup, gameRoom);

					}
					else //search for empty matches b/c none were joinable / in progress
					{
						console.log("no joinable game rooms ... looking for an empty game room...");
						whileLoop:
						while (gameRoom.indexOf(rooms[i].modeName) > -1)
						{

							//EMPTY PROSPECTIVE MATCHES ONLY -- NO PLAYER WAITING IN A 'LOBBY' OR ANYTHING
							if (socketsInRoom(gameRoom).length == 0)
							{
								console.log("migrating "+playerSubGroup.length+" players to game room: "+gameRoom);
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
								var firstMsg = {
									name: "generalMessage",
									msg: "goto_lobby",
									val: 0
								};
								console.log(firstMsg.name+" : "+firstMsg.msg+" : "+firstMsg.val);
								io.to(gameRoom).emit('general_message',firstMsg);

								//CREATE ALL PLAYER AVATARS
								setTimeout(function(playerSubGroup, gameRoom) {

										//create all of the avatars
										for (var s=0; s<playerSubGroup.length; s++)
										{
											var eachSocket = playerSubGroup[s];

											//CREATE THIS AVATAR FOR EVERYONE (EXCEPT LOCAL PLAYER)
											var message = {
												name: "objCreate",
												object_index: avatarObjIndex,
												uniqueId: s,
												myX: Math.random()*1024,
												myY: Math.random()*0
											};

											//s will now be the uniqueId of this socket's player for the duration of the match
											eachSocket.myPlayer.uniqueId = s;

											eachSocket.broadcast.to(gameRoom).emit('obj_create',message);

											message = {
												name: "objUpdate",
												object_index: avatarObjIndex,
												uniqueId: s,
												netvar: "pName",
												val: eachSocket.myPlayer.pName,
												flag: 0
											}
											io.to(gameRoom).emit('obj_update',message);

											//update the avatar's uniqueId locally
											message = {
												name: "objUpdate",
												object_index: avatarObjIndex,
												uniqueId: default_avatar_uniqueId,
												netvar: "uniqueId",
												val: s,
												flag: 0
											}
											eachSocket.emit('obj_update',message);

											//send complete AVATAR statistics to everyone
											sendCompletePlayerStats(eachSocket, gameRoom, avatarObjIndex, true);

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