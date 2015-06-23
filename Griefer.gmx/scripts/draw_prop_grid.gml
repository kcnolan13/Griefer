///draw_armory_grid(list, x_start, y_start, side_length, padding, alpha)
var list = argument0
var xs = argument1
var ys = argument2
var sl = argument3
var padding = argument4
var alpha = argument5

popup_drawn = false

if not ds_exists(list,ds_type_list)
{
    printf("ERROR: cannot draw armory grid. bad list handle.")
    return false
}

//draw the ones in the grid
index = 1
for (var i=0; i<NUM_PROPS-1; i++)
{
    bpart = list[| index]
    
    //get clicked, son
    if instance_exists(bpart) and bpart.object_index = bpart_generic
    with bpart
    {
        if instance_place(x,y,cursor) and click_pressed() and not swap_counter
        {
            audio_play_sound(snd_click_armory,2,false)
            swap_counter = 5
            with other.id //other.id is actually net_manager
            {
                part1 = list[| 0]
                swap_counter = 5
                
                if part1.disabled
                {
                    //reenable and swap to this one
                    list[| 0] = list[| index]
                    ds_list_delete(list,index)
                    var ind = net_man_armory_list_index(list)
                    if ind > -1
                        armory_disabled[i] = false
                    sync_my_doll()
                } else {
                    //simply swap the current item out with this one
                    temp = list[| 0]
                    list[| 0] = list[| index]
                    list[| index] = temp
                    sync_my_doll()       
                }
            }
        }
        else if instance_place(x,y,cursor) and rightclick_pressed() and not swap_counter
        {
            audio_play_sound(snd_pickup2,2,false)
            if not contemplating_scrap
            {
                swap_counter = 5
                contemplating_scrap = true
            }
            else
            {
                //SCRAP THE GEAR
                with other.id
                {
                    ds_list_delete(list, index)
                    if DEBUG
                    {
                        printf("DS List of size "+ds_list_size(list)+" Now Contains:")
                        for (var q=0; q<ds_list_size(list); q++)
                        {
                            printf(list[| q])
                        }
                    }
                    sync_my_doll()
                }
                instance_destroy()  
            }
        }
    }
    
    if instance_exists(bpart) and index < ds_list_size(list)
    {
        if (i%2=0)
            bpart.x = xs+((i/2)+1)*(sl+padding)
        else
            bpart.x = xs-((i/2)+1)*(sl+padding)+(sl+padding)/2
            
        bpart.y = ys//+i*(sl+padding)
        draw_bpart_slot_complete(bpart, bpart.x, bpart.y, alpha)
        //printf("drew prop @ "+bpart.x+", "+bpart.y)
        with bpart
        {
            if instance_place(x,y,cursor) and not other.id.popup_drawn
            {
                hovering ++
                
                if hovering = hover_delay
                    audio_play_sound(snd_scroll3,2,false)
                
                if hovering > hover_delay
                {
                    popup_alpha = lerp(popup_alpha,1,popup_lerp)
                    if not contemplating_scrap
                    {   
                        draw_popup_with_drawer(x,y,name,global.name_rarity[rarity]+" "+lookup_limb_type_name(limb_type),source,compute_body_text_override(id),color,1,icon)
                    } else {
                        draw_bpart_slot_disabled(x, y, 1)
                        draw_popup_with_drawer(x, y, "Scrap Gear", "", "", "Right-Click To Delete Forever", c_red,1,icon)
                    }
                }
            } else hovering = 0
        }
    }
    else
    {
        if (i%2=0)
        {
            xdraw = xs+((i/2)+1)*(sl+padding)
        }
        else
        {
            xdraw = xs-((i/2)+1)*(sl+padding)+(sl+padding)/2
            //printf("drawing empty in neg direction @ "+xdraw)
        }
            
        draw_bpart_slot_empty(xdraw,ys,1)
    }
    index++
}

draw_set_alpha(1)
