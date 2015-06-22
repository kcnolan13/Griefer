///draw_flash_compensate()
if instance_exists(net_manager.local_player) and in_match()
{
    if objVarRead(net_manager.local_player,"flash_hp") < 50
        draw_set_color(c_black)
}