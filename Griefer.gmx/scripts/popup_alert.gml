///popup_alert(x, y, header, message)
var xi = argument0
var yi = argument1
var head = argument2
var msg = argument3

ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_okay = scr_none
    ID.is_yesno = false
    ID.is_alert = true
    ID.header_text = head
    ID.text = msg
    ID.fade_delay = 50
    ID.header_color = c_yellow
    ID.text_color = c_white
    ID.fade_alpha = 0.35
    ID.height = 64*1.5*2.5*2/3
    ID.width = 64*2.25*2.5*2/3
    ID.scale_lerp_real = 0.2
    ID.dec = 0.1
}

return ID
