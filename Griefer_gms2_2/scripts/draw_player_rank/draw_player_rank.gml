/// @description draw_player_rank(rank,x,y,scale)
/// @function draw_player_rank
/// @param rank
/// @param x
/// @param y
/// @param scale
var rank = argument0
var draw_x = argument1
var draw_y = argument2
var scale = argument3

draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

var toff = scale*string_height(string_hash_to_newline("blah"))/8

var real_rank = rank

if is_real(rank)
{
    if rank<0
        rank = 0
    
    if rank > array_length_1d(global.rank_names)-1
    {
        increase_max_ranks(rank+5)
    }   
}
else
{
    draw_set_font(fnt_hud)
    real_rank = string_copy(rank,2,string_length(rank)-1)
    toff = -1*scale*string_height(string_hash_to_newline("blah"))/2
}

var xoff = global.rank_radius*scale
var yoff = global.rank_radius*scale

if object_index = net_manager and draw_prank_centered
{
    xoff = 0
    yoff = 0
    net_manager.draw_prank_centered = false
}

var real_real_rank = real(real_rank)
if real_real_rank < 0 or real_real_rank > getLength(global.rank_colors)-1
    real_real_rank = getLength(global.rank_colors)-1

draw_set_color(global.rank_colors[real_real_rank])
draw_circle(draw_x+xoff,draw_y+yoff,global.rank_radius*scale,false)
draw_set_color(c_white)
draw_circle(draw_x+xoff,draw_y+yoff,global.rank_radius*scale,true)

rank = string(rank)
draw_text_ext_transformed(draw_x+xoff,draw_y+toff,string_hash_to_newline(rank),0,300,scale,scale,0)
