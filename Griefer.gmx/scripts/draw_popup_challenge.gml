///draw_popup_challenge(x, y, title, subtitle, description, icon, color, alpha,scale)

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
var scale = argument8

var height = global.challenge_popup_height*scale
var width = global.challenge_popup_width*scale
var txt_pad = 5
var icon_pad = 20

//INTERCEPT DAT DESCRIPTION and do things to it..
if string_count("Click",descr) < 1
{
    if is_bot_mode
    {
        descr += " in "+global.bmode
    }
    else if is_competitive
    {
        descr += " in "+global.cmode
    }
    if progress_varname != ""
    {
        var d = acc_data(progress_varname,COL_DESCR)
        if d != "descr"
            descr += " ... ("+d+")"
    }
}
var width_less = 0
var height_less = 0

//extra height to the popup if descr is too long
if string_length(descr) > 45
{
    width += 64
    width_less = 64
}
    

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
    
    var whiles = 0
    while (bottom > room_height) and whiles < 1000
    {
        whiles++
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
    
    var whiles = 0
    while (left > WVIEW+1) and whiles < 1000
    {
        whiles++
        right--
        left--
    }
    
}

//draw title rectangle
draw_set_color(color)
draw_set_alpha(0.95*alpha)

draw_rectangle(left,top,right,top+height/2,false)

//draw body rectangle
draw_set_color(c_black)
draw_set_alpha(0.95*alpha)//alpha*0.8)
draw_rectangle(left,top+height/2,right,bottom,false)
draw_set_color(c_white)
draw_set_alpha(0.6*alpha)
draw_rectangle(left+icon_pad,top+icon_pad,left+(bottom-top)-icon_pad,bottom-icon_pad,false)
draw_set_alpha(alpha)

//draw the icon
//draw_bpart_icon_ext(icon, left+13, top+10, icon_scale, alpha)
draw_bpart_slot_complete_ext(id, left+icon_pad*scale, top+icon_pad*scale, ((height-height_less)-2*icon_pad*scale)/(72), alpha)

draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_alpha(average2(alpha,1))
draw_set_color(c_white)
draw_text_ext_transformed(left+(net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10)*scale,top+(txt_pad+8)*scale,dat_title, 24, width/scale-145,scale,scale,0)
draw_set_font(fnt_hud)
draw_set_valign(fa_top)
if progress_varname != "" subtitle = string(progress)+" / "+string(progress_max)+"      +"+string(xp)+" XP"
    draw_text_ext_transformed(left+(net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10)*scale,top+(32+txt_pad+5)*scale,subtitle, 24, width/scale-145,scale,scale,0)

draw_text_ext_transformed(left+(net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10)*scale,top+height/2+(txt_pad+5)*scale,descr, 24, width/scale-145,scale,scale,0)
draw_set_valign(fa_top)

draw_set_alpha(1)
