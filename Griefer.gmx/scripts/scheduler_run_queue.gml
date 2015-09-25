///scheduler_run_queue()
var scr = argument0
var delay = argument1

with input_manager
{
    schedule_script = schedule_queue_script
    schedule_counter = schedule_queue_counter
    schedule_queue_script = scr_none
    schedule_queue_counter = 0
}

return true
