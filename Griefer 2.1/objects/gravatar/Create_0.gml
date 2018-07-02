/// @description initialize
netvars = NO_HANDLE

lobby_scale_decrementor = 0.2
prescaled = false
anim_prescaled = 1

event_inherited()
printf("A DUDE IS BEING MADE")
varWrite("pNum",0)
varWrite("login_delay",30)
varWrite("animation_scale",3)
varWrite("player_quit",false)
varWrite("bot",false)

scale_normal = 1.5
scale_highlight = 1.8
scale_lerp = 0.18
login_lerp_delay_base = 30*3
login_lerp_delay = 15
login_dude_lerp = 0.2

animation_previous = 0
arm_pose_previous = 0
force_jumped = false
hover_counter = 0
hover_delay = 10

mouse_wheel_delay = 0
mouse_wheel_delay_max = 2

varWrite("rank",0)
varWrite("global_rank",9000)
varWrite("controllable",true)

//bparts
bparts_all_init()

for (var i=0; i<NUM_BPARTS; i++)
{
    bparts_ready[i] = false
}

bparts_done_ready = false

randomize()

animation_stand()
varWrite("visible",false)
varWrite("animation_speed",SPD_STAND)
visible = true
alarm[1] = 1
alarm[2] = 30
//set xy to reasonable numbers
//alarm[3] = 30

