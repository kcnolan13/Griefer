///popup_yesno(x, y, message, scr_yes, scr_no)
var xi = argument0
var yi = argument1
var msg = argument2
var scr_yes = argument3
var scr_no = argument4

var ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_yes = scr_yes
    ID.scr_no = scr_no
    ID.is_yesno = true
    ID.header_text = msg
    return ID
}
