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

var conn;
var io;

//---- LOAD MODULES ----//
var mysql = require('mysql');
var fs = require('fs');
var log = require('./logger.js');
var util = require('util');
var composer = require('./composer.js');

var stats = ['rank','xp','ppl','kdr','wl','time','points','kills','deaths','assists','wins','losses','kill_streak','win_streak', 'rollover_kstreak', 'rollover_wstreak', 'global_rank','kdr_history','ppl_history','win_history']
var bot_stats = ['bot_rank','ppl','kdr','wl','points','kills','deaths','assists','wins','losses','kill_streak','win_streak', 'rollover_kstreak', 'rollover_wstreak', 'kdr_history','ppl_history','win_history']
var accolades = ['dub_kill','trip_kill','stick_kill','flash_bandicoot','flame_kill','ink_kill','cant_touch_dis','mvp','highest_kd','10kd','ninja','survivor','3ass','5ass','3gibs','6gibs','9gibs','12gibs','3heads','6heads','9heads','12heads','3ks','5ks','10ks','15ks','20ks','25ks','spr_flame','spr_ink','spr_snare','spr_smoke','spr_flashbang','spr_pistol','spr_carbine','spr_rifle','spr_tickler','spr_smg','spr_sticky','spr_lmg','spr_longshot','spr_vulcan','spr_torque','spr_thumper','spr_boltok','spr_shotgun','spr_stomper','spr_boom','spr_frag','spr_rocket','spr_double','spr_wep1','spr_wep2','spr_wep3','spr_wep4'];

var accolades_init = []
for (var i=0; i<accolades.length; i++)
{
	accolades_init.push('0');
}

var stats_init = []
for (var i=0; i<stats.length; i++)
	stats_init.push('0')

var bot_stats_init = []
for (var i=0; i<bot_stats.length; i++)
	bot_stats_init.push('0')

exports.stats = stats;
exports.bot_stats = stats;
exports.accolades = accolades;
exports.accolades_init = accolades_init;
exports.stats_init = stats_init;
exports.bot_stats_init = bot_stats_init;

//CONTROL DEFAULTS
cnames = ["Move Left", "Move Right", "Jump", "Crouch", "Evade", "Previous Weapon", "Next Weapon", "Quickselect Sidearm", "Pick Up Weapon", "Reload", "Shoot", "Quicktoss Grenade", "Select Primary", "Select Secondary", "Select Sidearm", "Select Grenades", "Drop Weapon", "Mouse Sensitivity", "Look Sensitivity","Swap Sticks"];
cdefaults = [65,68,87,83,16,81,69,32,32,82,1,2,49,50,51,52,88,1,1,0];
cgpdefaults = [32785,32785,32769,32770,32775,32779,32780,32772,32771,32773,32776,32774,32784,32783,32782,32781,32777,55,95,0];
cindices = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];

exports.cnames = cnames;
exports.cdefaults = cdefaults;
exports.cindices = cindices;

//how to remake the users table when you need to
var statement = 'create table users (username VARCHAR(20), password VARCHAR(32), ';
var parts = ['hat','helmet','torso','shoulder','forearm','leg','shin','foot','prop'];
for (var i=0; i<NUM_BPARTS; i++)
{
	for (var j=0; j<parts.length; j++)
	{
		statement += parts[j]+i;
		statement += ' TEXT';
		if ((i<NUM_BPARTS-1)||(j<parts.length-1))
			statement += ', ';
	}
}
statement += ');';
log.log(SQL,statement);


//sql create challenges + friends
//create table friends (username VARCHAR(20), friend VARCHAR(20));
//create table challenges (username VARCHAR(20), challenge_name text);
//create table controls (username VARCHAR(20), control_name text, control_index real, control_code real, using_gamepad real);
//create table stats (username VARCHAR(20), rank real, xp real, ppl real, kdr real, wl real, time real, points real, kills real, deaths real, assists real, wins real, losses real, kill_streak real, win_streak real, rollover_kstreak real, rollover_wstreak real, global_rank real, kdr_history text, ppl_history text, win_history text);
//create table bot_stats (username VARCHAR(20), bot_rank real, ppl real, kdr real, wl real, points real, kills real, deaths real, assists real, wins real, losses real, kill_streak real, win_streak real, rollover_kstreak real, rollover_wstreak real, kdr_history text, ppl_history text, win_history text);
//create table accolades (username VARCHAR (20), dub_kill real, trip_kill real, stick_kill real, flash_bandicoot real, flame_kill real, ink_kill real, cant_touch_dis real, mvp real, highest_kd real, 10kd real, ninja real, survivor real, 3ass real, 5ass real, 3gibs real, 6gibs real, 9gibs real, 12gibs real, 3heads real, 6heads real, 9heads real, 12heads real, 3ks real, 5ks real, 10ks real, 15ks real, 20ks real, 25ks real
//, spr_flame real, spr_ink real, spr_snare real, spr_smoke real, spr_flashbang real, spr_pistol real, spr_carbine real, spr_rifle real, spr_tickler real, spr_smg real, spr_sticky real, spr_lmg real, spr_longshot real, spr_vulcan real, spr_torque real, spr_thumper real, spr_boltok real, spr_shotgun real, spr_stomper real, spr_boom real, spr_frag real, spr_rocket real, spr_double real, spr_wep1 real, spr_wep2 real, spr_wep3 real, spr_wep4 real);
//create table bot_accolades (username VARCHAR (20), dub_kill real, trip_kill real, stick_kill real, flash_bandicoot real, flame_kill real, ink_kill real, cant_touch_dis real, mvp real, highest_kd real, 10kd real, ninja real, survivor real, 3ass real, 5ass real, 3gibs real, 6gibs real, 9gibs real, 12gibs real, 3heads real, 6heads real, 9heads real, 12heads real, 3ks real, 5ks real, 10ks real, 15ks real, 20ks real, 25ks real
//, spr_flame real, spr_ink real, spr_snare real, spr_smoke real, spr_flashbang real, spr_pistol real, spr_carbine real, spr_rifle real, spr_tickler real, spr_smg real, spr_sticky real, spr_lmg real, spr_longshot real, spr_vulcan real, spr_torque real, spr_thumper real, spr_boltok real, spr_shotgun real, spr_stomper real, spr_boom real, spr_frag real, spr_rocket real, spr_double real, spr_wep1 real, spr_wep2 real, spr_wep3 real, spr_wep4 real);
//update bot_stats set kdr_history = '1.75,5,3.50,2.50,1.67,3.33,5,3.33,1,0.5,10,2.2,1.98,0.2,0.3,0.4,4,0,0,0,2,3,4,5,6,7,2,6,7,11,6,4,1' where username='kyle'
//update bot_stats set ppl_history = '188,532,418,262,218,465,542,390,150,200,350,150,510,125,112,100,110,190,210,50,20,10,0,0,90,99,125,150,160,110,110,96,98,45,87,356,567,225,260' where username='kyle'
//update bot_stats set win_history = '11,10,9,8,7,6,5,4,1,2,3,4,3,2,1,0,-1,0,-1,-2,-3,-4,-3,-2,-3,-2,-1,0,0,0,0,1,1,2,3,4,5,6,7,8' where username='kyle'
//update bot_accolades set dub_kill=3,trip_kill=2,flash_bandicoot=1,flame_kill=5,survivor=8,3ass=1,6gibs=2,3heads=1,6heads=2,3ks=4,5ks=2,10ks=1,15ks=1 where username='kyle';


//exports
exports.connect = function(connectMe, callback)
{
	connectMe = mysql.createConnection({
		host	: 	'localhost',
		user	: 	'kserver',
		password : 	'boomer92',
		database : 	'griefer'
	});

	connectMe.connect(function(err) {
		if (err) {
			console.error('ERROR: database conn failed: '+err.stack);
			return;
		}
		log.log(SQL,'CONNECTED to griefer database, as id: '+connectMe.threadId);
		conn = connectMe;
		global.conn_ready = true;
		callback();
	});

	connectMe.on('error', function(err) {
	  log.log(SQL,err.code); // 'ER_BAD_DB_ERROR'
	});
};

exports.getConn = function()
{
	return conn
}

exports.delete_users = function(users)
{
	for (var i=0; i<users.length; i++)
	{	
		exports.userDelete(users[i]);
	}
};

exports.setIo = function(io_2set) {
	io = io_2set
};

var execute = function(statement)
{
	conn.query(statement, function(err,rows) {
		if (err)
			log.log(SQL,err);
	});
}
exports.execute = execute


var updateStat = function(username, stat, value, flag)
{
	var statement;

	var table = "stats"

	if (flag==FL_BOT)
		table = "bot_stats"
	statement = "UPDATE "+table+" SET "+stat+" = '"+value+"' WHERE username="+conn.escape(username);

	if (flag==FL_SQL)
		statement = stat;

	log.log(SQL,statement);

	conn.query(statement, function (err, rows) {

		//log any errors
		if (err)
			log.log(SQL,err);
		else {
			return true;
		}
		return false;
	});
}
exports.updateStat = updateStat

var updateAccolade = function(username, accolade, value, flag)
{
	var statement;

	var table = "accolades"

	if (flag==FL_BOT)
		table = "bot_accolades"
	statement = "UPDATE "+table+" SET "+accolade+" = '"+value+"' WHERE username="+conn.escape(username);

	if (flag==FL_SQL)
		statement = accolade;

	log.log(SQL,statement);

	conn.query(statement, function (err, rows) {

		//log any errors
		if (err)
			log.log(SQL,err);
		else {
			return true;
		}
		return false;
	});
}
exports.updateAccolade = updateAccolade


var userExists = function(username, callback)
{
	var result = 0;
	conn.query("SELECT * from users WHERE username="+conn.escape(username), result, function (err,rows) {
		//log any errors
		if (err)
			log.log(SQL,err);

		if (rows.length > 0)
		{
			log.log(SQL,"USER ALREADY EXISTS....");
			result = 1;
		} else {
			log.log(SQL,"USER DOES NOT EXIST!");
			result = 0;
		}

		callback(result);

	});

	return result;
}
exports.userExists = userExists

var correctPassword = function(socket, username, password, callback)
{
	//log.log(SQL,'testing password for user: '+username);
	var statement = "SELECT * from users WHERE username="+conn.escape(username)+" AND password=MD5("+conn.escape(password)+")";
	//log.log(SQL,statement);

	var result = 0;

	log.log(SQL,statement);

	conn.query(statement, function (err, rows) {

		//log.log(SQL,"rows.length = "+rows.length);
		log.log(SQL,"done with password query");
		result = rows.length;

		if (rows.length > 0)
		{
			log.log(SQL,"good password for user: "+username);
			result = 1;
			callback(result);
		} else {
			log.log(SQL,"bad password for user: "+username);
			result = 0;
			authUnameExists(socket, username, password, callback);
		}

	});
}
exports.correctPassword = correctPassword

var authUnameExists = function(socket, username, password, callback)
{
	var statement = "SELECT * from users WHERE username="+conn.escape(username);
	var result = 0;

		conn.query(statement, function (err, rows) {
			result = rows.length;

			if (rows.length > 0)
			{
				log.log(SQL,"authUname Exists");
				result = 0;
				callback(result);
			} else {
				log.log(SQL,"authUname Does Not Exist");
				result = 2;

				var message = {
				  		name: "generalMessage",
				  		msg: "user_create_result",
				  		val: 0
				  	};

			  	log.log(SQL,'sending first user: '+username);
		  		userCreate(socket, username, password);
		  		message.val = 1;
		  		socket.emit('general_message',message);
			}
			
		});
}
exports.authUnameExists = authUnameExists

var alreadyLoggedIn = function(username, callback)
{
	var res = false;

	for (var i=0; i<clients.length; i++)
	{
		if (clients[i].myPlayer.pName == username)
		{
			log.log(SQL,"MULTIPLE LOGINS detected for: "+username);
			res = true;
		}
	}

	callback(res);
}
exports.alreadyLoggedIn = alreadyLoggedIn

var userDelete = function(username)
{
	var tables = ['users','stats','bot_stats','challenges','controls','accolades','bot_accolades'];
	for (var i=0; i<tables.length; i++)
	{
		var where = " where username='"+username+"'";
		if (username == FL_WIPE)
			where = ""
		var statement = "delete from "+tables[i]+where
		execute(statement)
	}
}
exports.userDelete = userDelete

var userCreate = function(socket, username, password)
{
	//compose the query
	var columns = ['username','password'];
	var parts = ['hat','helmet','torso','shoulder','forearm','leg','shin','foot','prop'];
	for (var i=0; i<NUM_BPARTS; i++)
	{
		for (var j=0; j<parts.length; j++)
			columns.push(parts[j]+i);
	}
	var starting_parts = ['0013_new-user','0009_new-user','0010_new-user','0014_new-user','0015_new-user','0011_new-user','0012_new-user','0016_new-user','0017_new-user'];
	var str_starting_limbs = "";
	//10 indices
	for (var i=0; i<NUM_BPARTS; i++)
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

			if ((j<8)||(i<NUM_BPARTS-1))
				str_starting_limbs += ',';
		}
	}

	log.log(SQL,"\n\nincoming new username: "+conn.escape(username)+" : "+username+"\n\n");

	var vals = "("+conn.escape(username)+", MD5("+conn.escape(password)+"), "; //5,-1,-1,0,-1,-1,1,-1,-1,6,-1,-1,7,-1,-1,2,-1,-1,3,-1,-1,4,-1,-1)";
	vals += str_starting_limbs+')'

	//username, password, and default limbs
	var statement = "INSERT INTO users ("+columns+") VALUES "+vals;
	log.log(SQL,"user create:\n"+statement+"\n\n");
	execute(statement);

	//stats
	statement = "INSERT INTO stats ("+"username, "+stats+") VALUES ("+conn.escape(username)+', '+stats_init+')';
	log.log(SQL,"user create:\n"+statement+"\n\n");
	execute(statement);
	//bot stats
	statement = "INSERT INTO bot_stats ("+"username, "+bot_stats+") VALUES ("+conn.escape(username)+', '+bot_stats_init+')';
	log.log(SQL,"user create:\n"+statement+"\n\n");
	execute(statement);

	//accolades
	statement = "INSERT INTO accolades ("+"username, "+accolades+") VALUES ("+conn.escape(username)+', '+accolades_init+')';
	log.log(SQL,"user create:\n"+statement+"\n\n");
	execute(statement);

	//bot accolades
	statement = "INSERT INTO bot_accolades ("+"username, "+accolades+") VALUES ("+conn.escape(username)+', '+accolades_init+')';
	log.log(SQL,"user create:\n"+statement+"\n\n");
	execute(statement);


	//MAKE ENTRIES IN CONTROL DEFAULTS

	//entries for normal controls
	for (var i=0; i<cindices.length; i++)
	{
		columns = ['username','control_name','control_index','control_code','using_gamepad'];
		vals = "('"+username+"', '"+cnames[i]+"', "+cindices[i]+", "+cdefaults[i]+", 0"+")";
		statement = "INSERT INTO controls ("+columns+") VALUES "+vals;
		log.log(SQL,"keyboard control defaults:\n"+statement+"\n\n");
		conn.query(statement, function(err,rows) {
			//log any errors
			if (err)
				log.log(SQL,err);
		});
	}

	//entries for game pad controls
	for (var i=0; i<cindices.length; i++)
	{
		columns = ['username','control_name','control_index','control_code','using_gamepad'];
		vals = "('"+username+"', '"+cnames[i]+"', "+cindices[i]+", "+cgpdefaults[i]+", 1"+")";
		statement = "INSERT INTO controls ("+columns+") VALUES "+vals;
		log.log(SQL,"gamepad control defaults:\n"+statement+"\n\n");
		conn.query(statement, function(err,rows) {
			//log any errors
			if (err)
				log.log(SQL,err);
		});
	}

}
exports.userCreate = userCreate;


var appendHistoryStat = function(socket,stat,val,flag)
{
	//this really "appends" to the FRONT
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;

	var history_max = 100
	
	var table = "bot_stats"

	if (flag != FL_BOT)
		table = "stats"

	var select = "SELECT "+stat+" from "+table+" where username='"+username+"'";

	conn.query(select, function(err,rows) {

			//log any errors
			if (err)
				log.log(SQL,err);

			var hist = rows[0][stat];

			//append the new val to the history string
			if (hist.length < 2 && hist.indexOf(",") == -1)
			{
				//this is the first entry, so wipe out what was in there and add a comma
				if (typeof val != "string")
				{
					log.log(SQL,'WARNING: casting history stat update val to string')
					val = toString(val)
				}

				hist = ''
			}
			else
			{
				//figure out how many entries there
				var entries = hist.split(",").length

				//lop its tail if too many
				if (entries > history_max -1)
				{
					hist = hist.substring(0,hist.lastIndexOf(","))
				}
			}

			//append our new value
			hist = val+","+hist

			//now update back into database
			var update = "UPDATE "+table+" set "+stat+"='"+hist+"' where username='"+username+"'";
			log.log(SQL,update);

			execute(update);
	});
}
exports.appendHistoryStat = appendHistoryStat


var sendPermaChallenges = function(socket)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;
	var statement = "SELECT challenge_name from challenges where username='"+username+"'";

	conn.query(statement, function(err,rows) {

			//log any errors
			if (err)
				log.log(SQL,err);

			for (var i=0; i<rows.length; i++)
			{
				var challenge_name = rows[i]["challenge_name"];
				var msg = genMessage("perma_challenge",challenge_name);
				log.log(SQL,msg);
				socket.emit("general_message",msg);
			}
	});
}
exports.sendPermaChallenges = sendPermaChallenges

var sendAccolades = function(socket, flag, retransmit)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;

	var table = "accolades";
	var retransmit_flag = FL_BOT

	if (flag == FL_BOT)
	{
		table = "bot_accolades";
		retransmit_flag = FL_NORMAL
	}

	if (retransmit)
	{
		log.log(SQL,"sending the other half of the accolades as well")
		sendAccolades(socket,retransmit_flag,false);
	}

	var statement = "SELECT * from "+table+" WHERE username='"+username+"'";

	conn.query(statement, function(err,rows) {

			var pkgDude = new composer.createPkg();

			//log any errors
			if (err)
				log.log(SQL,err);

			for (var i=0; i<accolades.length; i++)
			{
				var acc_name = accolades[i];
				var acc_val = rows[0][accolades[i]];
				var msg = bigMessage("accolade",acc_name,acc_val,flag);
				log.log(SQL,msg);
				pkgDude.messages.push(msg);
			}

			socket.emit('pkg',pkgDude.messages);
			log.log(SQL,pkgDude.messages);
	});
}
exports.sendAccolades = sendAccolades


var getPersonalStats = function(socket,flag)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;
	var pstats = ['ppl','kdr','wl','points','kills','deaths','assists','wins','losses','kill_streak','win_streak','kdr_history','ppl_history','win_history'];
	var table = "bot_stats";

	if (flag != FL_BOT)
	{
		pstats.push('rank');
		pstats.push('xp');
		pstats.push('time');
		table = "stats";
	}

	var statement = "SELECT "+pstats+" from "+table+" where username='"+username+"'";

	conn.query(statement, function(err,rows) {

		//create package for this player to receive all his stats
		var pkgDude = new composer.createPkg();

			//log any errors
			if (err)
				log.log(SQL,err);

			for (var i=0; i<rows.length; i++)
			{
				for (var j=0; j<pstats.length; j++)
				{
					var stat_val = rows[i][pstats[j]];

					var msg = bigMessage("personal_stat",username,pstats[j],stat_val);
					pkgDude.messages.push(msg);
				}
			}

		socket.emit('pkg',pkgDude.messages);
		log.log(SQL,pkgDude.messages);

	});
}
exports.getPersonalStats = getPersonalStats

function getGlobalStats(socket)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;
	var pstats = ['username','ppl','kdr','wl','kills','deaths','assists','wins','losses','kill_streak','win_streak'];
	var table = "bot_stats";

	{
		pstats.push('rank');
		pstats.push('xp');
		pstats.push('time');
		table = "stats";
	}

	//send the leaderboard dimensions
	var statement2 = "SELECT count(*) from users";

	conn.query(statement2, function(err,rows) {

		//create package for this player to receive all his stats
		var pkgDude = new composer.createPkg();

			//log any errors
			if (err)
				log.log(SQL,err);

			var user_count = rows[0]["count(*)"];
			var msg = bigMessage("leaderboard_dimensions",user_count,pstats.length,0);
			log.log(SQL,msg);
			pkgDude.messages.push(msg);

			//selecting everyone's!
			var statement = "SELECT "+pstats+" from "+table;

			conn.query(statement, function(err,rows) {

					//log any errors
					if (err)
						log.log(SQL,err);

					for (var i=0; i<rows.length; i++)
					{
						for (var j=0; j<pstats.length; j++)
						{
							var stat_val = rows[i][pstats[j]];

							var msg = bigMessage("global_stat",rows[i]['username'],pstats[j],stat_val);
							
							pkgDude.messages.push(msg);
						}
					}

					socket.emit('pkg',pkgDude.messages);
					log.log(SQL,pkgDude.messages);
			});
	});
}

var sendControlMaps = function(socket)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;

	var statement = "SELECT control_index, control_code, using_gamepad from controls where username='"+username+"'";
	conn.query(statement, function(err,rows) {

			//log any errors
			if (err)
				log.log(SQL,err);

			if (!rows) return false;

			for (var i=0; i<rows.length; i++)
			{
				var control_index = rows[i]["control_index"];
				var control_code = rows[i]["control_code"];
				var using_gamepad = rows[i]["using_gamepad"];

				var msg = bigMessage("control_map",control_index,control_code,using_gamepad);
				log.log(SQL,msg);
				socket.emit("big_message",msg);
			}
	});
}
exports.sendControlMaps = sendControlMaps

var addPermaChallenge = function(socket,challenge_name)
{
	var username = socket.myPlayer.pName;
	var statement = "INSERT INTO challenges (username, challenge_name) VALUES ('"+username+"','"+challenge_name+"')";
	conn.query(statement, function(err,rows) {
			//log any errors
			if (err)
				log.log(SQL,err);
	});
}
exports.addPermaChallenge = addPermaChallenge

var sendNetManPlayerStats = function(socket, objIndex, uniqueId)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;
	var columns = ['stats.rank','stats.xp','stats.global_rank','stats.wins','stats.losses','stats.kills','stats.deaths','stats.assists'];
	var parts = ['users.hat','users.helmet','users.torso','users.shoulder','users.forearm','users.leg','users.shin','users.foot','users.prop'];
	for (var i=0; i<NUM_BPARTS; i++)
	{
		for (var j=0; j<parts.length; j++)
			columns.push(parts[j]+i);
	}


	//create package for this player to receive all his stats
	var pkgDude = new composer.createPkg();

	//construct the query
	var statement = "SELECT ";
	for (var i=0; i<columns.length; i++)
	{
		var param = columns[i];
		statement += param;
		if (i<columns.length-1)
			statement += ", ";
	}
	statement += " FROM users join stats on users.username=stats.username where users.username="+conn.escape(theDude.pName);

		//log.log(SQL,statement);

		//perform the query, obtain results, and send off to the local player
		conn.query(statement, function(err,rows) {

			//log any errors
			if (err)
				log.log(SQL,err);

			//log.log(SQL,"%j",rows[0]);

			//construct all the object updates and add to package
			for (var j=0; j<columns.length; j++)
			{
				var param = columns[j].substring(columns[j].indexOf('.')+1,columns[j].length);
				var result = rows[0][param];

				if (param=="rank")
				{
					//get him his starting global rank
					recomputeGlobalRank(theDude.pName,socket,result);
				}

				//log.log(SQL,"rows[0]["+param+"] = "+result);

				var message = {
				name: "objUpdate",
				oid_string: objIndex.toString()+":"+uniqueId.toString(),
				object_index: objIndex,
				uniqueId: uniqueId,
				netvar: param,
				val: result,
				flag: 0
				};
				log.log(SQL,message);
				pkgDude.messages.push(message);
			}
			
			//send package
			//log.log(SQL,pkgDude);
			socket.emit('pkg', pkgDude.messages);

		});
}
exports.sendNetManPlayerStats = sendNetManPlayerStats

var sendCompletePlayerStats = function(socket, gameRoom, objIndex, broadcast_only)
{
	var theDude = socket.myPlayer;
	var username = socket.myPlayer.pName;

	var stat_table = "stats"
	if (gameRoom.indexOf("bot")>-1)
		stat_table = "bot_stats"


	var columns = ['stats.rank','stats.xp','stats.global_rank',stat_table+'.points',stat_table+'.wins',stat_table+'.losses',stat_table+'.kills',stat_table+'.deaths',stat_table+'.assists',stat_table+'.kill_streak',stat_table+'.win_streak',stat_table+'.rollover_kstreak',stat_table+'.rollover_wstreak'];

	var parts = ['users.hat','users.helmet','users.torso','users.shoulder','users.forearm','users.leg','users.shin','users.foot','users.prop'];

	for (var i=0; i<NUM_BPARTS; i++)
	{
		for (var j=0; j<parts.length; j++)
			columns.push(parts[j]+i);
	}

	//construct the query
	var statement = "SELECT ";

	for (var i=0; i<columns.length; i++)
	{
		var param = columns[i];
		statement += param;
		if (i<columns.length - 1)
			statement += ", ";
	}

	statement += " FROM users join stats on users.username=stats.username join bot_stats on users.username=bot_stats.username where users.username="+conn.escape(theDude.pName);

	log.log(SQL,"complete query: "+statement);

	conn.query(statement, function(err,rows) {
		//create package for this player to receive all his stats
		var pkgDude = new composer.createPkg();

		//log any errors
		if (err)
			log.log(SQL,err);

		//construct all the object updates and add to package
		for (var j=0; j<columns.length; j++)
		{
			var param = columns[j].substring(columns[j].indexOf('.')+1,columns[j].length);
			var result = rows[0][param];

			var message = {
				name: "objUpdate",
				oid_string: objIndex.toString()+":"+theDude.uniqueId.toString(),
				object_index: objIndex,
				uniqueId: theDude.uniqueId,
				netvar: param,
				val: result,
				flag: 0
			};

			//only send to the one dude
			pkgDude.messages.push(message);

		}

		//SEND THE PACKAGE 
		if (broadcast_only)
			socket.broadcast.to(gameRoom).emit('pkg',pkgDude.messages);
		else
			io.to(gameRoom).emit('pkg',pkgDude.messages);
	});	

}
exports.sendCompletePlayerStats = sendCompletePlayerStats