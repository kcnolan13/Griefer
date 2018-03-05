/// @description draw_limb(limb, xpos, ypos, rot)
/// @function draw_limb
/// @param limb
/// @param  xpos
/// @param  ypos
/// @param  rot
limb = argument0
xpos = argument1
ypos = argument2
rot = argument3

limb_2draw = varRead(limb)

limb_2draw = convert_spr_none_to_drawable(limb_2draw,limb)

if string(limb) != "helmet0" and real(limb_2draw) = 0
{
    printf(":::WARNING: could not draw limb: "+string(limb_2draw))
    return false
}

if limb = "forearm0" or limb = "shoulder0" or limb = "active_weapon_sprite"
{
    if (varRead("arms_posing"))
    {
        xscaler = 1
        yscaler = varRead("animation_xscale")
        if varRead("animation_xscale") = 1
        {
            angle = rot
        } else {
            angle = rot
        }
    }
    else {
        xscaler = varRead("animation_xscale")
        yscaler = 1
        angle = rot*varRead("animation_xscale")
    }
} else {
    xscaler = varRead("animation_xscale")
    yscaler = 1
    angle = rot*varRead("animation_xscale")
	if limb == "hat0" {
		var helm = varRead("helmet0")
		angle = (rot - get_hat_rot(helm))*varRead("animation_xscale")
		//correct for weird hat rotation thing
		if varRead("animation_xscale") = -1 {
			angle -= 6
		}
	}
}

if limb = "active_weapon_sprite"
{
    xscaler *= varRead("active_weapon_prescaler")*WEAPON_SCALE
    yscaler *= varRead("active_weapon_prescaler")*WEAPON_SCALE
}

var subimg = 0
if real(limb_2draw) = spr_bhunch_helmet or real(limb_2draw) = spr_ahunch_helmet
    subimg = floor(net_manager.room_counter/2)%30
    
if sprite_exists(real(limb_2draw))
    draw_sprite_ext(real(limb_2draw),subimg,x+xpos,y+ypos,varRead("animation_scale")*xscaler,varRead("animation_scale")*yscaler,angle,image_blend,image_alpha)
else printf("WARNING: nonexistent draw_limb sprite: "+string(limb_2draw))

return true
