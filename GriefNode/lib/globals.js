//game hash
global.version_hash = "V119"

//general flags
global.FL_NORMAL = 0;
global.FL_DECREMENT = 1;
global.FL_INSTANCE_DESTROY = 2;
global.FL_SQL = 9;
global.FL_BOT = 15;
global.FL_MULTIPLE = 3;
global.FL_COMPETITIVE = 22;
global.FL_WIPE = "DeleteEveryDamnNoGoodUngratefulPlayer"
global.FL_INCREMENT = 8;
global.FL_FIRST = -30;
global.FL_LAST = -31;
global.FL_NEXT = -32;
global.FL_PREVIOUS = -33;
global.FL_FINDME = -34;
global.FL_EMPTY_USERS = "UsersWithNoKills";

global.page_length = 50;

//log flags
global.SQL = "sql"
global.CUPID = "cupid"
global.STD = "std"
global.CRITICAL = "err"
global.SOCKETS = "sock"

//globals
global.gamePort = 8080;
global.fps = 30
global.num_game_rooms = 8;
global.num_maps = 21; //21
global.gravatarObjIndex = 3;
global.avatarObjIndex = 2;
global.playerObjIndex = 1;
global.netManObjIndex = 0;
global.lobby_wait_time = 120000 //in miliseconds
global.starting_match_time = 10000 //in miliseconds
global.default_avatar_uniqueId = "-52"
global.default_netman_uniqueId = "-1"
global.numTdm = 0;
global.numFfa = 0;
global.numVersus = 0;
global.numMenu = 0;
global.numBot = 0;
global.numSockets = 0;
global.numBotFfa = 0;
global.numBotTdm = 0;

global.NUM_BPARTS = 25
global.NUM_STATS = 13

global.clients = [];
global.rooms = [];
global.conn_ready = false;

global.calcColumns = ["kdr", "wl", "ppl"];
global.calcColumnsTimeout = null;

var exists = function(maybeObj)
{
	if (typeof maybeObj != "undefined") 
	{
  		return true
	} 
	else return false
}
exports.exists = exists;