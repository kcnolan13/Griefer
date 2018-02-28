/// @description CREATE FIXTURE
fix = physics_fixture_create()

launch_pad_counter = 0
launch_pad_threshold = 5

joint_health = 125

life = 0

if object_index != rag_generic and (object_index-rag_head < getLength(global.bpart_limb_types))
{
    limb_type = global.bpart_limb_types[object_index-rag_head]
}

max_speed = 40
max_vang = 360/2

scale = 1
image_angoff = 0
do_bind = false
joint_xs[0] = 30 joint_ys[0] = 24

joints[0] = NO_HANDLE
joint_ind = 0

joint_dirs[0] = 0
joint_dirs[1] = 0

is_bound[0] = false
is_bound[1] = false
is_bound[2] = false
is_bound[3] = false

bullet_pushed = false

xscale = 1
yscale = 1

side = FL_LEFT


//blood constants
bleed_time = random_range(2*30,4*30)
bleed_strength_delay = bleed_time*2/3
bleed_strength_dec = 0.25
bleed_strength = random_range(16,18)

if object_index = rag_head
{
    bleed_strength += 5
}
else if object_index = rag_torso
{
    bleed_strength /= 3
    bleed_time = random_range(4*30,8*30)
}
else if object_index = rag_hat
{
    bleed_strength = 0
    bleed_time = 0
}


fade_delay = 30*10
alpha_dec = 0.025

