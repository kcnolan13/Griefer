/// @description initialize
netvars = NO_HANDLE

//call for compute lowest pnum
alarm[4] = room_speed

asked_force_sync = false

bound_bn_ready = instance_create(x,y,bn_ready)
bound_bn_ready.bound_avatar = id

shuffling = 0
shuffling_max = 30*2
shuffling_toff = 30

lobby_scale_decrementor = 0.2
prescaled = false
anim_prescaled = 1

spam_pnum = 0

event_inherited()
printf("A DUDE IS BEING MADE")
varWrite("pNum_override",-1)
varWrite("pNum",0)
varWrite("animation_scale",3)
varWrite("player_quit",false)
varWrite("bot",false)
varWrite("nextMapVote",-1)
animation_previous = 0
arm_pose_previous = 0
my_bot = 0

force_jumped = false

mouse_wheel_delay = 0
mouse_wheel_delay_max = 2

varWrite("gear_to_lose",false)
varWrite("gear_to_steal",false)
varWrite("stolen_gear_source",global.src_empty)
varWrite("lost_gear_source",global.src_empty)
varWrite("uniqueId","-52")
varWrite("true_skill",-1)
varWrite("global_rank",-1)

varWrite("rank",0)

//bparts
bparts_all_init()

for (var i=0; i<NUM_BPARTS; i++)
{
    bparts_ready[i] = false
}

randomize()

wep_index = ceil(random_range(weapon_placeholder1+1,weapon_placeholder2-1))
assume_weapon(wep_index)


animation_stand()
varWrite("visible",false)
varWrite("animation_speed",SPD_STAND)
varWrite("ready",false)
visible = false
alarm[0] = 30*10
alarm[1] = 1
alarm[2] = 30
//set xy to reasonable numbers
//alarm[3] = 30

