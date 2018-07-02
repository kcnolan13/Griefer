/// @description show_all_tips()
/// @function show_all_tips
with net_manager
{
    var h = HVIEW*2/3
    var w = WVIEW*2/3
    var ID
    {
        ID = instance_create(WVIEW/2,HVIEW/2,modal_window)
        ID.halign = fa_center
        ID.valign = fa_center
        ID.color = c_black
        ID.header_height = 0
        ID.die_click_anywhere = true
        ID.alpha_max = 0.75
        ID.highlightable = false
        ID.text_halign = fa_center
        ID.is_gui = true
        ID.height = h
        ID.width = w
        with (ID) modal_aligns()
        ID.draw_fade = true
        ID.fade_alpha = 0.4
        
        var str = ""
        for (var i=0; i<getLength(pre); i++)
        {
            str += tip_text(i)
            if i < getLength(pre)-1
                str += "#"
        }
        ID.text = str
    }
}
