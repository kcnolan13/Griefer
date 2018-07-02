/// @description draw a simple line
draw_set_color(color)
draw_set_alpha(current_intensity+current_intensity_flicker)
if sprite = spr_none
    draw_line_width(x,y,x+trigx(300*xscale,varRead("angle")),y+trigy(300*xscale,varRead("angle")),current_yscale+current_scale_flicker)
else
    draw_sprite_ext(sprite,0,x,y,current_xscale/3,current_yscale,varRead("angle"),color,current_intensity+current_intensity_flicker)
draw_set_alpha(1)
draw_set_color(c_white)

