///draw_armory_cache(list, x_center, length, padding, alpha)

var list = argument0
var x_center = argument1 //can really just use net_manager's cache_center var... bit whateva
var length = argument2
var padding = argument3
var alpha = argument4

popup_drawn = false
cache_left = cache_center-(cache_slots+1)*(armory_sl+armory_ysep)/2+armory_ysep*3
cache_right = cache_center+cache_slots*(armory_sl+armory_ysep)/2

//printf("cache_left = "+cache_left)
//printf("cache_right = "+cache_right)

draw_set_font(fnt_hud_biggest)
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_set_color(c_white)
draw_set_alpha(1)
draw_text(room_width/2, cache_y-18, "Cache")
draw_set_valign(fa_center)

if not ds_exists(list,ds_type_list)
{
    printf("ERROR: cannot draw armory cache. bad list handle.")
    return false
}

//mouse-based scrolling
//is mouse inside cache interact rectangle?
xoff_prev = cache_xoffset

if collision_rectangle(cache_left-cache_mouse_tol_outside,cache_y, cache_right+cache_mouse_tol_outside,cache_y+armory_sl,cursor,false,true)
{
    //scroll left
    if cursor.x < cache_left+cache_mouse_tol_inside //and ds_list_size(list) > cache_slots
        cache_xoffset += cache_speed
    else if cursor.x > cache_right-cache_mouse_tol_inside //and ds_list_size(list) > cache_slots
        cache_xoffset -= cache_speed
        
}

//values after which slots will loop around
cache_max_left = min(cache_center-(ds_list_size(list)+1)*(armory_sl+armory_ysep)/2+armory_ysep*3,cache_left)
cache_max_right = max(cache_center+(ds_list_size(list))*(armory_sl+armory_ysep)/2, cache_right)
cache_max_length = cache_max_right-cache_max_left
/*draw_set_color(c_lime)
draw_circle(cache_max_left,cache_y,16,false)
draw_circle(cache_max_right,cache_y,16,false)*/

if cache_xoffset < cache_max_left
    cache_xoffset = cache_max_right

if cache_xoffset > cache_max_right
    cache_xoffset = cache_max_left

//pick a natural xoffset to start with, based on how slots there are
natural_xoffset = cache_center-(ds_list_size(list)/2)*(armory_sl+armory_ysep)

//now actually draw the slots
var num_slots = max(cache_slots,ds_list_size(list))
index = -1

//get the real starting position of the list
var cachepos1_x = natural_xoffset
var cachepos1_y = cache_y
var dis_slot_alpha = 1

//figuah out where to ACTUALLY draw da ting
var temp = 0
var to_go = cache_xoffset
while (abs(to_go) > cache_speed and temp <= 9000)
{
    if (temp>5000) and WARNINGS
        printf("WARNING: large loop in draw_armory_cache")
        
    temp += cache_speed
    
    cachepos1_x += cache_speed*sign(to_go)
    //printf("cachepos1_x --> "+cachepos1_x)
    //bring closer to 0
    to_go -= cache_speed*sign(to_go)
    
    //loop around
    if cachepos1_x < cache_max_left
        cachepos1_x += cache_max_length
    else if cachepos1_x > cache_max_right
        cachepos1_x -= cache_max_length
}

//cachepos1_x has now been computed
/*draw_set_color(c_blue)
draw_rectangle(cache_left-cache_mouse_tol_outside,cache_y,cache_left+cache_mouse_tol_inside,cache_y+armory_sl,false)
draw_set_color(c_lime)
draw_rectangle(cache_right-cache_mouse_tol_inside,cache_y,cache_right+cache_mouse_tol_outside,cache_y+armory_sl,false)
draw_set_color(c_red)
draw_rectangle(cachepos1_x,cachepos1_y,cachepos1_x+armory_sl,cachepos1_y+armory_sl,false)
draw_set_color(c_white)*/

dis_slot_x = cachepos1_x
dis_slot_y = cachepos1_y

for (var i=0; i<num_slots; i++)
{
    dis_slot_x += armory_sl+armory_ysep
    if dis_slot_x < cache_max_left
        dis_slot_x += cache_max_length
    else if dis_slot_x > cache_max_right
        dis_slot_x -= cache_max_length
    
    index++
    
    //figure out draw alpha based on cachepos1_x
    var blah = abs(dis_slot_x - cache_center)
    if blah > cache_length/2
        dis_slot_alpha = 0
    else
        dis_slot_alpha = lerp_real(1,0,abs(dis_slot_x-cache_center)/(cache_length/2))
    
    bpart = list[| index]
    
    //INTERACT CODE
    if instance_exists(bpart) and bpart.object_index = bpart_generic
    with bpart
    {
        if instance_place(x,y,cursor) and not popup_exists()  and click_pressed() and not swap_counter and dis_slot_alpha > 0.2 
        {
            swap_counter = 5
            with other.id //other.id is actually net_manager
            {
                            audio(snd_click_armory,1)
                swap_counter = 5
                //add to the list this belongs in if you can
                handle2 = get_bpart_list(bpart.limb_type)
                handle2_index = get_bpart_list_index(bpart.limb_type)
                
                if not ds_exists(handle2,ds_type_list)
                {
                    printf("ERROR: bad DS LIST handle2 in cache item acquire")
                    break
                }
                if (ds_list_size(handle2) < NUM_BPARTS and bpart.limb_type != "prop") or ds_list_size(handle2) < NUM_PROPS
                {
                    //simply add to gear list and delete from this list
                    
                    current_p1 = handle2[| 0]
                    if not instance_exists(current_p1)
                    {
                        printf("ERROR: cannot acquire cache item... handle2[| 0] doesn't exist")
                        return false
                    }
                    
                    if current_p1.disabled
                    {
                        net_manager.armory_disabled[handle2_index] = false
                        handle2[| 0] = bpart
                    } else
                    {
                        ds_list_add(handle2,bpart)
                        //handle2[| 0] = bpart
                    }
                    ds_list_delete(list,index)
                    sync_my_doll()       
                }
                else
                {
                    if WARNINGS
                        printf("WARNING: too much gear to grab from the cache")
                }
            }
        }
        else if instance_place(x,y,cursor) and not popup_exists()  and rightclick_pressed() and not swap_counter and dis_slot_alpha > 0.2 
        {
            audio(snd_pickup2,1)
                            
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
                    //no need to sync doll for cache deletes
                    //sync_my_doll()
                }
                instance_destroy()  
            }
        }
    } //end interact code
    
    //NOW ACTUALLY DRAW STUFF
    if instance_exists(bpart) and index < ds_list_size(list)
    {
        //SLOTS THAT HAVE REAL ITEMS IN THEM
        bpart.x = dis_slot_x
        bpart.y = dis_slot_y
        draw_bpart_slot_complete(bpart, bpart.x, bpart.y, dis_slot_alpha)
        
        if bpart.new
        {
            draw_notification(1,bpart.x+global.noffset,bpart.y+global.noffset,1,bpart.color,1)
        }
        draw_mod_notification(bpart.x+64-global.moffset,bpart.y+global.moffset,bpart.icon)
        
        with bpart
        {
            if instance_place(x,y,cursor) and not other.id.popup_drawn and other.id.xoff_prev = other.id.cache_xoffset
            {
                hovering ++
                
                if hovering = hover_delay and dis_slot_alpha > 0.2
                    audio(snd_scroll3,1)
                
                if hovering > hover_delay and dis_slot_alpha > 0.2 
                {
                    new = false
                    popup_alpha = lerp_real(popup_alpha*dis_slot_alpha,1,popup_lerp_real)
                    if not contemplating_scrap
                    {   
                        drawing_cache_popup = true
                        draw_popup_with_drawer(x,y,name,global.name_rarity[rarity]+" "+lookup_limb_type_name(limb_type),"",global.cache_description,color,1,icon)
                    } else {
                        drawing_cache_popup = true
                        draw_bpart_slot_disabled(x, y, 1)
                        draw_popup_with_drawer(x, y, "Scrap Gear", "", "", "Right-Click To Delete Forever", c_red,1,icon)
                    }
                } else drawing_cache_popup = false
            } else 
            {
                hovering = 0
                drawing_cache_popup = false
            }
        }
    }
    else //EMPTY SLOT
    {
        draw_bpart_slot_empty(dis_slot_x,dis_slot_y,dis_slot_alpha)
    }
    
}

draw_set_alpha(1)
