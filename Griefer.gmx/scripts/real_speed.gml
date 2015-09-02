///real_speed(theoretical_speed)
var ideal = argument0

//give 5 seconds for game to boot up
if real_current_time() < 1000*10 and fps < 55
{
    return ideal
}


var ret = ideal * abs(delta_time*30/(net_manager.ms_per_sec))
//printf("::: real_speed = "+string(ret))

if ret > 5*ideal and real_current_time() < 1000*30
    ret = 5*ideal

return ret
