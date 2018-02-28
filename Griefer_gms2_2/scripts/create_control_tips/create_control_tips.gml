/// @description show_control_tips()
/// @function show_control_tips
var h = 26
var w = 64*7.5
{
    net_manager.control_tips = instance_create(WVIEW/2,HVIEW-h/2,modal_window)
    var ID = net_manager.control_tips
    {
        ID.color = c_black
        ID.is_gui = true
        ID.is_tips = true
        ID.text_okay = "---"
        ID.scr_okay = show_all_tips
        ID.header_text = ""//"Control Tips"
        ID.header_font = fnt_hud
        ID.font = fnt_hud
        ID.draw_fade = false
        ID.draw_gradient = false
        ID.alpha_max = 0.75
        ID.highlightable = false
        ID.height = h
        ID.width = w
        ID.halign = fa_center
        ID.valign = fa_center
        with ID modal_aligns()
        ID.header_alpha = 0
        ID.header_height = 0
        ID.text_valign = fa_middle
        ID.text_yoff = 5
    }
}
