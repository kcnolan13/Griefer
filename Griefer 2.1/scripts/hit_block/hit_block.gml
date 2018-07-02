/// @description hit_block(block)
/// @function hit_block
/// @param block
//MUST BE CALLED FROM BULLET
var dat_block = argument0

if counter > 0
{
    if is_local_player(varRead("senderId")) and not have_hit_target
    {
        hitmark_target(id,dat_block)
    }
    instance_destroy()
    exit
}