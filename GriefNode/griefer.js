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
var SOCKETS = "sock"; var gravatarObjIndex = global.gravatarObjIndex; var WARN = global.WARN;

var conn;
var MULTITHREAD = global.MULTITHREAD;

//WIPE DB AS DESIRED
var users_2kill = [];
//users_2kill.push("Kyle");
//users_2kill.push(FL_WIPE);
users_2kill.push(global.FL_EMPTY_USERS);

var random_users_2create = 2;

//---- LOAD MODULES ----//
global.cluster = require('cluster');
global.cluster.schedulingPolicy = global.cluster.SCHED_RR;

var cluster = global.cluster;
var os = require('os');
var http = require('http');
var redis = require("socket.io-redis");
var sio = require('socket.io');
var mysql = require('mysql');
var fs = require('fs');
var util = require('util');
var log = require('./lib/logger.js');
var composer = require('./lib/composer.js');
var dbman = require('./lib/dbman.js');
var cupid = require('./lib/cupid.js');
var io;

//
// MASTER CODE
//

if (cluster.isMaster) 
{

  cupid.syncVersionHash();

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

  var server = http.createServer();
  io = sio.listen(server);
  io.adapter(redis({ host: 'localhost', port: 6379 }));

  //initialize logging
  log.init();

  //distribute access to the io instance
  dbman.setIo(io);
  cupid.setIo(io);

  if (MULTITHREAD)
  {
    for (var i = 0; i < os.cpus().length; i++) 
    {
      workers[i] = cluster.fork();
      var worker = workers[i];

      //
      //HANDLE MESSAGES FROM WORKERS
      //

      worker.on('message', function(m) {

        if (m.id == "ping_master") {
          console.log(m.id+" : "+worker.id);
        }

        else if (m.id == "player_join_room") {

          if (m.groupNameTo == "main_menu" && m.groupNameFrom != "") {
            var fsocket = cupid.ds_find_fsocket(m.fsocket.name,m.groupNameFrom);
            if (fsocket) {
              fsocket.myPlayer.uniqueMatchId = -51;
            } else {
              log.log(CRITICAL,"unable to set fsocket.myPlayer.uniqueMatchId to -51: couldn't find fsocket");
            }
          }

          if (m.groupNameFrom == "" && m.groupNameTo == "main_menu") {
            console.log("NEW FSOCKET: "+m.fsocket.name);
            //initialize to main menu
            var main_menu = cupid.ds_find_room("main_menu");
            if (main_menu) {
              main_menu.fsockets.push(m.fsocket);
            } else {
              log.log(CRITICAL,"Unable to locate ds_room main_menu");
            }
          }
          else {
            log.log(CUPID,"ds_migrating player "+m.fsocket.name+" from "+m.groupNameFrom+" to "+m.groupNameTo);
            cupid.ds_migrate_player(m.fsocket.name, m.groupNameFrom, m.groupNameTo);
          }
        }

        else if (m.id == "player_destroy") {
          if (m.fsocket.name == global.anon_user)
            return false;
          var destroyed = false;
          log.log(CUPID, "received player_destroy for: "+m.fsocket.name);
          cupid.ds_destroy_fsocket(m.fsocket.name);
        }

        else if (m.id == "rank_players") {
          dbman.rankPlayers();
        }

        else if (m.id == "configure_match") {
          var playerSubGroup = cupid.socketsInRoom(m.gameRoom);
          cupid.configure_match(playerSubGroup, m.gameRoom, lobby_wait_time);
        }

        else if (m.id == "shuffle_pnums") {
          var pname = m.fsocket.name;
          var fsocket = cupid.ds_find_fsocket(pname);
          if (fsocket) {
            cupid.shuffle_pnums(fsocket);
          } else {
            log.log(CRITICAL,"Cannot shuffle_pnums ... unable to locate fsocket for "+pname);
          }
        }

        else if (m.id == "sync_players_connected") {
          cupid.manageSockets();
          cupid.syncPlayersConnected();
        }

        else if (m.id == "everyone_ready") {
          var fsocket = cupid.ds_find_fsocket(m.fsocket.name);
          if (fsocket) {
            cupid.get_everyone_ready(fsocket);
          } else {
            log.log(CRITICAL,"Cannot get everyone ready ... unable to locate fsocket for "+m.fsocket.name);
          }
        }

        else if (m.id == "next_map_vote") {
          var fsocket = cupid.ds_find_fsocket(m.fsocket.name, m.fsocket.myPlayer.room);
          if (fsocket) {
            fsocket.myPlayer.nextMapVote = m.fsocket.myPlayer.nextMapVote;
          }
        }


        else {
          log.log(CRITICAL,"Unknown message from worker to master: "+m.id);
        }

      });

    }
  }
  else
  {
    server.listen(global.gamePort, function(err) {
      if (err) {
        console.log(err);
      } else {
        console.log('MASTER is listening on: *'+global.gamePort);
      }
    });
  }

  cluster.on('exit', function(worker, code, signal) {
    console.log('worker ' + worker.id+ ' died [pid '+worker.process.pid + ']');
  });

  //initialize all of the socket rooms
  cupid.initGameRooms();

  //perform intervalic tasks
  setInterval(dbman.rankPlayers,60000);
  setInterval(cupid.manageSockets,5000);
  setInterval(cupid.syncPlayersConnected,4*5010);
  setInterval(cupid.makeMatches,5000);
  setInterval(cupid.syncVersionHash,30000);

}

//
// WORKER CODE
//

if (cluster.isWorker)
{
  //establish a Connection to the griefer users database
  dbman.connect(conn, function() {
  });

  var ping_master = false;
  if (ping_master) {
    setInterval(function(){
      var msg = {id: "ping_master", msg: "s my d bitch"};
      process.send(msg);
    },1000);
  }

  setInterval(cupid.manageSockets,1000);

  var app = require("express")();
  var server = http.createServer(app);
  io = sio.listen(server);
  io.adapter(redis({ host: 'localhost', port: 6379 }));

  //initialize logging
  log.init();

  //distribute access to the io instance
  dbman.setIo(io);
  cupid.setIo(io);

  //initialize all of the socket rooms
  cupid.initGameRooms();

  server.listen(global.gamePort, function(err) {
    if (err) {
      console.log(err);
    } else {
      console.log('worker '+cluster.worker.id+' is listening on: *'+global.gamePort);
    }
  });

  //
  // HANDLE MESSAGES FROM MASTER
  //
  process.on('message', function(m) {

    log.log("verbose",m.id+" : "+cluster.worker.id);

    if (m.id == "fsocket_emit") {
      for (var i=0; i<io.sockets.sockets.length; i++) {
        var socket = io.sockets.sockets[i];
        if (socket.myPlayer.pName == m.toPlayer) {
          console.log("fsocket_emit: "+m.str_header+" resolved to worker "+cluster.worker.id+"'s socket for "+socket.myPlayer.pName);
          socket.emit(m.str_header,m.obj_body);
        }
      }
    }

    else if (m.id == "player_join_room") {
      for (var i=0; i<io.sockets.sockets.length; i++) {
        var socket = io.sockets.sockets[i];
        if (socket.myPlayer.pName == m.pName) {
          if (m.groupNameFrom != "") {
            socket.leave(m.groupNameFrom);
          }
          socket.join(m.groupNameTo);
          socket.myPlayer.room = m.groupNameTo;
        }
      }
    }

    else if (m.id == "sync_version_hash") {
      log.log("verbose"," synced version hash: "+m.version_hash);
      global.version_hash = m.version_hash;
    }

    else if (m.id == "reread_tskill") {
      for (var i=0; i<io.sockets.sockets.length; i++) {
        var socket = io.sockets.sockets[i];

        if (socket.myPlayer.pName == global.anon_user)
            continue;

        log.log(socket.myPlayer.pName+" rereading_tskill");
        dbman.reread_tskill(socket);
      }
    }

    else {
      log.log(CRITICAL,"Unknown message from Master to Worker "+cluster.worker.id+": "+m.id);
    }

  });

}

if (cluster.isWorker || !MULTITHREAD)
{

  var special_ping = false;
  if (special_ping) {
    setInterval(function(){
          console.log("worker "+cluster.worker.id+" sending special_ping to everyone");
          io.emit('general_message',composer.genMessage("special_ping",""+cluster.worker.id+" says HI"));
    },5000);
  }

  //---- PRIMARY SERVER LOGIC ----//
  io.on('connection', function(socket){

    //initialize a web-socket Connection to the client
    if (cluster.isWorker) {
      console.log("WORKER "+cluster.worker.id+": Player Connected");
    }

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
      socket.myPlayer.room = "";

      //join the main_menu group --> aka no matchmaking currently happening
      cupid.worker_join_room(socket,"main_menu");
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

        dbman.performEvents(socket,"",true);

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
      cupid.worker_join_room(socket,socket.myPlayer.gameMode+"_lobby");
    });

    socket.on('player_join_room',function(pName,groupName) {
      log.log(CRITICAL,"Why on Earth is the deprecated player_join_room message being sent around?");
      /*
      if (socket.myPlayer.pName == pName) {
        socket.myPlayer.room = groupName;
        socket.join(groupName);
      }*/
    });

    //---- CANCEL MATCHMAKING ----//
    socket.on('cancel_matchmaking',function(arg1) {
        if (socket.myPlayer.pName == global.anon_user)
          return false;

        socket.broadcast.to(socket.myPlayer.room).emit('player_left_matchmaking', socket.myPlayer);
        log.log(STD,socket.myPlayer.pName+" Leaving Matchmaking")
        socket.myPlayer.uniqueMatchId = -51;
        cupid.worker_join_room(socket,"main_menu");
    });

    //---- A PLAYER DISCONNECTS FROM THE SERVER ----//
    socket.on('disconnect', function() {
        global.clients.splice(global.clients.indexOf(socket),1);

        if (socket.myPlayer.pName == global.anon_user)
            return false;

        if (cluster.isWorker) {
          console.log("WORKER "+cluster.worker.id+": "+socket.myPlayer.pName+" Disconnected");
          process.send({id:"player_destroy",fsocket:composer.fsocket(socket)});
        }

        log.log(STD,socket.myPlayer.pName+": disconnected");
        socket.broadcast.to(socket.myPlayer.room).emit('disconnected_player_from_server', socket.myPlayer);
        socket.myPlayer.uniqueMatchId = -51;

        log.log(STD,"deleting "+socket.myPlayer.pName+"'s socket");
        socket.myPlayer.room = "main_menu";
        socket.join('main_menu');
        socket.myPlayer.pName = global.anon_user;
        //socket.disconnect('unauthorized');
        //delete socket;

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
          var statement = "UPDATE controls set control_code="+message.val2+" WHERE username='"+socket.myPlayer.pName+"' AND control_index="+message.val1+" AND using_gamepad="+message.val3;
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
          setTimeout(function() {
            if (cluster.isWorker) {
              cupid.message_master({id:"rank_players"});
            }
            else {
              dbman.rankPlayers()
            }
          },5000);

        //configure the next match after a short delay
        setTimeout(function(playerSubGroup, gameRoom) {
          if (cluster.isWorker) {
            cupid.message_master({id:"configure_match",gameRoom:gameRoom});
          } else {
            cupid.configure_match(playerSubGroup, gameRoom, lobby_wait_time);
          }
        },2000,cupid.socketsInRoom(socket.myPlayer.room),socket.myPlayer.room);

      }

      else if (message.msg == "validate_hash")
      {
        var valid = 1;
        log.log("verbose","comparing "+message.val+" to "+global.version_hash);
        
        if (message.val != global.version_hash)
            valid = 0;

        log.log("verbose","hash valid? --> "+valid);

        var response = composer.genMessage("validate_hash",global.version_hash);
        socket.emit('general_message',response);
      }

      else if (message.msg == "ping")
      {
        var response = {
            name: "generalMessage",
            msg: "ack",
            val: message.val
        };
        socket.emit('ping',response);
        console.log("ping");
        //log.log(STD,"\nPING\n");
      }

      else if (message.msg == "change_password")
      {
        log.log(STD,"changing password for "+socket.myPlayer.pName+" to "+message.val);
        var statement = "UPDATE users set password=MD5('"+message.val+"') where username='"+socket.myPlayer.pName+"'";
        log.log(SQL,statement);
        dbman.execute(statement);
        cupid.genMessage(socket,"done_loading",FL_NORMAL);
      }

      else if (message.msg == "shuffle_pnums")
      {
        if (cluster.isWorker) {
          cupid.message_master({id: "shuffle_pnums", fsocket: composer.fsocket(socket)});
        } else {
          cupid.shuffle_pnums(socket);
        }
      } 

      else if (message.msg == "perma_challenge")
      {
        log.log(STD,"adding perma challenge: "+message.val);
        dbman.addPermaChallenge(socket,message.val);
      }

      else if (message.msg == "syncPlayersConnected")
      {
        if (cluster.isWorker) {
          cupid.message_master({id: "sync_players_connected"});
        } else {
          cupid.manageSockets();
          cupid.syncPlayersConnected();
        }
      }

      else if (message.msg == "everyone_ready") {
        //initiate match start countdown
        if (cluster.isWorker) {
          cupid.message_master({id: "everyone_ready",fsocket: composer.fsocket(socket)});
        } else {
          cupid.get_everyone_ready(socket);
        }
      }

      else if (message.msg == "get_top_gravatars")
      {
        log.log(STD, socket.myPlayer.pName+" asked for get_top_gravatars");
        dbman.getTopGravatars(socket);
      }

     else 
     {
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
              cupid.genMessage(socket,"done_loading",2);
            } else
            {
              log.log(STD,"login failure: "+datMessage.username);
              message.val = FL_MULTIPLE;
              socket.emit('general_message',message);
              cupid.genMessage(socket,"done_loading",2);
            }
          });

        } else if (result==0)
        {
          log.log(STD,"INCORRECT password");
          socket.emit('general_message',message);
          cupid.genMessage(socket,"done_loading",2);
        } else if (result==2)
        {
          //user did not exist --> try to create?
          log.log(STD, "sending 2 as authentication result (can create user)");
          message.val = 2;
          socket.emit('general_message',message);
          cupid.genMessage(socket,"done_loading",2);
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
      if (term=="hats_Fd" || term=="compute_global_rank") {
        log.log(CRITICAL,"Why on Earth is the "+term+" message being passed around?! Ever?!");
        return true;
      }

      //keep track of which map you voted for
      if (term == "nextMapVote")
      {
        socket.myPlayer.nextMapVote = datMessage.val;

        if (cluster.isWorker) {
          var rname = "";
          for (var i=0; i<socket.rooms.length; i++) {
            for (var j=0; j<global.rooms.length; j++) {
              if (socket.rooms[i] == global.rooms[j].groupName)
              {
                rname = socket.rooms[i];
                break;
              }
              if (rname != "")
                break
            }
          }
          if (rname != "") {
            socket.myPlayer.room = rname;
          } else {
            log.log(CRITICAL,socket.myPlayer.pName+"'s socket does not seem to be in a room... what gives?");
            console.log(socket.rooms);
          }
          cupid.message_master({id:"next_map_vote",fsocket:composer.fsocket(socket)})
        }
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
  
}
