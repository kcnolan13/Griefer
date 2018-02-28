/// @description modal_force_click(modal_id)
/// @function modal_force_click
/// @param modal_id
var modal = argument0

cursor.x = modal.x
cursor.y = modal.y
modal.force_click = true

var was_blocked = modal.blocked

with (modal)
{
    blocked = false
    event_perform(ev_mouse,ev_global_left_press)
}

modal.blocked = was_blocked
modal.force_click = false
