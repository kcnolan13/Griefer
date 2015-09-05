///draw_accolade()
//only callable FROM an accolade_generic

//only draw when you actually have one
if number < 1
{
    printf(":::WARNING: "+string(text)+" bailing on accolade draw because you have none")
    return false
}
var sprite_offset = sprite_get_width(image)/2
var xdraw = left+sprite_offset
var ydraw = top+sprite_offset

draw_sprite_ext(image,img_index,xdraw,ydraw,scale,scale,0,c_white,draw_get_alpha())

draw_set_font(fnt_hud)
draw_set_halign(fa_center)
draw_set_valign(fa_top)
if in_match()
{
    draw_set_color(c_white)
    draw_flash_compensate()
}
else
    draw_set_color(c_white)

var yoff = sprite_offset+2*scale
var ysep = 20*scale

if in_match()
{
    draw_text_transformed(xdraw,ydraw+yoff,text,scale,scale,0)
}
else
{
    ysep = 0
}

if not in_match() or match_ending()
{
    draw_text_transformed(xdraw,ydraw+yoff+ysep,"X "+string(number),scale,scale,0)
}

if show_popup
{
    depth = depth_show_popup
    draw_popup(cursor.x,cursor.y,text,"X "+string(number),"",description,c_black,draw_get_alpha())
} else depth = depth_normal
