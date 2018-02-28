/// @description no double clicking
event_inherited()
label = text

if not instance_exists(parent_table)
    fade_out = true
else if parent_table.fade_out
    fade_out = true

