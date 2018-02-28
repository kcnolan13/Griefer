/// @description initialization

axes[0] = gp_axislh
axes[1] = gp_axislv
axes[2] = gp_axisrh
axes[3] = gp_axisrv

pressed[0] = false
pressed[1] = false
pressed[2] = false
pressed[3] = false

released[0] = false
released[1] = false
released[2] = false
released[3] = false

pressed_counter[0] = 0
pressed_counter[1] = 0
pressed_counter[2] = 0
pressed_counter[3] = 0

set_pressed[0] = 0
set_pressed[1] = 0
set_pressed[2] = 0
set_pressed[3] = 0

schedule_queue_script = scr_none
schedule_queue_counter = 0

schedule_script = scr_none
schedule_counter = 0

action_set_alarm(30, 0);
