/// @description initialize
init_constants()
room_speed = 60
hash = "V0"
official_server_hash = "V0"

keepalive_timeout = room_speed*2
keepalive_timer = 15
keepalive_missed = 0
keepalive_missable = 3
disconnect_on_game_end = true
reconnect_timer = 0

download_percent = 0

life = 0

gameStateIni = "GameState.ini"
launcherStateIni = "LauncherState.ini"

//config file
ini_open(launcherStateIni)
	if not ini_section_exists("Main") {
	    ini_write_string("Main","Version",hash)
	    printf("::: defaulting Version to "+string(hash))
	}
	hash = ini_read_string("Main","Version","V0")
ini_close()

ini_open(gameStateIni)
	if ini_key_exists("Main","GameRunning") {
	    ini_key_delete("Main","GameRunning")
	    printf("::: game had been left running(?) deleting the GameRunning ini key")
	}
ini_close()

netvars = ds_map_create()

//networking data
receptions = 0
packets_received = 0
server_found = true

//login screen
title_scale = 1
title_scale_max = 1.25
title_scale_min = 1
title_text_timer = 0

primaryServerURL = "http://www.kylenolan.net"
alternateServerURL = "http://10.0.0.8"
port= ":8080"
serverURL = alternateServerURL
ini_open(launcherStateIni)
	cachedURL = ini_read_string("Main","ServerURL","null")
	printf("::: read cached SeverURL as "+cachedURL)
	if cachedURL != "null" {
		serverURL = cachedURL
		printf("::: using cached ServerURL: "+serverURL)
	}
	hash = ini_read_string("Main","Version","V0")
ini_close()

remoteDownloadURL = serverURL+"/Shared/Griefer.exe"
downloadURL = working_directory+"Downloads\\Griefer.exe"
//downloadURL = string_replace_all(downloadURL,"\\","/")
file = NO_HANDLE

display_set_gui_size(room_width,room_height)

random_seed = 210
instance_create(x,y,cursor)

alarm[0] = 1
alarm[1] = 60

initGrieferClient(serverURL+port)
printf("::: invoked initGrieferClient")


