/// @description real_time_step()
/// @function real_time_step
previous_delta_time = delta_time
sec1 = current_second

if sec1 != sec0
{
    sec0 = sec1
    time1 = get_timer()
    ms_per_sec = time1 - time0
    //printf("::: ms_per_sec = "+string(ms_per_sec)+", delta_time = "+string(delta_time))
    
    
    //if keyboard_check(vk_enter) and id = myPlayer()
      //  printf("::: hsp = "+string(hsp)+", real_speed(hsp) = "+string(real_speed(hsp))+", ms_per_sec = "+string(net_manager.ms_per_sec))

    
    //must happen last, of course
    time0 = time1
}
