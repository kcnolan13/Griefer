///real_speed(theoretical_speed)
var ideal = argument0

//give 5 seconds for game to boot up
if current_time < 1000*5
{
    return ideal
}


var ret = ideal * abs(delta_time*30/(net_manager.ms_per_sec))
//printf("::: real_speed = "+string(ret))

if ret > 5*ideal
    ret = 5*ideal

return ret
