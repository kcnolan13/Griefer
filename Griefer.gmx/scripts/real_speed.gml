///real_speed(theoretical_speed)
var ideal = argument0
var ret = ideal * abs(net_manager.previous_delta_time/delta_time)

//printf("::: real_speed = "+string(ret))

return ret
