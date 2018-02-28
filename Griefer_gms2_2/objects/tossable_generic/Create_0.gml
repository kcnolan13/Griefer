/// @description set up for physics
netvars = ds_map_create()

//dummy vars
audio_scaler = 0
bounces = 0
spd = 0

hsp = 0
vsp = 0
grav = 0
dir = 0

//depth = -25
fakedirection = random_range(0,360)
rotation = sign(fakedirection)
rspeed = random_range(0,25)
image_alpha = 8
sprite_2draw = spr_head
varWrite("scale",PLAYER_SCALE)
sprite_index = spr_tossable_generic
counter = 0
varWrite("play_stick_sound",false)
varWrite("sound_bounce",snd_frag_land)
varWrite("myX",x)
varWrite("myY",y)
varWrite("gravity",2)
varWrite("is_bullet",false)
varWrite("local",false)
varWrite("image_blend",c_white)
varWrite("spawner",-1)
varWrite("been_picked_up",false)
varWrite("rigidity",3)
varWrite("can_rotate",true)
varWrite("stationary",false)
varWrite("deceleration",0)
varWrite("max_speed",99999999)
stationary_counter = 0

varWrite("stuck_pname",-52)
varWrite("stuck_xoff",0)
varWrite("stuck_yoff",0)
varWrite("stuck_xscaler",0)
varWrite("stuck_ang",0)

rigidity = 3
splode_now = false
have_hit_target = false
splosion = splosion_frag
cook_time = -1
start_cook_on_hit = false
sticky = false
stuck = false
stuck_player = noone
stuck_xoff = 0
stuck_yoff = 0
stuck_ang = 0
stuck_xscaler = 1
dir_perm = 0
varWrite("dir_override",dir_perm)

varWrite("stuck",false)
varWrite("stuck_pnum",-1)
varWrite("stuck_xoff",0)
varWrite("stuck_yoff",0)
varWrite("stuck_ang",0)

init_net_physics()

