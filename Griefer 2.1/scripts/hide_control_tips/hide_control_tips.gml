/// @description hide_control_tips()
/// @function hide_control_tips
if instance_exists(net_manager.control_tips)
{
    with net_manager.control_tips
    {
        fade_out = true
    }
}
