/// @description draw the background

var col1 = web_hsv(0,0,0)
var col2 = web_hsv(0,0,0)

draw_set_alpha(1)
//draw_background_tiled(bg_dark,0,0)
//draw_set_alpha(0.85)
draw_rectangle_colour(0,0,room_width,room_height,col1,col1,col2,col2,false)

