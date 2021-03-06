//game hash
global.version_hash = "V0.0"

//general flags
global.FL_NORMAL = 0;
global.FL_DECREMENT = 1;
global.FL_INSTANCE_DESTROY = 2;
global.FL_SQL = 9;
global.FL_BOT = 51;
global.FL_BOT2 = 52;
global.FL_BOT3 = 53;
global.FL_BOT4 = 54;
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
global.anon_user = "John Doe";

global.page_length = 50;

//stuff needed for multithreading
global.MULTITHREAD = true;
global.workers = [];
global.rooms = [];

//log flagsl
global.SQL = "sql"
global.CUPID = "cupid"
global.STD = "std"
global.CRITICAL = "err"
global.SOCKETS = "sock"
global.WARN = "warn"
global.socket_string = ""


global.maps = []//[14,9,11,15]//[4,5,8,3,19];
global.num_maps = 21; //21

global.gamePort = 8080;
global.fps = 30
global.num_game_rooms = 8;
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

global.cluster = null;

global.clients = [];
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