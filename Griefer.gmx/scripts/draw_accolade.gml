///draw_accolade()
//only callable FROM an accolade_generic

//only draw when you actually have one
/*if number < 1
{
    printf(":::WARNING: "+string(text)+" bailing on accolade draw because you have none")
    return false
}*/

var sprite_offset = sprite_get_width(image)/2/2*scale
var xdraw = left+sprite_offset
var ydraw = top+sprite_offset

if number > 0
{
    image_blend = c_white
    image_alpha = 1
} else {
    image_blend = c_black
    image_alpha = 0.75
}

draw_sprite_ext(image,img_index,xdraw,ydraw,scale/2,scale/2,0,image_blend,image_alpha*draw_get_alpha())

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
    var txtscale = scale-(accolade_manager.acc_match_scale-1)
    if txtscale < 0
        txtscale = 0
        
    if match_ending() txtscale = scale
    
    draw_text_transformed(xdraw,ydraw+yoff,text,txtscale,txtscale,0)
}
else
{
    ysep = 0
}

if not in_match() or match_ending()
{
    if number > 0 and hover_counter < 1
        draw_text_transformed(xdraw,ydraw+yoff+ysep,"X "+string(number),scale,scale,0)
}

if show_popup and (accolade_manager.acc_popup_id = id or accolade_manager.acc_popup_id = noone)
{
    accolade_manager.acc_popup_id = id
    depth = depth_show_popup
    draw_popup(xdraw-global.popup_width*3/4,ydraw-global.popup_height*1.5,text,"X "+string(number),"",description,c_black,1)
    draw_sprite_ext(image,img_index,xdraw+global.popup_width*1/4+42,ydraw-global.popup_height*1.5+30,0.75,0.75,0,c_white,1)
} else depth = depth_normal
