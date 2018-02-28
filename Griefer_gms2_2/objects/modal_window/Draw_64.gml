/// @description draw in the GUI layer
if birth_delay > 0 or not is_gui
    exit

if draw_fade or draw_gradient
{
    draw_set_alpha(fade_alpha*alpha*alpha_scaler)
    draw_set_color(fade_color)
    if not draw_gradient    
        draw_rectangle(0,0,WVIEW,HVIEW,false)
    else
        draw_rectangle_colour(0,0,WVIEW,HVIEW, grad1, grad2, grad3, grad4, false)
}    

draw_set_alpha(alpha*alpha_scaler)
gui_xoff = x
gui_yoff = y
left = gui_xoff
top = gui_yoff

if object_index = modal_meter
{
    var datVal = meter_val
    if meter_val_places > 0 and meter_val mod 1 = 0
    {
        datVal = string(meter_val)+"."
        for (var i=0; i<meter_val_places; i++)
            datVal += "0"
    }
    draw_stat_meter(gui_xoff,gui_yoff,datVal,meter_desc,meter_col_out,meter_col_in,scale*master_scale,meter_backing_percent,meter_percent)
    exit
}

if object_index = modal_stat_history
{
    draw_stat_history_chart(gui_xoff,gui_yoff,scale*master_scale,col_pos,col_neg,y_threshold,history_string,record_count)
    exit
}

if object_index = modal_splat
{
    draw_modal_splat()
    exit
}   

draw_modal_window()

