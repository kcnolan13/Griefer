/// @description initialization
show_cout = false
cout_str = ""
cout_maxchars = 2000
control_tips = noone
bot_diff_ind = -1

grieferURL = string_copy(working_directory,0,string_pos("AppData",working_directory)) + "ppData\\Local\\Griefer\\"
launcherURL = string_copy(working_directory,0,string_pos("AppData",working_directory)) + "ppData\\Local\\GrieferLauncher\\"
//launcherURL = string_replace_all(launcherURL,"\\","/")
gameStateIni = "GameState.ini"

primaryServerURL = "http://www.kylenolan.net:8080"
alternateServerURL = "http://10.0.0.8:8080"
serverURL = primaryServerURL

show_debug_stats = false
show_debug_overlay(show_debug_stats)
draw_set_swf_aa_level(1)
draw_enable_swf_aa(true)
setGppDebug(DEBUG)
display_set_gui_size(WVIEW,HVIEW)

disconnect_on_game_end = true
reconnect_timer = 0

cross_referenced_options = false

//config file
ini_open(gameStateIni)
	ini_write_real("Main","GameRunning",true)
ini_close()

printf("::: attempting to copy file from "+working_directory+gameStateIni+" to "+launcherURL+gameStateIni)

retcode = file_copy_ns(gameStateIni,launcherURL+gameStateIni)
printf("::: config transfer retcode: "+string(retcode))
    
ini_open(gameStateIni)
	game_is_running = ini_read_real("Main","GameRunning",0)
	printf("::: read GameRunning from ini as "+string(game_is_running))
    cachedURL = ini_read_string("Main","ServerURL","null")
    printf("::: read cached SeverURL as "+cachedURL)
    if cachedURL != "null" {
	    serverURL = cachedURL
	    printf("::: using cached ServerURL: "+serverURL)
    }
ini_close()

snapshot_mode = false
snapshot_number = 1
snapshot_auto = false

time_after_readies = -1

draw_you_killed_max = 75
draw_you_killed = false
name_you_killed = ""
new_user = false
drawing_grid_dir = 0

sounded_lotto_slot[0] = false
sounded_lotto_slot[1] = false
sounded_lotto_slot[2] = false

barh = 22
force_loading_popup = false

pre[0] = "Press "; mid[0] = C_MOVE_LEFT;      post[0] = " to Walk";
pre[1] = "Press "; mid[1] = C_JUMP;           post[1] = " to Jump";
pre[2] = "Press "; mid[2] = C_EVADE;          post[2] = " to Roll";
pre[3] = "Press "; mid[3] = C_NEXT;           post[3] = " to Switch Weapons";
pre[4] = "Press "; mid[4] = C_PICKUP;         post[4] = " to Pick Up Weapons";
pre[5] = "Press "; mid[5] = C_RELOAD;         post[5] = " to Reload";
pre[6] = "Press "; mid[6] = C_QUICKTOSS;      post[6] = " to Quick-Toss Grenades";
pre[7] = "Press "; mid[7] = "ESC";            post[7] = " to Open Options";
pre[8] = "Press "; mid[8] = "TAB";            post[8] = " to View Score";

next_map_final = noone
ui_countdown = noone

violence_2end = false

load_room_start = false
create_random_users = false

random_seed = 210//164
login_when_ready = false
view_adjust_delay = 0
drawing_grav_popup = false
current_time_offset = 0

real_time_init()
physics_going = true
sort_worthy = false
default_winner = ""
match_collapsed = false
collapsed_pname = ""
collapsed_numplayers = 0
collapsed_pluralize = 0
everyone_quit = false

draw_prank_centered = false

show_grid_counter_needed = 0
show_grid_counter = 0
show_grid = NO_HANDLE
drew_armory_grid = false

//voting
votes1 = 0
votes2 = 0
votes3 = 0

force_sync_countdown = 0

keepalive_timeout = room_speed*2
keepalive_timer = 15
keepalive_missed = 0
keepalive_missable = 4

master_scale = 1
match_scale = 0.9

lobby_match_countdown = false
lobby_match_countdown_time = 10*30

seed = 30

xp_before = 0
rank_before = 0
party_leader = false
in_party = false
stat_gravatar = NO_HANDLE
rag_target = NO_HANDLE
view_overscaler_target = 0
view_overscaler_dead = 0.45
draw_killed_by = false

force_recompute_scores = false

full_screen = false
global.rank_colors = 0
global.rank_names = 0

lotto_delay = 40
lotto_counter = 0

tdm_kill_limit = 20
ffa_kill_limit = 15
versus_kill_limit = 10
kill_limit = 10

ffa_player_limit = 3
tdm_player_limit = 4
versus_player_limit = 2

//dummy_vars
map_previous = "Null"
play_left = room_width*1.75/5
play_top = room_height*1/2
hide_spawn_text = false
winner = noone
bot_focus_counter = 0
bot_focus = noone
bot_override = false
drawing_cache_popup = false

for (var i=0; i<NUM_LIMBS; i++)
{
    grid_lalphs[i] = 0
}
grid_lalph_inc = 0.1


printf("instance_exists(-10) = "+string(instance_exists(-10)))

initGrieferClient(serverURL)
printf("::: invoked initGrieferClient")

//login screen
title_scale = 1
title_scale_max = 1.25
title_scale_min = 1
title_text_timer = 0

//server timeout
server_found = true

//connection testing
show_connection = false
packets_to_send = 1200
ppf_starting = 180
packets_per_frame = ppf_starting
packets_sent = 0
packets_received = 0
frames_elapsed = 0
lossless_resolution = 10
test_complete_counter = 0
intertest_delay = 30

//transmission rates
show_trans_rate = false
trans_rate = 0
transmissions = 0
trans_period = 15 //frames
trans_frames = 0
use_nth_frame = true
rec_rate = 0
receptions = 0

//nonsense vars
disabled = false
starting_match = false
armor_ysep = 10
hide_avatars = false
border = 0
dat_team_do = 0

//create all cursors
for (i=cursor_placeholder1+1; i<cursor_placeholder2; i++)
{
    ID = instance_create(0,0,i)
}

steal_mode = GEAR_CLONE
steal_verb = "Stealing"
clone_verb = "Cloning"

toggles_xoff = room_width/2
toggles_yoff = 72
toggles_vsep = sprite_get_height(spr_toggle)+10

tg_blood = instance_create(x,y,toggle_button_generic)
tg_blood.active = true
tg_blood.label = "Blood"
tg_blood.xoff = toggles_xoff
tg_blood.yoff = toggles_yoff

tg_effects = instance_create(x,y,toggle_button_generic)
tg_effects.active = true
tg_effects.label = "Effects"
tg_effects.xoff = toggles_xoff
tg_effects.yoff = toggles_yoff+toggles_vsep*1

player_limit = 4
you_win = false
your_kills = 0
team_kills = 0
winner = noone
tied_bot_match = false

audio_listener_position(0,0,0)

//create sortable player grids. to be used like --->  kills, avatar_obj
team_all = ds_grid_create(3,instance_number(avatar))
team0 = ds_grid_create(3,floor(instance_number(avatar)/2))
team1 = ds_grid_create(3,ceil(instance_number(avatar)/2))
previous_room = room
disable_scores = false

global.action_word_color = c_white
more_global_constants()

av_popup = noone
av_xbd = 36
av_ybd = 48

//META GAME
alarm[4] = 30*5
lottery_time = 5*30
lottery_calc_time = 1.5*30
steal_time = 3.5*30
steal_calc_time = 2*30
mode_total = lottery_time+steal_time
lotto_comein_offset = 15
slot_scale_deciding = 1
slot_scale_decided = 1.5
slot_scale_init = 0.5
lotto_slot_scale[0] = slot_scale_init
lotto_slot_scale[1] = slot_scale_init
lotto_slot_scale[2] = slot_scale_init
steal_slot_scale = slot_scale_init
purge_pending = false

slot_lerp_real = 0.1

computed_winloss = false

bpart_transacted = noone
bpart_lotto[0] = noone
bpart_lotto[1] = noone
bpart_lotto[2] = noone

mode_counter = 0

came_from_match = false
draw_edge_padding = 0
draw_edge_txtpad = 8
lobby_wait_time = 45*30
lock_armory = false
num_players = 1
saving_armor = 0
saving_armor_max = 2*30
saving_armor_reboot = false
show_avatar = false
local_dollsync = false
global.bg_color = c_white
lobby_dude_y = room_height*3.25/5+32+48
av_padding = room_width/6
av_scale_lobby = 2
av_scale_menu = 3
av_scale_higlighted = 3.3
av_scale_highlighted_normal = 3.3
av_scale_play = 2.6
col_new = c_white
col_stolen = make_color_rgb(255,125,125)
col_challenge = make_color_rgb(125,125,255)

txt_new = "NEW"
txt_stolen = "NEW"

menu_mode = "armory"
armor_modified = false
init_global_bparts()

dude_x = room_width/2
dude_y = room_height/2
my_doll = noone

armory_label_alpha = 0.5

avatar_winners = ds_list_create()
avatar_losers = ds_list_create()

armory_alphas[0] = 0
armory_alphas[1] = 0
armory_alphas[2] = 0
armory_alphas[3] = 0
armory_alphas[4] = 0
armory_alphas[5] = 0
armory_alphas[6] = 0
armory_alphas[7] = 0
armory_alphas[8] = 0

armory_disabled[0] = 0
armory_disabled[1] = 0
armory_disabled[2] = 0
armory_disabled[3] = 0
armory_disabled[4] = 0
armory_disabled[5] = 0
armory_disabled[6] = 0
armory_disabled[7] = 0
armory_disabled[8] = 0

armory_lists = ds_list_create()
armory_lists[| 0] = global.helmets
armory_lists[| 1] = global.torsos
armory_lists[| 2] = global.legs
armory_lists[| 3] = global.shins
armory_lists[| 4] = global.hats
armory_lists[| 5] = global.shoulders
armory_lists[| 6] = global.forearms
armory_lists[| 7] = global.feet
armory_lists[| 8] = global.props

armory_xoff = 72*3+16             //how far from dude x to slot x
armory_yoff = 2*72           //how far above dude y to start for first slot
armory_ysep = 16             //vertical sep between slots
armory_sl = 72
grid_left = 0
grid_right = 0
grid_top = 0
grid_bottom = 0

props_xoff = -armory_sl/2
props_yoff = 64*4.4

cache_center = room_width/2
cache_speed = 12
cache_y = 72+64
cache_slots = 14
cache_length = cache_slots*(armory_ysep+armory_sl)
cache_xoffset = 0
cache_mouse_tol_inside = 2*(armory_sl+armory_ysep)
cache_mouse_tol_outside = 1*(armory_sl+armory_ysep)

//give him some stuff to start with in the cache
/*for (var i=0; i<5; i++)
{
    instantiate_bpart(floor(random_range(spr_armor_placeholder1+1,spr_armor_placeholder2-0.1)),"Lottery",global.cache)
}*/
/*for (var i=spr_armor_placeholder1+1; i<spr_armor_placeholder1+10; i++)
{
    instantiate_bpart(i,"Debug",global.cache)
}*/

/*for (var i=spr_weapon_placeholder1+1; i<spr_weapon_placeholder2; i++)
{
    instantiate_bpart(i,"Debug",global.cache)
}*/

/*for (var i=0; i<3; i++)
{
    instantiate_bpart(spr_hat2,"debug",global.cache)
}*/

//END META GAME

instance_create(x,y,cursor)
instance_create(x,y,hit_indicator)
instance_create(x,y,fx)
instance_create(x,y,popup_drawer)
instance_create(x,y,accolade_manager)
instance_create(x,y,challenge_manager)
instance_create(x,y,stat_manager)
instance_create(x,y,kill_feed)
instance_create(x,y,chat_feed)


netvars = ds_map_create()
varWrite("pName","player")

varWrite("next_map",0)
varWrite("lost_gear",false)
varWrite("lost_gear_sprite",false)
varWrite("lost_gear_source","")
varWrite("transacted_player","")
varWrite("stole_gear",false)
varWrite("stole_gear_sprite",false)
varWrite("stole_gear_source","")
varWrite("winning_pName","")
varWrite("match_flag",FL_NEUTRAL)
varWrite("versus_players_online",2)
varWrite("ffa_players_online",3)
varWrite("tdm_players_online",4)
varWrite("bot_versus_players_online",5)
varWrite("players_online",14)
varWrite("everyone_quit",false)
var cdiv = 3
varWrite("versus_color",global.versus_color)
varWrite("ffa_color",global.ffa_color)
varWrite("tdm_color",global.tdm_color)
varWrite("bot_versus_color",global.versus_color)
varWrite("bot_ffa_color",global.ffa_color)
varWrite("bot_tdm_color",global.tdm_color)

bot_diff_name = "NULL"
bot_diff_level = 0


//bparts
bparts_all_init()
for (var i=0; i<NUM_BPARTS; i++)
{
    bparts_ready[i] = false
}

debug_autoplay = false

show_scores = 0

starting_match = 0
starting_match_delay = 12*30

hide_spawn_text = false

spawn_fail_message = ""



//make room updates available succinctly
varWrite("tdm_lobby","rm_tdm_lobby")
varWrite("ffa_lobby","rm_ffa_lobby")
varWrite("versus_lobby","rm_versus_lobby")
varWrite("rm_map1",rm_map2)
varWrite("game_mode","no_mode")
varWrite("uniqueId","-1")
varWrite("end_match_coming",false)
varWrite("using_teams",false)
varWrite("lobby_wait_time",45)
varWrite("cache","")

griefer_url = "http://www.kylenolan.net/";

local_player = NO_HANDLE
room_counter = 0


//stuff that should be reset when you enter a match
respawn_counter = 0
respawn_delay = 30*3
match_countdown = -99
match_countdown_max = 30*10
gear_lost = false

p1Stats = ds_map_create()
p2Stats = ds_map_create()
p3Stats = ds_map_create()
p4Stats = ds_map_create()
p5Stats = ds_map_create()
p6Stats = ds_map_create()

num_players = 1
team = -1
bot_match = false
win_countdown = 0

/* */
///create the xp bar
instance_create(x,y,xp_bar)

/* */
exit;
action_set_alarm(180, 8);
/*  */
