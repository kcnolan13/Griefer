/// @description nth_frame(this_many)
/// @function nth_frame
/// @param this_many
if round(net_manager.room_counter) % argument0 = 0 or net_manager.use_nth_frame = false
    return true
else return false
