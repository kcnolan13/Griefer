///create_accolade_grid(left,top,right,bottom,halign,valign,grid_pad,col_total)
var l = argument0
var t = argument1
var r = argument2
var b = argument3
var halign = argument4
var valign = argument5
var pad = argument6
var col_total = argument7

var w = abs(r - l)
var h = abs(b - t)
var xmid = l+w/2
var ymid = t+h/2

var dbug = true

{
    if dbug printf("::: creating accolade grid")
    
    l += pad
    r -= pad
    t += pad
    b -= pad
    
    w = abs(r - l)
    h = abs(b - t)
    xmid = l+w/2
    ymid = t+h/2
    
    if dbug printf("::: grid bounds: "+string(l)+", "+string(t)+", "+string(r)+", "+string(b))
    if dbug printf("::: w = "+string(w)+", h="+string(h))
    
    //no division by zero please
    if w < 1 w = 1
    if h < 1 h = 1
    
    var hsep = accolade_manager.grid_hsep
    var vsep = accolade_manager.grid_vsep
    var acc_width = accolade_manager.acc_width
    
    if col_total != COL_TOTAL and col_total != COL_MATCH_TOTAL and col_total != COL_BOT_TOTAL
    {
        printf("ERROR: bad col_total passed to create_accolade_grid: "+string(col_total))
        return false
    }
    
    var grid = accolade_manager.grid
    if not ds_exists(grid,ds_type_grid)
    {
        printf("ERROR: create_accolade_grid cannot find grid")
        return false
    }
    
    var len = accolade_manager.num_accolades
    var lenh = ds_grid_height(grid)
    if len != lenh
    {
        printf(":::WARNING: create_accolade_grid dimension disagreement len = "+string(len)+", lenh = "+string(lenh))
        //return false
    }
    
    var num_2create = 0
    
    //figure out how many accolades will be created
    for (var i=0; i<min(len,accolade_manager.evil_row_num); i++)
    {
        if acc_row_data(i,col_total) > 0
            num_2create ++
    }
    
    if dbug printf("::: num_2create = "+string(num_2create))
    
    //figure out how many rows there need to be
    var num_rows = ceil((acc_width+hsep)*num_2create / w)
    var num_per_row = floor(w/(acc_width+hsep))
    var row_height = acc_width/2+12
    var row1_y = t
    
    if dbug printf("::: num_rows="+string(num_rows)+", num_per_row="+string(num_per_row))
    
    //compute y for first row
    /*if valign = fa_center
    {
        row1_y = ymid-(num_rows-1)/2*row_height
    }*/
    
    //create all the accolades
    var num_created = 0
    var row_index = 0
    var row_num = 0
    var row_xst = l
    var row_yst = row1_y
    
    var bdelay = 15
    var birthmas = 2
    
    for (var i=0; i<min(len,accolade_manager.evil_row_num); i++)
    {   
        if acc_row_data(i,col_total) > 0
        {
            if row_index = 0
            {
                if num_created > 1
                {
                    //compute offsets for new row
                    row_num++
                    row_yst += row_height
                    row_xst = l
                }
                if halign = fa_center and (num_2create - num_created) < num_per_row
                {
                    //centering needed
                    row_xst = xmid-(num_2create-num_created)*(acc_width+hsep)/2
                }
            }
            
            var xspawn = row_xst+row_index*(acc_width+hsep)
            var yspawn = row_yst+row_height*row_num
            
            datAcc = create_accolade(xspawn,yspawn,acc_row_data(i,COL_NAME),col_total)
            {
                datAcc.birth_delay = bdelay
                bdelay += birthmas
            }
            
            if dbug printf("::: CREATED accolade "+string(datAcc.text)+" at "+string(datAcc.x)+", "+string(datAcc.y))
            
            num_created ++
            
            row_index ++
            //only rollover to the next row in match --> the stat screen now scrolls and whatnot
            if row_index >= num_per_row and in_match()
                row_index = 0
        }
    }
    
    //sindex = 0 is grid_xmid! remember that...
    if instance_exists(accolade_generic)
    {
        accolade_manager.sindex_max = instance_find(accolade_generic,instance_number(accolade_generic)-1).x-1 - accolade_manager.grid_xmid
        accolade_manager.sindex_min = -1*sindex_max
    }
    
}
