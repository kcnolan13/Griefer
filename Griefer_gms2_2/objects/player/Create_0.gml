/// @description initialize player
perform_step = 0
my_doll = NO_HANDLE
alarm[1] = 2

//recompute lowest pnums and whatnot
alarm[2] = room_speed

aamt = 0.875
atarget = 0.07
rtarget = 0.06

//vars that needed to be transmitted framely --> now only when they change!
stationary_counter = 0
stationary_threshold = 30*10
xyLerp = 0.35
xyLerp_counter = 0
update_physics = false
sprite_index_transmitted = 0
animation_transmitted = ""
match_points_transmitted = 0
match_deaths_transmitted = 0
match_kills_transmitted = 0
match_assists_transmitted = 0
visible_transmitted = 0
animation_speed_transmitted = 0
animation_direction_transmitted = 0
animation_xscale_transmitted = 0
animation_index_transmitted = 0
active_weapon_sprite_transmitted = 0
arms_posing_transmitted = 0
arm_pose_transmitted = ""
arm_animation_length_transmitted = 0
arm_animation_index_transmitted = 0
arm_animation_direction_transmitted = 0
arm_animation_speed_transmitted = 0
active_weapon_prescaler_transmitted = 0
//end framely vars

//hitscan vars
hitscan_xi = 0
hitscan_yi = 0
hitscan_xf = 0
hitscan_yf = 0
hitscan_obj = 0
hitscan_prec = 0
hitscan_notme = 0



curs_xoff = 256
curs_yoff = 256

damage_scaler = 0.75

//bot constants
play_dead = false
semi_auto_time_min = 12
semi_auto_time = 0
shooting_dist = 0
overheating = 0
overheating_max = 0
auto_shooting = false
possible_2shoot = true
shooting_prob = 0
weapon_time = 0
weapon_time_min = 30
//for bot weapon switching time?
switch_time = 0
switch_time_min = 30
//no idea?
force_switch = false
weapon_switch_delay = 0
weapon_switch_delay_max = 30*3

time_since_wepcont = 0
near_death = false
hide_spawn_text = false

//view shit
computed_curs = false
computed_view = false
xtest = 0
ytest = 0
xtest_prev = 0
ytest_prev = 0

//dummy vars
wall_delay = 0
hold = false

//spawn-related stuff
respawn_counter = 30*1.5+ceil(random_range(0,30*1))
double_spawn_counter =0
respawn_flag = FL_NORMAL
double_spawn_window = 20
spawn_fail_message = ""
spawn_x = 0
spawn_y = 0
respawn_delay = 30*3
walking = false

xaim = 0
yaim = 0

//inherit from character generic
event_inherited()
debug_counter = 0
alarm[1] = 30*5
bparts_ready = false

varWrite("blood_color",global.blood_color)//make_colour_hsv(random(255),255,200))

varWrite("match_kills_previous",0)
varWrite("match_deaths_previous",0)
varWrite("match_assists_previous",0)
varWrite("match_points_previous",0)

varWrite("bot",false)
varWrite("alive",false)
varWrite("player_quit",false)
varWrite("flash_hp",100)
varWrite("fire_counter",0)

init_net_physics()


varWrite("speed_multiplier",1)

alive_counter = 0
view_scaler = 1
view_shake_counter = 0
view_shake_long = 0
view_shake_medium = 0
view_shake_short = 0

initial_weapon_spawn_delay = random(3*30)

weapon_wheel_alpha_max = 4
weapon_wheel_alpha = 0
weapon_wheel_fader = 0.175

mouse_wheel_delay = 0
mouse_wheel_delay_max = 2

weapon_contemplating = NO_HANDLE
weapon_contemplation_time = 0
weapon_contemplation_time_max = 1*30

recovery_time = 4*30
recovery_delay = 2*30
recovery_delay_counter = 0
hp_previous = 100
flash_recovery_time = 1.5*30
flash_recovery_delay = 2*30
flash_recovery_delay_counter = 0
flash_hp_previous = 100

animation_previous = 0
arm_pose_previous = 0
roll_dir = 0
varWrite("animation_scale",PLAYER_SCALE)
varWrite("animation_speed",0)

varWrite("hit_dir",0)
varWrite("hit_mag",0)
varWrite("hit_x",0)
varWrite("hit_y",0)

//weapon objects that belong to this character
varWrite("weapon0",NO_HANDLE)
varWrite("weapon1",NO_HANDLE)
varWrite("weapon2",NO_HANDLE)
varWrite("weapon3",NO_HANDLE)
varWrite("weapon_index",0)
varWrite("active_weapon",NO_HANDLE)

varWrite("you_dead_son",false)
varWrite("trigger_update_ignore",false)
varWrite("update_ignore_counter",0)
varWrite("update_ignore_counter_max",30)
varWrite("drop_weapon_x",0)
varWrite("drop_weapon_y",0)

animation_stand()
varWrite("animation_speed",SPD_STAND)
pose_rifle()

varWrite("controllable",false)
varWrite("uniqueId","0")
varWrite("image_alpha",1)
varWrite("image_blend",c_white)
varWrite("pName","Bob The Squirrel")
varWrite("pNum",-1)
varWrite("myX",x)
varWrite("myY",y)
varWrite("hp",100)
varWrite("die",false)
varWrite("die_headshot",false)
varWrite("die_splosion",false)

varWrite("helmet0","")
varWrite("torso0","")
varWrite("leg0","")
varWrite("shin0","")
varWrite("foot0","")
varWrite("hat0","")
varWrite("shoulder0","")
varWrite("forearm0","")

//initial stats (just declared here, which doesn't actually do anything anyway)
varWrite("points",0)
varWrite("kills",0)
varWrite("deaths",0)
varWrite("assists",0)
varWrite("match_points",0)
varWrite("match_kills",0)
varWrite("match_deaths",0)
varWrite("match_assists",0)
varWrite("match_rank",0)
varWrite("get_assist",0)
varWrite("kill_streak",0)
varWrite("win_streak",0)
varWrite("rollover_kstreak",false)
varWrite("rollover_wstreak",false)

varWrite("killer","")
varWrite("assister","")

die_timer = 0

alarm[0] = 5

//physics vars
initialize_physics()

sprite_index = spr_player
visible = false
varWrite("visible",false)

printf("player created")

