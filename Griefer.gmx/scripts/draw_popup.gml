///draw_popup(x, y, title, subtitle, source, body_text_override, color, alpha)
popup_drawn = true
var draw_x = argument0
var draw_y = argument1
var dat_title = argument2
var subtitle = argument3
var source = argument4
var body_text_override = argument5
var color = argument6
var alpha = argument7

var title_height = global.popup_title_height
var body_height = global.popup_body_height
var width = global.popup_width
var txt_pad = global.popup_txt_pad

var draw_normal = true
var alpha_scaler = 1

var hash_count = string_count("#",body_text_override)

{
    body_height += 3*hash_count
}

if object_index = popup_drawer
{
    if draw_sinbad
    {
        draw_normal = false
        alpha_scaler = 1.25
        draw_sinbad = false
    }
}

if draw_normal
{
    if nth_frame(15)
    printf("::: drawing not from popup_drawer")
    if draw_x = mouse_x and draw_y = mouse_y and global.using_gamepad
    {
        draw_x = cursor.x
        draw_y = cursor.y
    }
    
    //average with 1 --> they should generally be more opaque than they have been in the past
    alpha = average3(alpha,1,1)
    
    if menmode() = "armory" or menmode() = "stats" //or (net_manager.av_popup != noone and y > room_height/2)
    {
        draw_x = cursor.x
        if draw_x < room_width/2
            draw_x -= net_manager.armory_sl
        draw_y = cursor.y
        alpha = alpha*0.75
    }
    
    if draw_x+net_manager.armory_sl >= room_width/2
    {
        pleft = draw_x - width
        pright = draw_x
        ptop = draw_y
        pbottom = draw_y+title_height+body_height
    }
    else
    {
        pleft = draw_x+net_manager.armory_sl
        pright = draw_x+width+net_manager.armory_sl
        ptop = draw_y
        pbottom = draw_y+title_height+body_height
    }
    
    while (pbottom > room_height)
    {
        pbottom --
        ptop --
    }

}
else
{
    //other vars should hopefully have already been computed globally by popup_drawer
    pleft = 0//net_manager.armory_sl
    ptop = 0
    pright = width//+net_manager.armory_sl
    pbottom = title_height+body_height
}

//draw title rectangle
draw_set_color(color)
draw_set_alpha(global.popup_alpha*alpha_scaler)

draw_rectangle(pleft,ptop,pright,ptop+title_height,false)

//draw body rectangle
draw_set_color(c_black)
draw_set_alpha(global.popup_alpha*0.9*alpha_scaler)
draw_rectangle(pleft,ptop+title_height,pright,pbottom,false)
draw_set_alpha(global.popup_alpha*alpha_scaler)

//draw title/subtitle
draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_text(pleft+txt_pad,ptop+txt_pad,dat_title)
draw_set_font(fnt_hud)
draw_set_valign(fa_bottom)
draw_text(pleft+txt_pad,ptop+title_height-txt_pad,subtitle)
draw_set_valign(fa_top)

tbody_voff = 12
tbody_voff -= 1*hash_count

//figure out source and draw it
if string_length(body_text_override) < 1
{
    if source = global.src_lotto
    {
        draw_text(pleft+txt_pad,ptop+title_height+txt_pad+tbody_voff,source)
    } else if source = global.src_challenge
    {
        draw_text(pleft+txt_pad,ptop+title_height+txt_pad*2,"Challenge Gear!")
    } else if string_length(source) > 0
    {
        //must be stolen gear
        draw_text(pleft+txt_pad,ptop+title_height+txt_pad,"Stole From:")
        draw_text(pleft+txt_pad,ptop+title_height+24+txt_pad,source)
    }
}
else
{
    draw_text_ext(pleft+txt_pad,ptop+title_height+tbody_voff+txt_pad,body_text_override,txt_pad,(pleft-pright))
}

draw_set_alpha(1)
