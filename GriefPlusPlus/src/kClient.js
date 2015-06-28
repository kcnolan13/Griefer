    var socket;
    var myPlayer;
    var pingHandle;
    var playerNameNumbers;

    require('./socket.io');

    //---- STARTUP ----//
    console.log("kClient starting up...");


    function object_updates() {
        this.indices = [];
        this.uniqueIds = [];
        this.netvars = [];
        this.vals = [];
        this.flags = [];
    }

    function object_creates() {
        this.indices = [];
        this.uniqueIds = [];
        this.myXs = [];
        this.myYs = [];
    }

    function create_pkg() {
        this.messages = [];
    }

    var objUpdates = new object_updates();
    var objCreates = new object_creates();

    var generalMessages = [];
    var generalValues = [];

    var pkg = null;

    //---- RECEIVE STUFF ON THE GM SIDE ---> mostly FIFO ----//

    printf = function(str)
    {
        console.log(str);
    }

    isString = function(type)
    {
        var checkDis;
        if (type == "genMessage")
            checkDis = generalValues[0];
        else if (type == "objUpdate")
            checkDis = objUpdates.vals[0];

        if (typeof checkDis == "string")
            return 1;
        else return 0;
    }

    genMessagesWaiting = function()
    {
        if (generalMessages.length < 1)
            return 0;
        else return 1;
    }

    readGenMessage = function()
    {
        if (generalMessages.length < 1)
            return 0;
        else
            return generalMessages.shift();
    }

    readGenVal = function()
    {
        if (generalValues.length < 1)
            return 0;
        else
            return generalValues.shift();
    }

    objUpdatesWaiting = function()
    {
        if (objUpdates.indices.length < 1)
            return 0;
        else return 1;
    }

    readObjUpdateIndex = function()
    {
        if (objUpdates.indices.length < 1)
            return 0;
        else
            return objUpdates.indices.shift();
    }

    readObjUpdateUniqueId = function()
    {
        if (objUpdates.uniqueIds.length < 1)
            return 0;
        else
            return objUpdates.uniqueIds.shift();
    }

    readObjUpdateNetvar = function()
    {
        if (objUpdates.netvars.length < 1)
            return 0;
        else
            return objUpdates.netvars.shift();
    }

    readObjUpdateVal = function()
    {
        if (objUpdates.vals.length < 1)
            return 0;
        else return objUpdates.vals.shift();
    }

    readObjUpdateFlag = function()
    {
        if (objUpdates.flags.length < 1) {
            return -999;
        }
        else {
            //console.log(objUpdates.flags[0]);
            return objUpdates.flags.shift();
        }
    }

    objCreatesWaiting = function()
    {
        if (objCreates.indices.length < 1)
            return 0;
        else return 1;
    }

    readObjCreateIndex = function()
    {
        if (objCreates.indices.length < 1)
            return 0;
        else
            return objCreates.indices.shift();
    }

    readObjCreateUniqueId = function()
    {
        if (objCreates.uniqueIds.length < 1)
            return 0;
        else
            return objCreates.uniqueIds.shift();
    }

    readObjCreateMyX = function()
    {
        if (objCreates.myXs.length < 1)
            return 0;
        else return objCreates.myXs.shift();
    }

    readObjCreateMyY = function()
    {
        if (objCreates.myYs.length < 1)
            return 0;
        else return objCreates.myYs.shift();
    }



    //---- API HEAVY HITTERS ----//

    objUpdate = function(object_index, uniqueId, netVar, value, flag)
    {
        var message = {
            name: "objUpdate",
            object_index: object_index,
            uniqueId: uniqueId,
            netvar: netVar,
            val: value,
            flag: flag
        };

        if (pkg==null)
        {
            socket.emit('obj_update',message);
        } else
        {
            pkg.messages.push(message);
        }
    }

    statUpdate = function(stat, value, flag)
    {
        var message = {
            name: "statUpdate",
            netvar: stat,
            val: value,
            flag: flag
        };

        socket.emit('stat_update',message);
    }

    otherPlayerStatUpdate = function(player_name, stat, value, flag)
    {
        var message = {
            name: "otherPlayerStatUpdate",
            pname: player_name,
            netvar: stat,
            val: value,
            flag: flag
        };

        socket.emit('other_player_stat_update',message);
    }

    sendGenMessage = function(message_string, value)
    {
        var message = {
            name: "generalMessage",
            msg: message_string,
            val: value
        };

        if (pkg==null)
        {
            socket.emit('general_message',message);
        } else
        {
            pkg.messages.push(message);
        }
    }

    objPushBack = function(object_index, uniqueId, netVar, value, flag)
    {
        var message = {
            name: "objUpdate",
            object_index: object_index,
            uniqueId: uniqueId,
            netvar: netVar,
            val: value,
            flag: flag
        };

        processObjUpdate(message);
    }

    objCreate = function(object_index, uniqueId, x, y)
    {
        var message = {
            name: "objCreate",
            object_index: object_index,
            uniqueId: uniqueId,
            myX: x,
            myY: y
        };

        if (pkg==null)
        {
            socket.emit('obj_create',message);
        } else
        {
            pkg.messages.push(message);
        }
    }

    pkgCreate = function() {
        pkg = new create_pkg();
    }

    pkgSend = function() {
        socket.emit('pkg',pkg);
        pkg = null;
    }

    processObjUpdate = function(message) {
        objUpdates.indices.push(message.object_index);
        objUpdates.uniqueIds.push(message.uniqueId);
        objUpdates.netvars.push(message.netvar);
        objUpdates.vals.push(message.val);
        objUpdates.flags.push(message.flag);
    }

    processObjCreate = function(message) {
        objCreates.indices.push(message.object_index);
        objCreates.uniqueIds.push(message.uniqueId);
        objCreates.myXs.push(message.myX);
        objCreates.myYs.push(message.myY);
    }

    processGeneralMessage = function(message) {
        console.log(message.msg+": "+message.val);
        generalMessages.push(message.msg);
        generalValues.push(message.val);
    }


    //---- PRIMARY CONNECTION LOGIC ----//
    startMatchMaking = function(gameMode) {
        console.log("joining "+gameMode+" lobby");
        socket.emit('start_matchmaking',gameMode);
        return 0;
    }

    leaveMatchMaking = function() {
        console.log("leaving matchmaking");
        socket.emit('cancel_matchmaking');
        clearInterval(pingHandle);
    }

    //---- INITIALIZE A CONNECTION TO THE SERVER ----//
    setTimeout(connectToServer,500);

    function connectToServer()
    {
        socket = io('puddlesquid.com:8080');

        socket.io.on('connect_error', function(err) {
            console.log("LOST CONNECTION from the server");
            generalMessages.push("disconnect");
            generalValues.push(true);
            setTimeout(connectToServer,500);
        });

        socket.on('cancel_matchmaking', function(arg1) {
            leaveMatchMaking();
        });

        socket.on('heres_your_player_info', function(player) {
            myPlayer = player;
            console.log('This is me: '+printPlayer(myPlayer));
        });

        socket.on('you_joined_match', function(player) {
            myPlayer = player;
            console.log('JOINED MATCH! '+myPlayer.room);
        });

        socket.on("new_player_in_group", function(player) {
            console.log(printPlayer(player)+" --> joined the "+player.room+" group");
        });

        socket.on("player_left_matchmaking", function(player) {
            console.log("player left matchmaking: "+player.pName);
            //convey this to game maker
            generalMessages.push("player_quit");
            generalValues.push(player.pName);

        });

        socket.on("player_left_room", function(player) {
            console.log("player left your room: "+player.pName);
        });

        socket.on("disconnected_player_from_server", function(player) {
            console.log("player EVAPORATED into thin air (quit Griefer): "+player.pName);

            //convey this to game maker
            generalMessages.push("player_quit");
            generalValues.push(player.pName);

        });

        socket.on('disconnect', function() {
            console.log("LOST CONNECTION from the server");
            generalMessages.push("disconnect");
            generalValues.push(true);
        });

        socket.on('obj_update', function(datMessage) {
            processObjUpdate(datMessage);
        });

        socket.on('obj_create', function(datMessage) {
            processObjCreate(datMessage);
        });

        socket.on('general_message', function(datMessage) {
            processGeneralMessage(datMessage);
        });

        socket.on('pkg', function(pkg) {
            for (var i=0; i<pkg.messages.length; i++)
            {
                if (pkg.messages[i].name=="generalMessage")
                    processGeneralMessage(pkg.messages[i]);
                else if (pkg.messages[i].name=="objUpdate")
                    processObjUpdate(pkg.messages[i]);
                else if (pkg.messages[i].name=="objCreate")
                    processObjCreate(pkg.messages[i]);
            }
            //console.log("PACKAGE LENGTH: "+String(i+1));
        });

    }


    //---- BASICS ----//
    printPlayer = function(thePlayer) {
        return (thePlayer.pName+": "+thePlayer.gameMode+", "+thePlayer.room);
    }

    authenticate = function(username, password)
    {

        var message = {
            username: username,
            password: password
        };

        socket.emit('authenticate',message);
    }

    createUser = function(username, password)
    {
        var message = {
            username: username,
            password: password
        };

        socket.emit('create_user',message);
    }

    logIn = function(username)
    {
        socket.emit('login_player',username);
    }

    logOut = function()
    {
        socket.emit('disconnect');
        socket.disconnect();
    }