///draw_popup_challenge(x, y, title, subtitle, description, icon, color, alpha)

//2 frame delay on other.id challenge popups (after this is gone)
challenge_manager.challenge_showing_popup = 1

var draw_x = argument0
var draw_y = argument1
var dat_title = argument2
var subtitle = argument3
var descr = argument4
var icon = argument5
var color = argument6
var alpha = argument7

var height = global.challenge_popup_height 
var width = global.challenge_popup_width
var txt_pad = 5
var icon_pad = 20

if not in_match()
{
    draw_x = cursor.x
    draw_y = cursor.y
}

alpha = alpha*0.75

if not in_match()
{
    if draw_x+net_manager.armory_sl >= room_width/2
    {
        left = draw_x - width
        right = draw_x
        top = draw_y
        bottom = draw_y+height
    }
    else
    {
        left = draw_x+net_manager.armory_ysep
        right = draw_x+width+net_manager.armory_ysep
        top = draw_y
        bottom = draw_y+height
    }
    
    
    while (bottom > room_height)
    {
        bottom --
        top --
    }
}
else
{
    left = draw_x
    right = left+width
    top = draw_y
    bottom = top+height
}
//draw title rectangle
draw_set_color(color)
draw_set_alpha(0.95)

draw_rectangle(left,top,right,top+height/2,false)

//draw body rectangle
draw_set_color(c_black)
draw_set_alpha(0.95)//alpha*0.8)
draw_rectangle(left,top+height/2,right,bottom,false)
draw_set_color(c_white)
draw_set_alpha(0.6)
draw_rectangle(left+icon_pad,top+icon_pad,left+(bottom-top)-icon_pad,bottom-icon_pad,false)
draw_set_alpha(alpha)

//draw the icon
//draw_bpart_icon_ext(icon, left+13, top+10, icon_scale, alpha)
draw_bpart_slot_complete_ext(id, left+icon_pad, top+icon_pad, ((bottom-top)-2*icon_pad)/72, alpha)
    
draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_text_ext(left+net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10,top+txt_pad+8,dat_title, 24, width-145)
draw_set_font(fnt_hud)
draw_set_valign(fa_top)
draw_set_color(c_white)
if progress_varname != "" subtitle = string(progress)+" / "+string(progress_max)
    draw_text_ext(left+net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10,top+32+txt_pad+5,subtitle, 24, width-145)
draw_set_color(c_white)
//draw description
draw_text_ext(left+net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10,top+height/2+txt_pad+5,descr, 24, width-145)
draw_set_valign(fa_top)

draw_set_alpha(1)
