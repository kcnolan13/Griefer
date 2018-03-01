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

if object_index = modal_splat
{
    draw_modal_splat()
    exit
}   

draw_modal_window()

