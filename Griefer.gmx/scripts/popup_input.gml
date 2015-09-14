///popup_input(x, y, is_password, header, scr_okay)
var xi = argument0
var yi = argument1
var is_pass = argument2
var head = argument3
var scr = argument4

var ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_okay = scr
    ID.is_yesno = false
    ID.is_input_field = true
    ID.header_text = head
    
    if is_pass
        ID.is_password = true
        
    return ID
}
