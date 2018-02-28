/// @description simple_popup(header_text, body_text)
/// @function simple_popup
/// @param header_text
/// @param  body_text
var header = argument0
var body = argument1

{
    
    ID = instance_create(__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2,__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2,modal_window)
    ID.font = fnt_hud_big
    ID.depth = -100
    ID.fade_delay = 30*2
    ID.birth_delay = 2
    ID.color = c_ltgray
    ID.halign = fa_center
    ID.valign = fa_center
    ID.text = body
    ID.text_color = c_black
    ID.header_text = header
    ID.header_text_color = c_lime
    ID.header_color = c_gray
}