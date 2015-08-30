///hit_target(target, collision_x, collision_y)
//MUST BE CALLED FROM A BULLET
var target = argument0
var collision_x = argument1
var collision_y = argument2

if target.object_index > 0
    printf(":::hitting target: "+string(object_get_name(target.object_index)))

varWrite("myX",collision_x)
varWrite("myY",collision_y)
varWrite("speed",0)
obj_update_real(id,"myX",FL_NORMAL)
obj_update_real(id,"myY",FL_NORMAL)

//mark target
x = varRead("myX")
y = varRead("myY")
hitmark_target(id,target)
