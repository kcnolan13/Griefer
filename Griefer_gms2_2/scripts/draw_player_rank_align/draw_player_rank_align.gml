/// @description draw_player_rank_align(rank,x,y,scale,halign,valign)
/// @function draw_player_rank_align
/// @param rank
/// @param x
/// @param y
/// @param scale
/// @param halign
/// @param valign
var rank = argument0
var draw_x = argument1
var draw_y = argument2
var scale = argument3
var halign = argument4
var valign = argument5

xpos = draw_x
ypos = draw_y

if halign = fa_center
{
    xpos -= global.rank_radius*scale
}

if halign = fa_right
{
    xpos -= global.rank_radius*scale
}

if valign = fa_middle
{
    ypos -= global.rank_radius*scale
}

if valign = fa_bottom
{
    ypos -= global.rank_radius*scale
}

draw_player_rank(rank,xpos,ypos,scale)