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

var title_height = 64
var body_height = 64
var width = 266
var txt_pad = 5

if draw_x = mouse_x and draw_y = mouse_y and global.using_gamepad
{
    draw_x = cursor.x
    draw_y = cursor.y
}

//average with 1 --> they should generally be more opaque than they have been in the past
alpha = average3(alpha,1,1)

if net_manager.menu_mode = "armory" //or (net_manager.av_popup != noone and y > room_height/2)
{
    draw_x = cursor.x
    if draw_x < room_width/2
        draw_x -= net_manager.armory_sl
    draw_y = cursor.y
    alpha = alpha*0.75
}

if draw_x+net_manager.armory_sl >= room_width/2
{
    /*if draw_y < room_width/4
    {
        left = draw_x-width+net_manager.armory_sl
        top = draw_y+net_manager.armory_sl
        right = left+width
        bottom = top+body_height+title_height
    }
    else*/
    {
        left = draw_x - width
        right = draw_x
        top = draw_y
        bottom = draw_y+title_height+body_height
    }
}
else
{
    /*if draw_y < room_width/4
    {
        top = draw_y+net_manager.armory_sl
        right = draw_x+width
        left = right-width
        bottom = top+body_height+title_height
    }
    else*/
    {
        left = draw_x+net_manager.armory_sl
        right = draw_x+width+net_manager.armory_sl
        top = draw_y
        bottom = draw_y+title_height+body_height
    }
}


while (bottom > room_height)
{
    bottom --
    top --
}

//draw title rectangle
draw_set_color(color)
draw_set_alpha(alpha)

draw_rectangle(left,top,right,top+title_height,false)

//draw body rectangle
draw_set_color(c_black)
draw_set_alpha(alpha*0.9)
draw_rectangle(left,top+title_height,right,bottom,false)
draw_set_alpha(alpha)

//draw title/subtitle
draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_text(left+txt_pad,top+txt_pad,dat_title)
draw_set_font(fnt_hud)
draw_set_valign(fa_bottom)
draw_text(left+txt_pad,top+title_height-txt_pad,subtitle)
draw_set_valign(fa_top)

//figure out source and draw it
if string_length(body_text_override) < 1
{
    if source = global.src_lotto
    {
        draw_text(left+txt_pad,top+title_height+txt_pad,source)
    } else if source = global.src_challenge
    {
        draw_text(left+txt_pad,top+title_height+txt_pad*2,"Challenge Gear!")
    } else if string_length(source) > 0
    {
        //must be stolen gear
        draw_text(left+txt_pad,top+title_height+txt_pad,"Stole From:")
        draw_text(left+txt_pad,top+title_height+24+txt_pad,source)
    }
}
else
{
    draw_text_ext(left+txt_pad,top+title_height+12+txt_pad,body_text_override,txt_pad,(left-right))
}