///popup_okay(x, y, message, scr_okay)
var xi = argument0
var yi = argument1
var msg = argument2
var scr = argument3

var ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_okay = scr
    ID.is_yesno = false
    ID.header_text = msg
    return ID
}
