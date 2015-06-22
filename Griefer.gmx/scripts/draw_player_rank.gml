///draw_player_rank(rank,x,y,scale)
var rank = argument0
var draw_x = argument1
var draw_y = argument2
var scale = argument3

draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_center)

if rank<0
    rank = 0
    
if rank > array_length_1d(global.rank_names)-1
{
    increase_max_ranks(rank+5)
}   

draw_set_color(global.rank_colors[rank])
draw_circle(draw_x+global.rank_radius*scale,draw_y+global.rank_radius*scale,global.rank_radius*scale,false)
draw_set_color(c_white)
draw_circle(draw_x+global.rank_radius*scale,draw_y+global.rank_radius*scale,global.rank_radius*scale,true)

draw_text_ext_transformed(draw_x+global.rank_radius*scale,draw_y,rank,0,300,scale,scale,0)