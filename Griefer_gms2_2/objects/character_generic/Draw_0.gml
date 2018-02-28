/// @description draw all limbs at appropriate position based on animation_index
if not varRead("visible") or varRead("player_quit") exit

if object_index = die_generic and dummy_counter < 2 exit

if not in_match() and room != rm_login
{
    if varRead("animation_index") < 12
        shadow_scale = 0.5+0.05*varRead("animation_index")/12
    else
        shadow_scale = 0.55-0.05*(varRead("animation_index")-12)/12
        
    shadow_scale *= varRead("animation_scale")/net_manager.av_scale_menu
        
    if varRead("dude_y")
        shadow_y = varRead("dude_y")
    else
        shadow_y = y 
        
    shadow_y += 64*3.35*varRead("animation_scale")/3
    
    if varRead("blood_color") = global.blood_color
        draw_sprite_ext(spr_doll_shadow,0,x,shadow_y,shadow_scale,shadow_scale,0,c_white,0.8)
    else if surface_exists(surf_splat)
    {
        var scale_scaler = 2.25
        surface_set_target(surf_splat)
        draw_clear_alpha(c_black,0)    
        draw_set_alpha(1)
        draw_splats(splat_width/2-2,0,0.75,varRead("blood_color"),1)
        surface_reset_target()
        draw_surface_ext(surf_splat,x-splat_width*shadow_scale*scale_scaler/2-10,shadow_y,shadow_scale*scale_scaler,shadow_scale*scale_scaler,0,c_white,1)
    }
}


calc_limb_draws()

//left arm
var ret = true

ret = draw_limb("forearm0",forearml_drawx,forearml_drawy,forearml_drawr)
if not ret exit
ret = draw_limb("shoulder0",shoulderl_drawx,shoulderl_drawy,shoulderl_drawr)
if not ret exit

//left leg
ret = draw_limb("leg0",legl_drawx,legl_drawy,legl_drawr)
if not ret exit
ret = draw_limb("shin0",shinl_drawx,shinl_drawy,shinl_drawr)
if not ret exit
ret = draw_limb("foot0",footl_drawx,footl_drawy,footl_drawr)
if not ret exit

//torso
ret = draw_limb("torso0",torso_drawx,torso_drawy,torso_drawr)
if not ret exit

//right leg
ret = draw_limb("leg0",legr_drawx,legr_drawy,legr_drawr)
if not ret exit
ret = draw_limb("shin0",shinr_drawx,shinr_drawy,shinr_drawr)
if not ret exit
ret = draw_limb("foot0",footr_drawx,footr_drawy,footr_drawr)
if not ret exit

if (varRead("animation") != "die_headshot")
{
    //head
    draw_limb("helmet0",head_drawx,head_drawy,head_drawr)
    
    //hat
    var helm = varRead("helmet0") 
    if not is_hatless(helm) and string(helm) != "" and real(helm) != spr_helmet_none
        draw_limb("hat0",hat_drawx,hat_drawy,hat_drawr)
}

//weapon
if varRead("arms_posing") and (varRead("arm_pose") != "nade" or (varRead("nades") > 0 or !in_match()))
    draw_limb("active_weapon_sprite",weapon_x+varRead("animation_scale")*weapon_xoffset_temp,weapon_y+varRead("animation_scale")*weapon_yoffset_temp,-1*weapon_rot)

//right arm
draw_limb("forearm0",forearmr_drawx,forearmr_drawy,forearmr_drawr)
draw_limb("shoulder0",shoulderr_drawx,shoulderr_drawy,shoulderr_drawr)


