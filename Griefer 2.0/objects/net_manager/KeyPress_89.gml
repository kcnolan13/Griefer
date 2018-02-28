exit;
///toggle show trans rate
if keyboard_check(vk_control)
{
    use_nth_frame ^= 1
}
else
{
    show_trans_rate ^= 1
    trans_rate_previous = 0
    trans_rate = 0
    transmissions = 0
    trans_frames = 0
    receptions = 0
    rec_rate = 0
}

