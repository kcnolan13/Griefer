wep_obj = argument0
slot_x = argument1
slot_y = argument2
slot_scale = argument3
slot_alpha = argument4
slot_flag = argument5

slot_icon_scale = 1.2

slot_width = sprite_get_width(spr_weapon_slot)*slot_scale
slot_height = sprite_get_height(spr_weapon_slot)*slot_scale
icons_start = 64*slot_scale
icons_voffset = 9*slot_scale

slot_blend = c_black

if instance_exists(wep_obj)
{
    slot_icon = objVarRead(wep_obj,"icon")
    slot_bullet_icon = objVarRead(wep_obj,"bullet_icon")
    slot_bullet_icon_width = sprite_get_width(slot_bullet_icon)*slot_scale
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
draw_flash_compensate()

//draw weapon name
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_set_alpha(slot_alpha)

if slot_flag != FL_ACTIVE_WEAPON
    draw_text_transformed(slot_x,slot_y-slot_height/2-2*slot_scale,slot_name,slot_scale,slot_scale,0)

//draw ammo remaining
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_text_transformed(slot_x-slot_width/2+24*slot_scale,slot_y+slot_height/2-2*slot_scale,""+string(slot_ammo),slot_scale,slot_scale,0)

draw_set_alpha(1)

//draw as many shells as vals in clip
for (i=0; i<slot_clip; i++)
{
    draw_sprite_ext(slot_bullet_icon,-1,slot_x-slot_width/2+icons_start+slot_bullet_icon_width*i,slot_y+slot_height/2-icons_voffset,slot_scale,slot_scale,0,c_white,slot_alpha)
}

//draw the actual weapon
var spr_width = sprite_get_bbox_right(slot_icon) - sprite_get_bbox_left(slot_icon)
var spr_height = sprite_get_bbox_bottom(slot_icon) - sprite_get_bbox_top(slot_icon)
var wepscale = (slot_width*2/3)/max(0.0005,spr_width)

if spr_height*wepscale > slot_height*1/2
    wepscale = slot_height*1/2/spr_height //(height)/spr_height

if slot_icon = spr_torque
    wepscale *= 1.3

var wep_xoff = wepscale*(sprite_get_xoffset(slot_icon)-sprite_get_width(slot_icon)/2)
var wep_yoff = wepscale*(sprite_get_yoffset(slot_icon)-sprite_get_height(slot_icon)/2)

draw_sprite_ext(slot_icon,-1,slot_x+wep_xoff,slot_y+wep_yoff-9*slot_scale,wepscale,wepscale,0,c_white,slot_alpha)
//printf("Weapon Drawn!")



