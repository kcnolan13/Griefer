amount = argument0
id_2way_hor = -1

var xi_actual = x
var yi_actual = y

repeat (abs(hsp))
{
    if object_index = player
        res = 1
    else
        res = 4.5
        
    var xi = x
    var yi = y
    
    if scr_pixel_hor_sub(res) = false
    {
        hsp = 0 
        break
    }
    
    var xtra = 1
    if point_distance(xi_actual,yi_actual,x,y) > abs(hsp)+xtra
    {
        var movdir = point_direction(xi_actual,yi_actual,x,y)
        x = xi_actual+trigx(abs(hsp)+xtra,movdir)
        y = yi_actual+trigy(abs(hsp)+xtra,movdir)
        //printf("::: clipped x,y --> movdir = "+string(movdir))
        break
    }
}

//walk down slanted surfaces smoothly
{
    var yinc = 0
    var ymax = 80
    if was_standing and not jumping and not collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+sthresh,block,true,false) and not collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+sthresh,block2_top,true,false)
    {
        //printf("::: was standing")
        while (yinc < ymax)
        {
            yinc ++
            if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+yinc,block,true,false) or collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+yinc,block2_top,true,false)
            {
                yinc -= 1
                //printf("::: incremented y by "+string(yinc))
                y += yinc
                break
            }
        }
    }
}
