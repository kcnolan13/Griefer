/// @description set up for physics
netvars = ds_map_create()

initialize_physics()

//depth = -25
counter = 0
fakedirection = -10+random(20)
rotation = sign(fakedirection)
rspeed = 1+random(14)
bleeding = 10+random(20)
image_alpha = 6
sprite_2draw = spr_head
scale = PLAYER_SCALE
blood_streamer = spray_blood(x,y,random_range(0.1,0.3),fakedirection,1,random_range(5,30),1.25,8,2,3,c_red)

