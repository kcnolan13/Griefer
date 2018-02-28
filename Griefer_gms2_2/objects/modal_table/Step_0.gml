/// @description behavior
event_inherited()

if not instance_exists(id)
    exit

if varRead("force_page")
{
    force_page = varRead("force_page")
    varWrite("force_page",false)
    with modal_button
    {
        if is_page
        {
            active = false
            if page_offset != GARBAGE
            {
                var pg = max(3,other.force_page)+page_offset
                page_flag = pg
                text = string(pg)   
            }
        }
    }
}

if varRead("force_row")
{
    force_row = varRead("force_row")
    printf("::: row forced to: "+string(force_row))
    
    varWrite("force_row",false)
    s_index = row_height*force_row
    s_index = constrict(s_index,0,s_index_max)
}

if varRead("create_pages") and popped_in and rows_used > 0
{
    varWrite("create_pages",false)
    var pg_font = fnt_hud
    var pg_crop_pad = 14
    var pg_spacer = 5
    var pgs_string = ""
    var num_pgs = getLength(page_flags)
    for (var i=0; i<getLength(page_flags); i++)
    {
        pgs_string += page_flag_2str(page_flags[i])
    }
    draw_set_font(pg_font)
    
    var xadder = -1/2*(string_width(string_hash_to_newline(pgs_string))+(2*pg_crop_pad+pg_spacer)*(num_pgs-1))
    var bdelay = 3
    var binc = 3
    
    var prev_width = 0
    
    for (var i=0; i<getLength(pages); i++)
    {
        if not instance_exists(pages[i]) or pages[i] = NO_HANDLE
        {
            page_width = 64
            page_height = 32
            ID = instance_create(x+xadder,top-page_height,bn_typical)
            ID.font = pg_font
            ID.active = true
            pages[i] = ID
            ID.is_page = true
            ID.height = page_height
            ID.auto_crop = true
            ID.crop_pad = pg_crop_pad
            ID.page_offset = page_offsets[i]
            ID.page_flag = page_flags[i]
            ID.page_orderby = "stats."+"true_skill"
            ID.submit_action = scr_bn_page_leaderboards
            ID.birth_delay = bdelay
            ID.color = c_black
            ID.active_color = highlight_color
            bdelay += binc
            
            ID.text = page_flag_2str(page_flags[i])
            
            //this must be done in order
            with (ID) 
            {
                other.temp_width = compute_auto_crop()
            }
            
            if i < getLength(pages)-1
            {
                xadder += ID.width/2+(string_width(string_hash_to_newline(page_flag_2str(page_flags[i+1])))+2*pg_crop_pad)/2+pg_spacer
            }
            
        } 
        else if instance_exists(pages[i]) and fade_out {
            //fade out pages when the grid dies
            pages[i].fade_out = true
            pages[i] = NO_HANDLE
        }
    }
}

if hovrow > -1
{
    hovrow_counter ++
    if hovrow_counter > hovrow_delay
        show_hovrow = true
    else show_hovrow = false
}
else show_hovrow = false

if cols < 0 or rows < 0 exit

if not first_sort and ds_exists(grid,ds_type_grid)
{
    var pname = ds_grid_get(grid,0,ds_grid_height(grid)-1)
    
    //default sort by xp when ready
    if is_string(pname) and string_length(pname) > 0
    {
        first_sort = true
        ds_grid_sort(grid,2,false)
    }
}

if grid_header = NO_HANDLE
{
    grid_header = ds_grid_create(cols,1)
    bn_top = instance_create(left+width+32+10,top+32,bn_tbottom)
    bn_top.parent_table = id
    bn_bottom = instance_create(left+width+32+10,top+height+6,bn_tbottom)
    bn_bottom.parent_table = id
    bn_bottom.img_index = 1
    bn_bottom.is_top = false
    
    //NOW WOULD BE THE TIME TO OBTAIN COLUMN NAMES
    ds_grid_add(grid_header,0,0,"username")
    ds_grid_add(grid_header,1,0,"rank")
    ds_grid_add(grid_header,2,0,"true_skill")
    ds_grid_add(grid_header,3,0,"xp")
    ds_grid_add(grid_header,4,0,"ppl")
    ds_grid_add(grid_header,5,0,"kdr")
    ds_grid_add(grid_header,6,0,"wl")
    ds_grid_add(grid_header,7,0,"time")
    ds_grid_add(grid_header,8,0,"kills")
    //ds_grid_add(grid_header,8,0,"deaths")
    ds_grid_add(grid_header,9,0,"assists")
    ds_grid_add(grid_header,10,0,"wins")
    //ds_grid_add(grid_header,11,0,"losses")
    ds_grid_add(grid_header,11,0,"kill_streak")
    ds_grid_add(grid_header,12,0,"win_streak")
    ds_grid_add(grid_header,13,0,"global_rank")
    ds_grid_add(grid_header,14,0,"helmet0")
    ds_grid_add(grid_header,15,0,"hat0")
}

//CREATE THE GRID WHEN YOU HAVE THE TECHNOLOGY!!
if grid = NO_HANDLE and varRead("create_grid")
{
    modal_aligns()
    
    grid = ds_grid_create(cols,rows) //+1 for the index to the left of columns
    
    s_index_max = max(1,(rows+2)*row_height - height)
    
    cols -= extra_stats
    
    //create ascending array
    for (var i=0; i<ds_grid_width(grid); i++)
    {
        ascending[i] = false
    }
    
}

if global.using_gamepad 
{
    if gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check_pressed(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_press)
    }
    
    if gamepad_button_check_released(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check_released(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_release)
    }
    
    if gamepad_button_check(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_button)
    }
}

if clicked
    clicked --

