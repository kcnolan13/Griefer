///draw_stat_meter(x,y,value,description,outer_color,inner_color,scale,percent_full)
var drawx = argument0
var drawy = argument1
var val = string(argument2)
var desc = string(argument3)
var col_out = argument4
var col_in = argument5
var scale = argument6
var percent_full = argument7

radius = 52*scale
var rim_width = 2*scale
var bar_width = 12*scale
var rim_gap = 3*scale

var val_yoff = -12*scale
var val_scale = 1*scale
var desc_yoff = 5*scale
var desc_scale = 0.5*scale

var ang_i = 90
var ang_f = ang_i-percent_full*360
var ang_dif = abs(ang_f mod 360 - ang_i mod 360)
var ang_res = 1
var ang_steps = ang_dif/ang_res
var ang_working = ang_i

//draw the outer rim
draw_set_color(col_out)
for (var i=0; i<rim_width; i += 0.5)
{
    draw_circle(drawx,drawy,radius+i,true)
}

meter_xs[0] = 0
meter_ys[0] = 0

//calculate points for the inner bar
for (var i=0; i<ang_steps; i++)
{
    ang_working = ang_i - ang_res*i
    meter_xs[i] = drawx+trigx(radius-rim_gap-bar_width/2,ang_working)
    meter_ys[i] = drawy+trigy(radius-rim_gap-bar_width/2,ang_working)
}

if getLength(meter_xs) < 1 or getLength(meter_ys) < 1
{
    printf("ERROR: draw_stat_meter has meter_xs of no length")
    return false
}

//draw the inner bar

//draw backing
var current_alpha = draw_get_alpha()
draw_set_alpha(current_alpha/3)
{
    draw_set_color(col_in)
    for (var i=0; i<getLength(meter_xs)-1; i++)
    {
        draw_line_width(meter_xs[i],meter_ys[i],meter_xs[i+1],meter_ys[i+1],bar_width/2)
    }
}
draw_set_alpha(current_alpha)

//draw filled bar
{
    draw_set_color(col_in)
    for (var i=0; i<getLength(meter_xs)-1; i++)
    {
        draw_line_width(meter_xs[i],meter_ys[i],meter_xs[i+1],meter_ys[i+1],bar_width)
    }
}

//draw the value
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_color(c_black)
draw_set_font(fnt_meter)
draw_text_transformed(drawx,drawy+val_yoff,val,val_scale,val_scale,0)

//draw the description
draw_text_transformed(drawx,drawy+desc_yoff,desc,desc_scale,desc_scale,0)
