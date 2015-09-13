///popup_loading(x, y)

var xi = argument0
var yi = argument1
var msg = "Contacting Griefer Services "

create_loading_modal = true
with modal_dialogue
{
    if is_loading
        other.create_loading_modal = false
}

if not create_loading_modal
    return false
    
printf("::: creating loading modal")
global.load_count ++

ID = instance_create(xi,yi,modal_dialogue)
{
    ID.scr_okay = scr_none
    ID.is_yesno = false
    ID.is_alert = false
    ID.is_loading = true
    ID.text = msg
    ID.header_height = 0
    //ID.fade_delay = room_speed*1
    ID.alpha = 0
    ID.text_halign = fa_left
    ID.text_valign = fa_center
    ID.text_xoff = 42
    ID.text_yoff = 0
    ID.text_color = c_white
    ID.fade_alpha = 0.725
    ID.height = 64*2.5*2/3
    ID.width = 64*2.25*2.5
    ID.scale_lerp_real = 0.2
    ID.dec = 0.2
    ID.load_rot_inc = 8
    ID.load_rad = 18
    ID.load_point_rad_max = 8
    ID.load_point_rad_min = 5
    ID.load_points = 3
    ID.load_text_hsep = 10
    ID.birth_delay = 20
}

return ID
