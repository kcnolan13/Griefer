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

if object_index = modal_splat
{
    draw_modal_splat()
    exit
}   

draw_modal_window()

