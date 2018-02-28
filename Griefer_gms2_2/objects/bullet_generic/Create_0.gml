/// @description initialize
netvars = ds_map_create()

depth = -95

stationary_counter = 0
have_hit_target = false
spr_light_mask_hitscan_simple = 0
no_from_player = false
from_player = noone

//dummy vars
bounces = 0

//graphics
varWrite("flash_hitscan",flash_hitscan_pistol)
varWrite("sprite",spr_bullet)
traj_draw = false
traj_length = 64*8
traj_intensity = 2
traj_yscale = 0.4
traj_xscale = 0.4
traj_life = 20
traj_color = make_color_rgb(255,205,148)
traj_intensity_divisor = 1.25
traj_intensity_flicker = 0
traj_scale_divisor = 1
traj_scale_flicker = 0
traj_sprite = spr_light_mask_hitscan_simple
traj_xscale_divisor = 2


//damage
varWrite("damage_body",1)
varWrite("damage_head",2)
varWrite("headshot_difficulty",1)

//damage falloff
varWrite("falloff_x1",64*4)
varWrite("falloff_y1",1)
varWrite("falloff_x2",64*8)
varWrite("falloff_y2",1)
varWrite("falloff_x3",64*12)
varWrite("falloff_y3",1)

//engine
audio_scaler = 1
varWrite("first_in_burst",false)
varWrite("sound",snd_pistol)
varWrite("is_bullet",true)
varWrite("body_death_type","die")
varWrite("gib_distance",-1)
varWrite("headshot_distance",sqrt(room_width*room_width+room_height*room_height))
varWrite("hitscan",false)
varWrite("myX",x)
varWrite("myY",y)
varWrite("xStart",x)
varWrite("yStart",y)
varWrite("local",false)
varWrite("direction",0)
varWrite("speed",0)
varWrite("senderId",MY_PLAYER_NULL)
varWrite("is_bullet",true)
varWrite("local",false)
varWrite("image_blend",c_white)
varWrite("deceleration",0)
varWrite("gravity",0)
varWrite("min_speed",20)
varWrite("max_speed",99999999)
init_net_physics()
hsp = -999
vsp = -999
counter = 0

