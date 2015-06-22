wep_obj = argument0
slot_x = argument1
slot_y = argument2
slot_scale = argument3
slot_alpha = argument4
slot_flag = argument5

slot_icon_scale = 1.2

slot_width = sprite_get_width(spr_weapon_slot)
slot_height = sprite_get_height(spr_weapon_slot)
icons_start = 64*slot_scale
icons_voffset = 9*slot_scale

slot_blend = c_black

if instance_exists(wep_obj)
{
    slot_icon = objVarRead(wep_obj,"icon")
    slot_bullet_icon = objVarRead(wep_obj,"bullet_icon")
    slot_bullet_icon_width = sprite_get_width(slot_bullet_icon)
    slot_name = objVarRead(wep_obj,"name")
    slot_ammo = objVarRead(wep_obj,"ammo")
    slot_clip = objVarRead(wep_obj,"clip")
    slot_icon_prescaler = objVarRead(wep_obj,"scale")
    
    if objVarRead(wep_obj,"is_nade")
        slot_ammo += slot_clip
}


draw_sprite_ext(spr_weapon_slot,-1,slot_x,slot_y,slot_scale,slot_scale,0,slot_blend,slot_alpha)

if slot_flag = FL_HIGHLIGHTED
    draw_sprite_ext(spr_weapon_slot,-1,slot_x,slot_y,slot_scale,slot_scale,0,c_white,slot_alpha/2)
    
if !instance_exists(wep_obj)
{   
    //dont draw any more
    return true
}
    
draw_set_font(fnt_hud)
draw_set_color(c_white)

//draw weapon name
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_set_alpha(slot_alpha)

if slot_flag != FL_ACTIVE_WEAPON
    draw_text(slot_x,slot_y-slot_height/2-2,slot_name)

//draw ammo remaining
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_text(slot_x-slot_width/2+24,slot_y+slot_height/2-2,""+string(slot_ammo))

draw_set_alpha(1)

//draw as many shells as vals in clip
for (i=0; i<slot_clip; i++)
{
    draw_sprite_ext(slot_bullet_icon,-1,slot_x-slot_width/2+icons_start+slot_bullet_icon_width*i,slot_y+slot_height/2-icons_voffset,slot_scale,slot_scale,0,c_white,slot_alpha)
}

//draw the actual weapon
draw_sprite_ext(slot_icon,-1,slot_x,slot_y,slot_scale*slot_icon_prescaler*PLAYER_SCALE*slot_icon_scale,slot_scale*slot_icon_prescaler*PLAYER_SCALE*slot_icon_scale,0,c_white,slot_alpha)
//printf("Weapon Drawn!")