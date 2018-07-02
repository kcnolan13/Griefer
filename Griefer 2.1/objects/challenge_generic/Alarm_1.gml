/// @description draw slot to surface at the highest scale expected (2?)
/// @function draw slot to surface at the highest scale expected 
/// @param 2?
if not in_match()
{
	if not surface_exists(surf_slot)
	{
	    surf_slot = surface_create(net_manager.armory_sl*2,net_manager.armory_sl*2)
	    if not surface_exists(surf_slot)
	    {
	        printf("ERROR: challenge_generic cannot find surf_slot in alarm[1] ... trying to regenerate")
	        return false
	    }
	    else
	    {
	        printf(":::WARNING: had to regenerate surf_slot for challenge_generic")
	    }
	}

	//printf("::: recreating surf_slot ("+sprite_get_name(icon)+")")

	surface_set_target(surf_slot)

	    draw_clear(c_black)
	    draw_set_color(c_white)
	    draw_set_alpha(1)

	    tempscale = 2
	    var drawspr = icon
	    var square_xmid = 72/2*tempscale
	    var square_ymid = 72/2*tempscale
	    var proper_scale = tempscale*scale_2icon(drawspr)//*64/72
	    var spr_xoff = (sprite_get_width(drawspr)/2-sprite_get_xoffset(drawspr))*proper_scale
	    var spr_yoff = (sprite_get_height(drawspr)/2-sprite_get_yoffset(drawspr))*proper_scale
    
	    draw_bpart_slot_ext(0, 0, tempscale, color, 1)
	    draw_set_blend_mode(bm_normal)
	    draw_sprite_ext(drawspr,0,0+square_xmid-spr_xoff,0+square_ymid-spr_yoff,proper_scale,proper_scale,0,c_white,10)
    
	surface_reset_target()
}

alarm[1] = random_range(30/2,30*2)

/* */
/*  */
