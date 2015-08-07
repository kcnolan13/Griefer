///draw_stat_meter(x,y,value,description,outer_color,inner_color,scale,backing_percent_full,actual_percent_full)
var drawx = argument0
var drawy = argument1
var val = string(argument2)
var desc = string(argument3)
var col_out = argument4
var col_in = argument5
var scale = argument6
var backing_percent_full = argument7
var actual_percent_full = argument8

radius = 64*scale
var rim_width = 4*scale
var bar_width = 18*scale
var rim_gap = 4*scale

var val_yoff = -12*scale
var val_scale = 1*scale
var desc_yoff = 12*scale
var desc_scale = 0.5*scale

var ang_i = 90
var ang_f = ang_i-actual_percent_full*360
var ang_dif = abs(ang_f mod 360 - ang_i mod 360)
var ang_res = 8
var ang_steps = ceil(ang_dif/ang_res)
var ang_working = ang_i

//calculate points for the inner bar
{
    actual_meter_xs[0] = 0
    actual_meter_ys[0] = 0
    
    
    for (var i=0; i<=ang_steps; i++)
    {
        ang_working = ang_i - ang_res*i
        actual_meter_xs[i] = drawx+trigx(radius-rim_gap-bar_width/2,ang_working)
        actual_meter_ys[i] = drawy+trigy(radius-rim_gap-bar_width/2,ang_working)
    }
}

ang_i = 90
ang_f = ang_i-backing_percent_full*360
ang_dif = abs(ang_f mod 360 - ang_i mod 360)
ang_res = 10
ang_steps = ang_dif/ang_res
ang_working = ang_i

//calculate points for the inner bar backing
{
    
    backing_meter_xs[0] = 0
    backing_meter_ys[0] = 0
    
    for (var i=0; i<=ang_steps; i++)
    {
        ang_working = ang_i - ang_res*i
        backing_meter_xs[i] = drawx+trigx(radius-rim_gap-bar_width/2,ang_working)
        backing_meter_ys[i] = drawy+trigy(radius-rim_gap-bar_width/2,ang_working)
    }

}

//draw the outer rim
draw_set_color(col_out)
for (var i=0; i<rim_width; i += 0.5)
{
    draw_circle(drawx,drawy,radius+i,true)
}

if getLength(backing_meter_xs) < 1 or getLength(backing_meter_ys) < 1 or getLength(actual_meter_xs) < 1 or getLength(actual_meter_ys) < 1
{
    printf("ERROR: draw_stat_meter has meter_xs of no length")
    return false
}

//draw the inner bar

//draw backing
var current_alpha = draw_get_alpha()
draw_set_alpha(current_alpha/5)
{
    draw_set_color(col_in)
    var len = getLength(backing_meter_xs)-1
    for (var i=0; i<len; i++)
    {
        draw_line_width(backing_meter_xs[i],backing_meter_ys[i],backing_meter_xs[i+1],backing_meter_ys[i+1],bar_width/2)
        if i < len-1
            draw_line_width(backing_meter_xs[i],backing_meter_ys[i],backing_meter_xs[i+2],backing_meter_ys[i+2],bar_width/2)
    
    }
}
draw_set_alpha(current_alpha)

//draw filled bar
{
    //draw_set_blend_mode(bm_add)
    draw_set_color(col_in)
    var len = getLength(actual_meter_xs)-1
    for (var i=0; i<len; i++)
    {
        draw_line_width(actual_meter_xs[i],actual_meter_ys[i],actual_meter_xs[i+1],actual_meter_ys[i+1],bar_width)
        if i < len-1
            draw_line_width(actual_meter_xs[i],actual_meter_ys[i],actual_meter_xs[i+2],actual_meter_ys[i+2],bar_width)
        
    }
    //draw_set_blend_mode(bm_normal)
}

//draw the value
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_color(c_black)
draw_set_font(fnt_meter)
draw_text_transformed(drawx,drawy+val_yoff,val,val_scale,val_scale,0)

//draw the description
draw_text_transformed(drawx,drawy+desc_yoff,desc,desc_scale,desc_scale,0)
