/// @description META STUFF
if not in_match()
{
    if not surface_exists(surf_splat)
        create_splat_surface()
}

dummy_counter ++
if (varRead("visible") or object_index = gravatar) and (varRead("dude_x") or varRead("dude_y"))
{
    if varRead("lerp_delay")
    varWrite("lerp_delay",sub_real(varRead("lerp_delay"),1))
    
    //printf("lerp_realing")
    if not varRead("lerp_delay")
    {
        x = lerp_real(x,varRead("dude_x"),dude_lerp)
        y = lerp_real(y,varRead("dude_y"),dude_lerp)
    }
    
    if dude_instalerp_x
    {
        x = varRead("dude_x")
        dude_instalerp_x = false
    }
    if dude_instalerp_y
    {
        y = varRead("dude_y")
        dude_instalerp_y = false
    }
}

if is_string(varRead("myX")) or is_string(varRead("myY"))
{
    printf("ERROR: COORDS not supposed to be string: "+string(varRead("myX"))+", "+string(varRead("myY")))
    varWrite("myX",real(varRead("myX")))
    varWrite("myY",real(varRead("myY")))
}

///compute limb and weapon offsets for every frame

//either add to or subtract from the animation index
varAdd("animation_index", real_speed(varRead("animation_speed")*varRead("animation_direction")))

//printf(varRead("animation_index")+" : "+varRead("animation_speed")+" : "+varRead("animation_direction"))

if varRead("kick") > 0
{
    varWrite("kick",varRead("kick")/1.5)
    if varRead("kick") < 1
        varWrite("kick",0)
}

if not in_match() or object_index = player or object_index = die_generic
    framely_limb_computations()

///record vars for net sending
if varRead("controllable")
{
    //varWrite("rot_true",rot_true) ---> has to be done in-line
    varWrite("arm_y_extra",varRead("arm_y_extra"))
    varWrite("arm_rot_extra",varRead("arm_rot_extra"))
}

if varRead("cant_shoot")
varSub("cant_shoot",1)

