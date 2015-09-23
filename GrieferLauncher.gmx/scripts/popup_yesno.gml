///popup_yesno(x, y, header, message, scr_yes, scr_no)
var xi = argument0
var yi = argument1
var head = argument2
var msg = argument3
var scr_yes = argument4
var scr_no = argument5

var ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_yes = scr_yes
    ID.scr_no = scr_no
    ID.is_yesno = true
    ID.header_text = head
    ID.text = msg
    
    return ID
}