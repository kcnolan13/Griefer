///real_speed(theoretical_speed)
var ideal = argument0
var ret = ideal * abs(delta_time*room_speed/(net_manager.ms_per_sec))
//printf("::: real_speed = "+string(ret))

return ret