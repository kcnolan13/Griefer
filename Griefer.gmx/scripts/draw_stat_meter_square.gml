///draw_stat_meter(x,y,value,description,outer_color,inner_color,scale,backing_percent_full,actual_percent_full)
var drawx = argument0
var drawy = argument1
var val = string(argument2)
var desc = string(argument3)
var col_out = argument4
var col_in = argument5
var scale = argument6
var backing_percent_full = min(1,argument7)
var actual_percent_full = min(1,argument8)

var rad = radius*scale

var rim_width = 4*scale
var bar_width = 8*scale
var rim_gap = 4*scale

var l = drawx-rad
var r = drawx+rad
var t = drawy-rad
var b = drawy+rad
var w = r - l
var h = b - t

var val_yoff = -12*scale
var val_scale = 1*scale
var desc_yoff = 12*scale
var desc_scale = 0.5*scale

/*var meter_fullsides = (actual_percent_full*4) div 1
var meter_lastsidefrac = (actual_percent_full*4) mod 4
var backing_fullsides = (backing_percent_full*4) div 1
var backing_lastsidefrac = (backing_percent_full*4) mod 4

printf(":::backing_lastsidefrac = "+string(backing_lastsidefrac))
printf(":::backing_fullsides = "+string(backing_fullsides))*/

//draw the outer rim
draw_set_color(col_out)
for (var i=0; i<rim_width; i += 0.5)
{
    draw_rectangle(l+i,t+i,r-i,b-i,true)
}
/*
x_adders = 0 y_adders = 0
x_adders[0] = l y_adders[0] = t
x_adders[1] = w y_adders[1] = 0
x_adders[2] = 0 y_adders[2] = h
x_adders[3] = -w y_adders[3] = 0
x_adders[4] = 0 y_adders[4] = -h

curr_x = x_adders[0]
curr_y = y_adders[0]

l = drawx-rad+rim_gap
r = drawx+rad-rim_gap
t = drawy-rad+rim_gap
b = drawy+rad-rim_gap
w = r - l
h = b - t*/

//draw the outer rim
var current_alpha = draw_get_alpha()
draw_set_alpha(current_alpha/5)
draw_set_color(col_in)
for (var i=0; i<bar_width; i += 0.5)
{
    var off = (rim_width+rim_gap+i)
    draw_rectangle(l+off,t+off,r-off,b-off,true)
}
draw_set_alpha(current_alpha)

/*for (var i=1; i<5; i++)
{
    var next_x = curr_x+x_adders[i]
    var next_y = curr_y+y_adders[i]
    
    if x_adders[i]
        x_adders[i] -= sign(x_adders[i])*bar_width/2

    if y_adders[i]
        y_adders[i] -= sign(y_adders[i])*bar_width/2    
    
    //draw backing
    var current_alpha = draw_get_alpha()
    draw_set_alpha(current_alpha/5)
    draw_set_color(col_in)
    var do_break = false
    
    if i <= backing_fullsides
    {
        draw_line_width(curr_x,curr_y,next_x,next_y,rim_width)
    }
    else
    {
        draw_line_width(curr_x,curr_y,lerp(curr_x,next_x,backing_lastsidefrac),lerp(curr_y,next_y,backing_lastsidefrac),rim_width)
        do_break = true
    }
    draw_set_alpha(current_alpha)
    draw_set_color(col_in)
    
    //draw filled bar
    if i <= meter_fullsides
    {
        draw_line_width(curr_x,curr_y,next_x,next_y,bar_width)
        do_break = false
    }
    else
    {
        draw_line_width(curr_x,curr_y,lerp(curr_x,next_x,meter_lastsidefrac),lerp(curr_y,next_y,meter_lastsidefrac),bar_width)
        do_break = true
    }
    curr_x = next_x
    curr_y = next_y
    
    if do_break
        break
}*/

//draw the value
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_color(c_black)
draw_set_font(fnt_meter)
draw_text_transformed(drawx,drawy+val_yoff,val,val_scale,val_scale,0)

//draw the description
draw_text_transformed(drawx,drawy+desc_yoff,desc,desc_scale,desc_scale,0)
