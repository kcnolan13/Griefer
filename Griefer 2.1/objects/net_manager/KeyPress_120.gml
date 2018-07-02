/// @description snapshot mode
if keyboard_check(vk_shift)
{
    snapshot_mode ^= 1
    var txt = "Disabled"
    if snapshot_mode
        txt = "Enabled"
        
    if keyboard_check(vk_control)
    {
        txt = "Loop Engaged!"
        snapshot_auto = true
        room_goto(rm_double)
    }
    else
        snapshot_auto = false
        
    popup_alert(WVIEW/2,HVIEW/2,"Snapshot Mode",txt)
}
else if snapshot_mode
{
    printf("::: TAKING SNAPSHOT!")
    //take snapshot
    var snap_w = sprite_get_width(snap_double)*2
    var snap_h = sprite_get_height(snap_double)*2
    screen_save_part("snapshots/snapshot"+string(snapshot_number)+".png",WVIEW/2-snap_w/2,HVIEW/2-snap_h/2,snap_w,snap_h)
    snapshot_number++
    
    if snapshot_auto and room < map_placeholder2 - 1
        room_goto(room+1)
}

