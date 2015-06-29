///draw_lives(x,y,scale,halign,lives)

var dx = argument0
var dy = argument1
var scale = argument2
var halign = argument3
var lifes = argument4

var scl = 0.325

var width = sprite_get_width(icon_challenges_original)*scl + 24

if halign = fa_center
{
    dx -= scale*width/2
}

if halign = fa_right
{
    dx -= scale*width
}

draw_sprite_ext(icon_lives,-1,dx,dy-scale*(sprite_get_height(icon_lives)*scl)/2,scl*scale,scl*scale,0,c_white,1)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_set_font(fnt_hud_big)
draw_text(dx+sprite_get_width(icon_lives)*scl*scale+5,dy,lifes)
