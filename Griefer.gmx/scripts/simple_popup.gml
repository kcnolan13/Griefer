///simple_popup(header_text, body_text)
var header = argument0
var body = argument1

{
    
    ID = instance_create(view_xview+view_wview/2,view_yview+view_hview/2,modal_window)
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