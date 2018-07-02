/// @description perform step
if perform_step != 0
    exit

///sync position and set previous stats periodically ... assess stationary
if not varRead("trigger_update_ignore")
{
    x = varRead("myX")
    y = varRead("myY")
}

if x = xprevious and y = yprevious
{
    stationary_counter += real_speed(1)
}   
else stationary_counter = 0

//update previous grid stats every now and again
if nth_frame(1)
{
    varWrite("match_points_previous",varRead("match_points"))
    varWrite("match_kills_previous",varRead("match_kills"))
    varWrite("match_deaths_previous",varRead("match_deaths"))
    varWrite("match_assists_previous",varRead("match_assists"))
}

///view stuff

if global.using_gamepad //or not computed_curs
compute_cursor_offset()

if global.using_gamepad //or not computed_view
framely_view_adjust()

