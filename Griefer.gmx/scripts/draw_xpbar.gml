///draw_xpbar(x,y,fraction_full,fraction_really_full,scale,halign,valign,text_color,unused)

//default alignment is fa_left, fa_top

var dx = argument0
var dy = argument1
var fraction = argument2
var fraction_real = argument3
var scale = argument4
var halign = argument5
var valign = argument6
var text_color = argument7
var unused = argument8

var rank_scaler = 1.5
var rank_width = 40*rank_scaler
var rank_spacer = rank_width/2-8
var total_width = scale*(rank_width+rank_spacer+XPBAR_WIDTH)
var total_height = scale*max(rank_width/2,XPBAR_HEIGHT)

rank_width = rank_width*scale
rank_spacer = rank_spacer*scale

var left = dx 
var top = dy

if halign = fa_center
    left = dx-total_width/2
else if halign = fa_right
    left = dx-total_width
    
if valign = fa_center
    top = dy-total_height/2
else if valign = fa_bottom
    top = dy-total_height

var bar_left = left+rank_width+rank_spacer
var bar_top = top

draw_player_rank(xp_bar.rank,left+rank_width/2,top-rank_width*scale/4,rank_scaler*scale)
//backing
draw_set_color(c_dkgray)
draw_rectangle(bar_left,bar_top,bar_left+XPBAR_WIDTH*scale,top+XPBAR_HEIGHT*scale,false)
//fraction really full
draw_set_color(web_hsv(48,100,100))
draw_rectangle(bar_left,bar_top,bar_left+fraction_real*XPBAR_WIDTH*scale,top+XPBAR_HEIGHT*scale,false)

//fraction full
draw_set_color(c_white)
draw_flash_compensate()
draw_rectangle(bar_left,bar_top,bar_left+fraction*XPBAR_WIDTH*scale,top+XPBAR_HEIGHT*scale,false)

draw_set_color(text_color)
draw_flash_compensate()
draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_text(bar_left+5,top-5+scale,get_rank_name(xp_bar.rank))
draw_set_valign(fa_top)
draw_set_font(fnt_hud)
draw_text(bar_left+5,top+XPBAR_HEIGHT+5*scale,string(floor(xp_bar.xp_earned))+" / "+string(floor(xp_bar.xp_this_rank)))
