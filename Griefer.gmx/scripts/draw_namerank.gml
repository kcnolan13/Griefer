///draw_namerank(name, rank, x, y, scale, color)
var name = argument0
var rank = argument1
var draw_x = argument2
var draw_y = argument3
var scale = argument4
var color = argument5

//name = capwords(name)

draw_player_rank(rank, draw_x, draw_y, scale)

draw_set_color(color)
draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)

draw_flash_compensate()

draw_text_ext_transformed(draw_x+5*scale+global.rank_radius*scale*2,draw_y+scale*string_height("blah")/8,name,0,600,scale,scale,0)
