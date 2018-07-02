/// @description draw description and stuff
event_inherited()

draw_set_font(font)
draw_set_color(c_white)
draw_flash_compensate()
draw_set_alpha(1)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text(x,y-height/2-12,string_hash_to_newline(descr))

if is_slider and modal_highlighted(id) and mouse_check_button(mb_left)
{
    //adjust slider
    if is_slider
    {
        slider_value = min(1, 1 * (display_mouse_get_x()-(left+10)) / (width-20))
        if slider_value < 0
            slider_value = 0
    }
}

if is_slider
{
    draw_set_color(c_gray)
    draw_set_alpha(0.75)
    draw_rectangle(left+10,top+5,left+5+slider_value*(width-20),top+height-5,false)
    draw_set_alpha(1)
    draw_set_color(c_white)
    draw_text(x,y,string_hash_to_newline(string(slider_value)))
    text = ""
}

if is_color
{
    text = ""
}

if is_texture and not capturing
{
    text = ""
}

if is_toggle
{
    if slider_value
    {
        color = web_hsv(156,69,56)
        text = "True"
    }
    else
    {
        color = web_hsv(0,0,0)
        text = "False"
    }
}

if is_texture and capturing
{
    draw_text(x,y,string_hash_to_newline("Capturing ..."))
}

