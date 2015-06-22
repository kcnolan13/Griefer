///hit_bounce_target(target, collision_x, collision_y)
//ONLY CALLABLE FROM TOSSABLE_GENERIC
var inst = argument0
var collision_x = argument1
var collision_y = argument2

varWrite("myX",collision_x)
varWrite("myY",collision_y)
        
//BOUNCE!
if spd > BOUNCE_MINSPEED
{

    x = varRead("myX")
    y = varRead("myY")
    unstick_in_direction(x, y, varRead("direction")+180, spr_tossable_generic, 64*5, 2)
    varWrite("myX",x)
    varWrite("myY",y)
    /*x = varRead("myX")
    y = varRead("myY")
    scr_unstick_tossable()
    x = varRead("myX")
    y = varRead("myY")*/
    //ID = instance_create(x,y,hit_marker)
    normal = scr_normal_detect(x,y,solid_generic,sprite_get_width(spr_tossable_generic)/4,1)    

    if DEBUG
        printf("calculated bounce normal: "+normal)
        
    new_dir = (normal + (normal - (dir+180))) mod 360
    
    if DEBUG
        printf("new direction: "+new_dir)
    
    hsp = trigx(spd/rigidity,new_dir)
    vsp = trigy(spd/rigidity,new_dir)
    
    if DEBUG
        printf("new speeds: hsp = "+hsp+", vsp = "+vsp)
        
    recalc_tossable_vector()
    varWrite("speed",spd)
    varWrite("direction",new_dir)
    varAdd("myX",hsp)
    varAdd("myY",vsp)
    x = varRead("myX")
    y = varRead("myY")
    
} else 
{
    if DEBUG
        printf("insufficient speed for bouncing to be worth it...")
    hsp = 0; vsp = 0; grav = 0;
    varWrite("speed",0)
    varWrite("gravity",0)
}

if is_local_player(varRead("senderId"))
{
    obj_update_real(id,"speed",FL_NORMAL)
    obj_update_real(id,"direction",FL_NORMAL)
    obj_update_real(id,"gravity",FL_NORMAL)
    obj_update_real(id,"myX",FL_NORMAL)
    obj_update_real(id,"myY",FL_NORMAL)
}