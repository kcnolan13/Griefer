/// @description initialize
num_accolades = 28
spawned_grid = false

chev_left = NO_HANDLE
chev_right = NO_HANDLE

x = -100
y = -100

netvars = ds_map_create()

computed_match_end_accs = false
match_end_accs = false

acc_popup_id = noone

//in match offsets
match_xoff = 64*1.15
match_yoff = 64*2.75
acc_width = sprite_get_width(acc_dub_kill)/2+24
match_hsep = 24
stats_hsep = 0
grid_hsep = match_hsep
grid_vsep = grid_hsep
bg = NO_HANDLE

force_accolade_sound = false

//stat mode scrolling variables
grid_left = room_width/2-64*3.5+38
grid_right = room_width-64*2.5
grid_ymid = room_height/2+64*4.5-6
grid_xmid = average2(grid_left,grid_right)
grid_width = abs(grid_right-grid_left)
accolade_xmin = grid_left
accolade_xmax = grid_right

acc_match_scale = 1.5

sradius = 64
sindex = 0
sindex_min = 0
sindex_max = 0
sspeed = 4

//accolade grid ---> | name | text | description | image | points | match_total | competitive_total | bot_mode_total | needed | challenge_needed | challenge_stat_flag | sound
grid = ds_grid_create(12,num_accolades+91-65+1)

var row_num = 0
init_grid_row("dub_kill","Double Kill","2 Kills Back-to-Back",acc_dub_kill,                     50,2,99,FL_NORMAL,snd_dub_kill,row_num) row_num++
init_grid_row("trip_kill","Triple Kill","3 Kills Back-to-Back",acc_trip_kill,                   100,3,99,FL_NORMAL,snd_trip_kill,row_num) row_num++
init_grid_row("stick_kill","Stick Kill","Sticky Kill",acc_stick_kill,                           12.5,1,99,FL_NORMAL,snd_stick_kill,row_num) row_num++
init_grid_row("flash_bandicoot","Flash Bandicoot","5 Stuns In One Match",acc_flash_bandicoot,   68,5,99,FL_NORMAL,snd_flash_bandicoot,row_num) row_num++
init_grid_row("flame_kill","Incinerator","Flame Grenade Kill",acc_flame_kill,                   12.5,1,99,FL_NORMAL,snd_flame_kill,row_num) row_num++
init_grid_row("ink_kill","Poison Kill","Poison Grenade Kill",acc_ink_kill,                      12.5,1,99,FL_NORMAL,snd_ink_kill,row_num) row_num++
init_grid_row("cant_touch_dis","Can't Touch Dis","3 Kills Taking No Damage",acc_cant_touch_dis, 225,3,99,FL_NORMAL,snd_cant_touch_dis,row_num) row_num++
init_grid_row("mvp","MVP","Most Points in Match",acc_mvp,                                       85,0,99,FL_NORMAL,snd_mvp,row_num) row_num++
init_grid_row("highest_kd","Highest KDR","Highest Kill/Death Ratio in Match",acc_highest_kd,    60,0,99,FL_NORMAL,snd_highest_kdr,row_num) row_num++
init_grid_row("10kd","Achilles","10+ Kills, No Deaths",acc_10kd,                                249,10,99,FL_NORMAL,snd_10kd,row_num) row_num++
init_grid_row("ninja","Ninja","Survive for 60 Seconds Without Taking Damage",acc_ninja,         70,60,5,FL_NORMAL,snd_ninja,row_num) row_num++
init_grid_row("survivor","Survivor","Survive a Near-Death-Experience",acc_survivor,             25,0,99,FL_NORMAL,snd_survivor,row_num) row_num++
init_grid_row("3ass","Combat Support","3 Assists Without Dying",acc_3ass,                       50,3,99,FL_NORMAL,snd_3ass,row_num) row_num++
init_grid_row("5ass","Professional Assistant","5 Assists Without Dying",acc_5ass,               100,5,99,FL_NORMAL,snd_5ass,row_num) row_num++
init_grid_row("3gibs","Eviscerator","3 Dismemberments Without Dying",acc_3gibs,                 50,3,99,FL_NORMAL,snd_3gibs,row_num) row_num++
init_grid_row("6gibs","Jack the Ripper","6 Dismemberments Without Dying",acc_6gibs,             150,6,99,FL_NORMAL,snd_6gibs,row_num) row_num++
init_grid_row("9gibs","Cruel and Unusual","9 Dismemberments Without Dying",acc_9gibs,           225,9,99,FL_NORMAL,snd_9gibs,row_num) row_num++
init_grid_row("12gibs","Isaac Clarke","12 Dismemberments Without Dying",acc_12gibs,             300,12,99,FL_NORMAL,snd_12gibs,row_num) row_num++
init_grid_row("3heads","Hat Trick","3 Headshots Without Dying",acc_3heads,                      74,3,99,FL_NORMAL,snd_3heads,row_num) row_num++
init_grid_row("6heads","Double Hat Trick","6 Headshots Without Dying",acc_6heads,               200,6,99,FL_NORMAL,snd_6heads,row_num) row_num++
init_grid_row("9heads","Triple Hat Trick","9 Headshots Without Dying",acc_9heads,               275,9,99,FL_NORMAL,snd_9heads,row_num) row_num++
init_grid_row("12heads","Jason Bourne","12 Headshots Without Dying",acc_12heads,                400,12,99,FL_NORMAL,snd_12heads,row_num) row_num++
init_grid_row("3ks","3 Kill Streak","3 Kills Without Dying",acc_3ks,                            50,3,99,FL_NORMAL,snd_3ks,row_num) row_num++
init_grid_row("5ks","5 Kill Streak","5 Kills Without Dying",acc_5ks,                            75,5,99,FL_NORMAL,snd_5ks,row_num) row_num++
init_grid_row("10ks","10 Kill Streak","10 Kills Without Dying",acc_10ks,                        100,10,99,FL_NORMAL,snd_10ks,row_num) row_num++
init_grid_row("15ks","15 Kill Streak","15 Kills Without Dying",acc_15ks,                        175,15,99,FL_NORMAL,snd_15ks,row_num) row_num++
init_grid_row("20ks","20 Kill Streak","20 Kills Without Dying",acc_20ks,                        250,20,99,FL_NORMAL,snd_20ks,row_num) row_num++
init_grid_row("25ks","25 Kill Streak","25 Kills Without Dying",acc_25ks,                        400,25,99,FL_NORMAL,snd_25ks,row_num) row_num++

//weapon accolades --> not to be awarded as accolades, but used for challenge progression tracking
wep_kills_needed = 1
evil_row_num = row_num
init_grid_row("spr_flame","text","descr",spr_none,0,25*wep_kills_needed,25*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_ink","text","descr",spr_none,0,25*wep_kills_needed,25*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_snare","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_smoke","text","descr",spr_none,0,10*wep_kills_needed,10*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_flashbang","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_pistol","text","descr",spr_none,0,5*wep_kills_needed,5*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_carbine","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_rifle","text","descr",spr_none,0,10*wep_kills_needed,10*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_tickler","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_smg","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_sticky","text","descr",spr_none,0,25*wep_kills_needed,25*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_lmg","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_longshot","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_vulcan","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_torque","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_thumper","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_boltok","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_shotgun","text","descr",spr_none,0,50*wep_kills_needed,50*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_stomper","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_boom","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_frag","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_rocket","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_double","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_wep1","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_wep2","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_wep3","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++
init_grid_row("spr_wep4","text","descr",spr_none,0,20*wep_kills_needed,20*wep_kills_needed,FL_COMPETITIVE,snd_promoted,row_num) row_num++

ds_grid_sort(grid,COL_POINTS,false)

