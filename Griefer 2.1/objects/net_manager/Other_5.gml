/// @description synch up stats with player's in-game performance
draw_texture_flush()
varWrite("end_match_coming",0)
computed_winloss = false
previous_room = room
audio_stop_sound(snd_flashed)

with all
{
    if not persistent and instance_exists(id)
        instance_destroy()
}

if ui_countdown != noone
{
    ui_countdown = noone
    global.load_count -- 
    if global.load_count < 0
        global.load_count = 0
}

show_scores = 0
saving_armor = 0
saving_armor_reboot = false

if room = rm_lobby
{
    lotto_slot_scale[0] = slot_scale_init
    lotto_slot_scale[1] = slot_scale_init
    lotto_slot_scale[2] = slot_scale_init
    steal_slot_scale = slot_scale_init
    mode_counter = 0
    varWrite("stole_gear",false)
    varWrite("lost_gear",false)
    varWrite("lost_gear_source","")
    varWrite("stole_gear_source","")
    varWrite("stole_gear_sprite",false)
    varWrite("lost_gear_sprite",false)
    varWrite("transacted_player","")
    bpart_transacted = noone
    bpart_lotto[0] = noone
    bpart_lotto[1] = noone
    bpart_lotto[2] = noone
    came_from_match = false
}

if room = rm_login
{
    load_room_start = true
}

