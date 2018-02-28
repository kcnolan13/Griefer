/// @description popup_okay(x, y, header, message, scr_okay)
/// @function popup_okay
/// @param x
/// @param  y
/// @param  header
/// @param  message
/// @param  scr_okay
var xi = argument0
var yi = argument1
var head = argument2
var msg = argument3
var scr = argument4

var ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_okay = scr
    ID.is_yesno = false
    ID.header_text = head
    ID.text = msg
    return ID
}
