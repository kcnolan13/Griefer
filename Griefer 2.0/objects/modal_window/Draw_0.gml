/// @description draw the stuff
if birth_delay > 0 or is_gui
    exit

if draw_fade or draw_gradient
{
    draw_set_alpha(fade_alpha*alpha*alpha_scaler)
    draw_set_color(fade_color)
    if not draw_gradient    
        draw_rectangle(0,0,WVIEW,HVIEW,false)
}  

draw_set_alpha(alpha*alpha_scaler)

left = x
top = y

if object_index = modal_meter
{
    var datVal = meter_val
    if meter_val_places > 0 and meter_val mod 1 = 0
    {
        datVal = string(meter_val)+"."
        for (var i=0; i<meter_val_places; i++)
            datVal += "0"
    }
    draw_stat_meter(x,y,datVal,meter_desc,meter_col_out,meter_col_in,scale*master_scale,meter_backing_percent,meter_percent)
    exit
}

if object_index = modal_stat_history
{
    draw_stat_history_chart(x,y,scale*master_scale,col_pos,col_neg,y_threshold,history_string,record_count)
    exit
}

if object_index = modal_splat
{
    draw_modal_splat()
    exit
}   

draw_modal_window()

