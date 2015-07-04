///draw_stat_history_chart(x,y,scale,col_pos,col_neg,y_threshold,history_string,record_count)
var drawx = argument0
var drawy = argument1
var scale = argument2
var col_pos = argument3
var col_neg = argument4
var y_thresh = argument5
var hist = argument6
var recnum = argument7

var col_bg = c_dkgray
var col_axes = c_ltgray
var point_rad = 5*scale
var drop_color = c_gray
var drop_color_highlighted = c_ltgray

//get bg rect dims
var left = x
var top = y

if halign = fa_center
    left -= width*scale/2

if valign = fa_center or valign = fa_middle
    top -= width*scale/2
    
var right = left+width*scale
var bottom = top+height*scale

var h = max(1,abs(bottom - top))
var w = max(1,abs(right - left))

//draw background rect
draw_set_color(col_bg)
draw_rectangle(left,top,right,bottom,false)

//draw title
var title_height = h/5

//history label box dims
var lab_width = w/3
var lab_height = title_height*2/3
var lab_spacer = abs(title_height-lab_height)
var lab_left = left+lab_spacer
var lab_right = left+lab_spacer+lab_width
var lab_top = top+title_height/2-lab_height/2
var lab_bottom = top+title_height/2+lab_height/2
var lab_xmid = lab_left+lab_width/2
var lab_ymid = lab_top+lab_height/2

//record count box dims
var rc_width = w/3
var rc_height = title_height*2/3
var rc_spacer = abs(title_height-rc_height)
var rc_left = right-rc_spacer-rc_width
var rc_right = right-rc_spacer
var rctop = top+title_height/2-rc_height/2
var rc_bottom = top+title_height/2+rc_height/2
var rc_xmid = rc_left+rc_width/2
var rc_ymid = rc_top+rc_height/2

//graph dims
var graph_spacer = 5*scale
var graph_xextra = 32*scale
var graph_left = left+graph_spacer+graph_xextra
var graph_right = right-graph_spacer
var graph_top = top+title_height+graph_spacer
var graph_bottom = bottom-graph_spacer
var graph_width = max(1,abs(graph_right - graph_left))
var graph_height = max(1,abs(graph_bottom - graph_top))
var graph_ymid = graph_top + graph_height/2

//parse graph data
if recalculate
{
    xs[0] = 0
    ys[0] = 0
    draw_ys[0] = 0
    
    var i = 0
    while (string_pos(",",hist))
    {
        var pos = string_pos(",",hist)
        var strval = string_copy(hist,1,pos-1)
        //bash hist's head
        if pos < string_length(hist)
            hist = string_copy(hist,pos+1,string_length(hist)-pos)
        else
            hist = ""
        xs[i] = i
        ys[i] = real(strval)
        printf("::: next histval: "+strval)
        i++
        
        //stop reading in data to the arrays if record count met
        if (i = recnum)
            break
    }
    
    //make y_threshold the 0 mark
    for (var i=0; i<getLength(xs); i++)
    {
        draw_ys[i] -= y_thresh
    }
    
    var ymax = getMax(ys)
    var ymin = getMin(ys)
    var prescaler = abs(max(ymax,ymin))/(grid_height/2)
    
    //normalize data to fit graph height
    for (var i=0; i<getLength(draw_ys); i++)
    {
        draw_ys[i] = prescaler*draw_ys[i]
    }
}

//draw graph axes
draw_set_color(col_axes)
draw_rectangle(graph_left,graph_top,graph_right,graph_bottom,true)

//center line
draw_line(graph_left,graph_ymid,graph_right,graph_ymid)

//major y divs
var pointnum = getLength(draw_ys)
var divnum = max(pointnum,5)
var divw = grid_width/(divnum-1)

for (var i=0; i<divnum; i++)
{
    draw_line(graph_left+i*divw,graph_top,graph_left+i*divw,graph_bottom)
}

//draw points, lines, and data labels
for (var i=0; i<pointnum; i++)
{
    var dat_color = col_neg
    if draw_ys[i] >= 0 dat_color = col_neg
    
    draw_set_color(dat_color)
    
    var point_drawx = graph_left+i*divw
    var point_drawy = graph_ymid+draw_ys[i]
    
    var point_original_value = ys[i]
    
    //draw line between point and next point
    if i < pointnum-1
    {
        var next_point_drawx = graph_left+(i+1)*divw
        var next_point_drawy = graph_ymid+draw_ys[i+1]
        
        var final_point_drawx = 0
        var final_point_drawy = 0
        var crossed = false
        
        if sign(draw_ys[i+1]) != sign(draw_ys[i])
        {
            //line crosses horizontal axis -- split into two
            crossed = true
            final_point_drawx = next_point_drawx
            final_point_drawy = next_point_drawy
            
            //next point goes to the crossing at 0
            next_point_drawy = 0

            var dy = final_point_drawy - point_drawy
            var dx = divw
            var b = point_drawy
            
            next_point_drawx = -1*dx/dy*b
        }
        
        //draw the lines as needed
        var alph = draw_get_alpha()
        draw_set_alpha(alph/3)
            draw_line(point_drawx,point_drawy,next_point_drawx,next_point_drawy)
            
            if crossed
            {
                if draw_get_colour() = col_neg
                    draw_set_colour(col_pos)
                else draw_set_color(col_neg)
                draw_line(next_point_drawx,next_point_drawy,final_point_drawx,final_point_drawy)
            }
        draw_set_alpha(alph)
    }
    
    //draw the current point
    draw_set_color(dat_color)
    draw_circle(point_drawx,point_drawy,point_rad,false)
    
    //draw the data label
    draw_set_color(c_white)
    draw_set_font(fnt_hud)
    draw_set_halign(fa_center)
    draw_set_valign(fa_top)
    draw_text_transformed(point_drawx,gri_bottom+5*scale,string(point_original_value),scale,scale,0)
}

//draw +
draw_set_color(col_pos)
draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_transformed(grid_left+grid_xextra/2+grid_spacer,grid_ymid-grid_xextra/2,"+",scale,scale,0)

//draw -
draw_set_color(col_neg)
draw_text_transformed(grid_left+grid_xextra/2+grid_spacer,grid_ymid+grid_xextra/2,"-",scale,scale,0)

var num_labs = getLength(history_labels)
var num_rcs = getLength(records)

//label dropdown dims
var lab_drop_left = lab_left
var lab_drop_top = lab_top
var lab_drop_right = lab_right
var lab_drop_bottom = lab_top+num_labs*lab_height

//recnum dropdown dims
var rc_drop_left = rc_left
var rc_drop_top = rc_top
var rc_drop_right = rc_right
var rc_drop_bottom = rc_bottom+num_rcs*rc_height

//draw stat label dropdown
if rect_highlighted(lab_left,lab_top,lab_right,lab_bottom)
    lab_highlighted = true
if rect_highlighted(rc_left,rc_top,rc_right,rc_bottom)
    rc_highlighted = true
    
draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
    
if lab_highlighted
{
    if rect_highlighted(lab_drop_left,lab_drop_top,lab_drop_right,lab_drop_bottom)
    {
        //draw the dropdown bg
        draw_set_color(drop_color)
        draw_rectangle(lab_drop_left,lab_drop_top,lab_drop_right,lab_drop_bottom,false)
        //draw each of the options and interact
        for (var i=0; i<num_labs; i++)
        {
            //get dims
            var drop_left = lab_drop_left
            var drop_right = lab_drop_right
            var drop_top = lab_drop_top+lab_height*i
            var drop_bottom = drop_top+lab_height
            //interact
            if rect_highlighted(drop_left,drop_top,drop_right,drop_bottom)
            {
                if mouse_check_button_pressed(mb_left) or gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP])
                {
                    history_string = histories[i]
                    history_label = history_labels[i]
                    y_threshold = y_thresholds[i]
                    lab_highlighted = false
                    audio(snd_click,1)
                }
                
                //draw backing
                draw_set_color(drop_color_highlighted)
                draw_rectangle(drop_left,drop_top,drop_right,drop_bottom,false)
            }
        
            //draw text
            draw_set_color(c_white)
            draw_text_transformed(lab_xmid,drop_top+lab_height/2,history_labels[i],scale,scale,0)
        }
    }
    else lab_highlighted = false
}
else
{
    //draw simple text
    draw_set_color(c_white)
    draw_text_transformed(lab_xmid,lab_ymid,history_label,scale,scale,0)
}

if rc_highlighted
{
    if rect_highlighted(rc_drop_left,rc_drop_top,rc_drop_right,rc_drop_bottom)
    {
        //draw the dropdown bg
        draw_set_color(drop_color)
        draw_rectangle(lab_drop_left,lab_drop_top,lab_drop_right,lab_drop_bottom,false)
        //draw each of the options and interact
        for (var i=0; i<num_rcs; i++)
        {
            //get dims
            var drop_left = rc_drop_left
            var drop_right = rc_drop_right
            var drop_top = rc_drop_top+rc_height*i
            var drop_bottom = drop_top+rc_height
            //interact
            if rect_highlighted(drop_left,drop_top,drop_right,drop_bottom)
            {
                if mouse_check_button_pressed(mb_left) or gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP])
                {
                    record_count = records[i]
                    rc_highlighted = false
                    audio(snd_click,1)
                }
                
                //draw backing
                draw_set_color(drop_color_highlighted)
                draw_rectangle(drop_left,drop_top,drop_right,drop_bottom,false)
            }
        
            //draw text
            draw_set_color(c_white)
            draw_text_transformed(rc_xmid,drop_top+rc_height/2,"Last "+string(records[i])+" Games",scale,scale,0)
        }
    }
    else rc_highlighted = false
}
else
{
    //draw simple text
    draw_set_color(c_white)
    draw_text_transformed(lab_xmid,lab_ymid,"Last "+string(recnum)+" Games",scale,scale,0)
}
