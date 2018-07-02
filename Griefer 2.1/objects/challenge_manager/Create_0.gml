/// @description instantiate all challenge objects
netvars = -1
challenge_showing_popup = 0
global.challenge_popup_width = 72*5.5
global.challenge_popup_height = 1.5*72+ 2*net_manager.armory_ysep
global.challenge_color_incomplete = make_color_rgb(10,10,10)
global.challenge_slot_width = 72
global.challenge_grid_xstart = 16
global.challenge_grid_ystart = 72*2-13
global.challenge_grid_sep = net_manager.armory_ysep-2
global.challenge_grid_widths[get_challenge_grid_index(FL_PROGRESSION)] = 3
global.challenge_grid_widths[get_challenge_grid_index(FL_COMPETITIVE)] = 4
global.challenge_grid_widths[get_challenge_grid_index(FL_BOT)] = 4
global.challenge_grid_widths[get_challenge_grid_index(FL_CHALLENGES)] = 4

global.challenge_grids_xsep = 18

global.challenge_grid_names[get_challenge_grid_index(FL_PROGRESSION)] = "Progression"
global.challenge_grid_names[get_challenge_grid_index(FL_COMPETITIVE)] = global.cmode+" Challenges"
global.challenge_grid_names[get_challenge_grid_index(FL_BOT)] = global.bmode+" Challenges"
global.challenge_grid_names[get_challenge_grid_index(FL_CHALLENGES)] = "General Challenges"

comp_yoff = room_height*1/2-32-130
chal_yoff = room_height*1/2+64*1.5-16-24


//deprecated
bot_yoff = room_height*1/2-64*2

//ASSOCIATIVE DATA STRUCTURE --> CHALLENGE NAME AND OBJECT ID
global.ds_challenges = ds_map_create()

//CHALLENGE VARIABLES
string_counter = 0
string_counter_max = 45

//hound
hound_kills = 2
hound_kills_needed = 10

//fanatic
fanatic_kills = 3
fanatic_kills_needed = 3

//santa_hat
santa_assists = 10
halo_assists = 3

//iron
iron_assists = 5

//ninja
ninjas_needed = 2
ninja_time = 0
ninja_time_needed = 60

//muscle
near_death_xps = 0
near_deaths_needed = 25

//smallvisor2
smallvisor2_kills = 10

//samurai
samurai_kills = 3

//bhunch
bhunch_kills = 5

//ahunch
ahunch_kills = 5

//underwear
underwear_deaths = 6

//assassin
assassin_spree_needed = 5

//pistol prop
pistol_headshots_needed = 2
match_pistol_headshots = 0

//longshot_prop
longshot_headshots_needed = 3
life_longshot_headshots = 0

//thumper_prop
thumper_kills_needed = 3
thumper_kills = 0

//tickler_prop
tickler_kills_needed = 3
tickler_kills = 0

//stomper_prop
stomper_headshots_needed = 3
life_stomper_headshots = 0

//ar prop
rifle_kills_needed = 4
rifle_kills = 0

//carbine prop
carbine_kills_needed = 5
carbine_kills = 0

//flashbang prop
flashes_needed = 3
flashes = 0

//boom prop
boom_kills_needed = 3
boom_kills = 0

//rocket prop
rocket_kills_needed = 3
rocket_kills = 0

//torque prop
torque_kills_needed = 3
torque_kills = 0

//sticky_prop
sticky_kills_needed = 3
sticky_kills = 0

//ink_prop
ink_kills_needed = 3
ink_kills = 0

//flame_prop
flame_kills_needed = 3
flame_kills = 0

//snare_prop
snare_kills_needed = 3
snare_kills = 0

//boltok prop
boltok_kills_needed = 4
boltok_kills = 0

//smoke prop
smokes_needed = 6
smokes = 0

//vulcan prop
vulcan_kills_needed = 4
vulcan_kills = 0

//lmg prop
lmg_kills_needed = 4
lmg_kills = 0

//smg prop
smg_kills_needed = 3
smg_kills = 0

//kills
match_kills = 0
spree_kills = 0
match_points = 0

//gnasher prop
shotgun_gib_timer = 0
shotgun_gib_timer_max = 30*2
shotgun_gib_spree = 0
shotgun_spree_needed = 2

//double prop
double_gib_timer = 0
double_gib_timer_max = 30*2
double_gib_spree = 0
double_spree_needed = 2

//frag prop
frag_kills_needed = 2   //simultaneously

challenge_index = 0

populate_progression_challenges()
populate_challenges()