///update_scrollable_accolade_grid()
if not instance_exists(accolade_generic) return false

num_accs = instance_number(accolade_generic)

//recalculate sindex_min and sindex_max
sep = acc_width

//bail when not enough accolades to scroll
if sindex_max < grid_width/2
    return false
    
accolade_xmin = grid_left
accolade_xmax = grid_right

//loop accolades around when they exceed the bounds
with accolade_generic
{
    /*if x > other.grid_xmid+other.sindex_max
    {
        x = other.grid_left-other.sep
        xtarget = x
    }
    else if x < other.grid_left-other.sep
    {
        x = other.grid_xmid+other.sindex_max
        xtarget = x
    }*/
        
    //set alpha down sometimes
    if x < other.grid_left+width/2-5
    {
        var xdif = abs( (other.grid_left+width/2) - x )
        alpha_scroll_scaler = lerp(1,0,xdif/(width))
    } else if x > other.grid_right-width/2
    {
        var xdif = abs( x - (other.grid_right-width/2) )
        alpha_scroll_scaler = lerp(1,0,xdif/(width))
    } else alpha_scroll_scaler = 1
}
