//general control constants

global.optimize_graphics = "Graphics"
global.optimize_fps = "Frame Rate"
global.txt_restore = "[Click to Restore]"

global.gc[GC_SHOW_XP,0] = "Show XP In Match"
global.gc[GC_SHOW_XP,1] = "On"
global.gc[GC_SHOW_XP,2] = false //is_sens
global.gc[GC_VIOLENT_CONTENT,0] = "Violent Content"
global.gc[GC_VIOLENT_CONTENT,1] = "On"
global.gc[GC_VIOLENT_CONTENT,2] = false //is_sens
global.gc[GC_CONTROL_HINTS,0] = "Control Hints"
global.gc[GC_CONTROL_HINTS,1] = "On"
global.gc[GC_CONTROL_HINTS,2] = false //is_sens
global.gc[GC_AA_LEVEL,0] = "SWF Anti-Aliasing"
global.gc[GC_AA_LEVEL,1] = 1
global.gc[GC_AA_LEVEL,2] = true //is_sens
global.gc[GC_KILL_FEED,0] = "Show Kill Feed"
global.gc[GC_KILL_FEED,1] = "On Action"
global.gc[GC_KILL_FEED,2] = false
global.gc[GC_KILL_FEED_ALPHA,0] = "Kill Feed Size"
global.gc[GC_KILL_FEED_ALPHA,1] = 0.65
global.gc[GC_KILL_FEED_ALPHA,2] = true //is_sens
global.gc[GC_CHAT_FEED,0] = "In-Match Chat Feed"
global.gc[GC_CHAT_FEED,1] = "On Action"
global.gc[GC_CHAT_FEED,2] = false
global.gc[GC_CHAT_FEED_ALPHA,0] = "Chat Feed Size"
global.gc[GC_CHAT_FEED_ALPHA,1] = 0.55
global.gc[GC_CHAT_FEED_ALPHA,2] = true //is_sens
global.gc[GC_SURFACES,0] = "Surface Effects"
global.gc[GC_SURFACES,1] = "On"
global.gc[GC_SURFACES,2] = false //is_sens
global.gc[GC_PARTICLES,0] = "Particle Effects"
global.gc[GC_PARTICLES,1] = "On"
global.gc[GC_PARTICLES,2] = false //is_sens
global.gc[GC_RAGDOLLS,0] = "Ragdoll Physics"
global.gc[GC_RAGDOLLS,1] = "On"
global.gc[GC_RAGDOLLS,2] = false //is_sens
global.gc[GC_FPS,0] = "Optimize For: "
global.gc[GC_FPS,1] = global.optimize_graphics
global.gc[GC_FPS,2] = false //is_sens
global.gc[GC_DEFAULTS,0] = "Restore Defaults"
global.gc[GC_DEFAULTS,1] = global.txt_restore
global.gc[GC_DEFAULTS,2] = false //is_sens

for (var i=0; i<array_height_2d(global.gc); i++)
{
    for (var j=0; j<3; j++)
    {
        global.gc_defaults[i,j] = global.gc[i,j]
    }
}

global.dismembered = "Dismembered"
global.dismembered_tame = "Explosive"

//gamepad device number
global.devno = 0
global.using_gamepad = false
global.gamepad_connected = false
global.forced_control_scheme = false
global.cursor_dir = 0
global.cursor_offset = 64*8

//mouse during menu
global.cursor_speed_high = 75
global.cursor_speed_low = 25
global.nogp_cursor_speed_high = 3
global.nogp_cursor_speed_low = 0.5

//mouse during gameplay
global.match_cursor_speed_low = 50
global.match_cursor_speed_high = 150
global.nogp_match_cursor_speed_high = 3
global.nogp_match_cursor_speed_low = 0.5

global.cursor_xoff = room_width/2
global.cursor_yoff = room_height/2

//control action names
global.cactions[C_MOVE_LEFT] = "Move Left"
global.cactions[C_MOVE_RIGHT] = "Move Right"
global.cactions[C_JUMP] = "Jump"
global.cactions[C_CROUCH] = "Crouch"
global.cactions[C_EVADE] = "Evade"
global.cactions[C_PREV] = "Previous Weapon"
global.cactions[C_NEXT] = "Next Weapon"
global.cactions[C_SIDEARM_QUICK] = "Quickselect Sidearm"
global.cactions[C_PICKUP] = "Pick Up Weapon"
global.cactions[C_RELOAD] = "Reload"
global.cactions[C_SHOOT] = "Shoot"
global.cactions[C_QUICKTOSS] = "Quicktoss Grenade"
global.cactions[C_PRIMARY] = "Select Primary"
global.cactions[C_SECONDARY] = "Select Secondary"
global.cactions[C_SIDEARM] = "Select Sidearm"
global.cactions[C_GRENADES] = "Select Grenades"
global.cactions[C_DROP] = "Drop Weapon"
global.cactions[C_SWAP_STICKS] = "Swap Sticks"
global.cactions[C_LOOK_SENS] = "Aim Sensitivity"
global.cactions[C_MOUSE_SENS] = "Menu Sensitivity"

//the values currently mapped to control actions
global.cvals[C_MOVE_LEFT] = ord('A')
global.cvals[C_MOVE_RIGHT] = ord('D')
global.cvals[C_JUMP] = ord('W')
global.cvals[C_CROUCH] = ord('S')
global.cvals[C_EVADE] = vk_shift
global.cvals[C_PREV] = ord('Q')
global.cvals[C_NEXT] = ord('E')
global.cvals[C_SIDEARM_QUICK] = vk_space
global.cvals[C_PICKUP] = vk_space
global.cvals[C_RELOAD] = ord('R')
global.cvals[C_SHOOT] = mb_left
global.cvals[C_QUICKTOSS] = mb_right
global.cvals[C_PRIMARY] = ord('1')
global.cvals[C_SECONDARY] = ord('2')
global.cvals[C_SIDEARM] = ord('3')
global.cvals[C_GRENADES] = ord('4')
global.cvals[C_DROP] = ord('X')
global.cvals[C_SWAP_STICKS] = 0
global.cvals[C_MOUSE_SENS] = 1
global.cvals[C_LOOK_SENS] = 1

for (var i=0; i<getLength(global.cvals); i++)
{
    printf("::: global.cvals["+string(i)+" = "+string(global.cvals[i]))
}

//default values mapped to control actions (init to cvals)
for (var i=0; i<getLength(global.cvals); i++)
{
    global.cdefaults[i] = global.cvals[i]
    global.mydefaults[i] = global.cvals[i]
}

global.cgpdefaults[C_MOVE_LEFT] = gp_axislh
global.cgpdefaults[C_MOVE_RIGHT] = gp_axislh
global.cgpdefaults[C_JUMP] = gp_face1
global.cgpdefaults[C_CROUCH] = gp_face2
global.cgpdefaults[C_EVADE] = gp_shoulderlb
global.cgpdefaults[C_PREV] = gp_stickl
global.cgpdefaults[C_NEXT] = gp_stickr
global.cgpdefaults[C_SIDEARM_QUICK] = gp_face4
global.cgpdefaults[C_PICKUP] = gp_shoulderl
global.cgpdefaults[C_RELOAD] = gp_face3
global.cgpdefaults[C_SHOOT] = gp_shoulderrb
global.cgpdefaults[C_QUICKTOSS] = gp_shoulderr
global.cgpdefaults[C_PRIMARY] = gp_padr
global.cgpdefaults[C_SECONDARY] = gp_padl
global.cgpdefaults[C_SIDEARM] = gp_padd
global.cgpdefaults[C_GRENADES] = gp_padu
global.cgpdefaults[C_DROP] = gp_select
global.cgpdefaults[C_SWAP_STICKS] = 0
global.cgpdefaults[C_MOUSE_SENS] = 55
global.cgpdefaults[C_LOOK_SENS] = 95

for (var i=0; i<getLength(global.cgpdefaults); i++)
{
    global.mygpdefaults[i] = global.cgpdefaults[i]
}


for (var i=0; i<getLength(global.cgpdefaults); i++)
{
    printf("::: global.cgpdefaults["+string(i)+" = "+string(global.cgpdefaults[i]))
}

//CONTROL NUMBERS

//standard keyboard
extras[0] = vk_left
extras[1] = vk_right
extras[2] = vk_up
extras[3] = vk_down
extras[4] = vk_enter
extras[5] = vk_escape
extras[6] = vk_space
extras[7] = vk_shift
extras[8] = vk_control
extras[9] = vk_alt
extras[10] = vk_backspace
extras[11] = vk_tab
extras[12] = vk_home
extras[13] = vk_end
extras[14] = vk_delete
extras[15] = vk_insert
extras[16] = vk_pageup
extras[17] = vk_pagedown
extras[18] = vk_pause
extras[19] = vk_printscreen
extras[20] = vk_f1
extras[21] = vk_f2
extras[22] = vk_f3
extras[23] = vk_f4
extras[24] = vk_f5
extras[25] = vk_f6
extras[26] = vk_f7
extras[27] = vk_f8
extras[28] = vk_f9
extras[29] = vk_f10
extras[30] = vk_f11
extras[31] = vk_f12
extras[32] = vk_numpad0
extras[33] = vk_numpad1
extras[34] = vk_numpad2
extras[35] = vk_numpad3
extras[36] = vk_numpad4
extras[37] = vk_numpad5
extras[38] = vk_numpad6
extras[39] = vk_numpad7
extras[40] = vk_numpad8
extras[41] = vk_numpad9
extras[42] = vk_multiply
extras[43] = vk_divide
extras[44] = vk_add
extras[45] = vk_subtract
extras[46] = vk_decimal

//game pad
extras[47] = gp_face1
extras[48] = gp_face2
extras[49] = gp_face3
extras[50] = gp_face4
extras[51] = gp_shoulderl
extras[52] = gp_shoulderr
extras[53] = gp_shoulderrb
extras[54] = gp_shoulderlb
extras[55] = gp_select
extras[56] = gp_start
extras[57] = gp_stickl
extras[58] = gp_stickr
extras[59] = gp_padu
extras[60] = gp_padd
extras[61] = gp_padl
extras[62] = gp_padr
extras[63] = gp_axislh
extras[64] = gp_axislv
extras[65] = gp_axisrh
extras[66] = gp_axisrv

//mouse
extras[67] = mb_left
extras[68] = mb_middle
extras[69] = mb_right

//number keys
extras[70] = ord('0')
extras[71] = ord('1')
extras[72] = ord('2')
extras[73] = ord('3')
extras[74] = ord('4')
extras[75] = ord('5')
extras[76] = ord('6')
extras[77] = ord('7')
extras[78] = ord('8')
extras[79] = ord('9')

//CONTROL NAMES

extra_names[0] = "Left"
extra_names[1] = "Right"
extra_names[2] = "Up"
extra_names[3] = "Down"
extra_names[4] = "Enter"
extra_names[5] = "Escape"
extra_names[6] = "Space"
extra_names[7] = "Shift"
extra_names[8] = "Control"
extra_names[9] = "Alt"
extra_names[10] = "Backspace"
extra_names[11] = "Tab"
extra_names[12] = "Home"
extra_names[13] = "End"
extra_names[14] = "Delete"
extra_names[15] = "Insert"
extra_names[16] = "Page Up"
extra_names[17] = "Page Down"
extra_names[18] = "Pause"
extra_names[19] = "Printscreen"
extra_names[20] = "F1"
extra_names[21] = "F2"
extra_names[22] = "F3"
extra_names[23] = "F4"
extra_names[24] = "F5"
extra_names[25] = "F6"
extra_names[26] = "F7"
extra_names[27] = "F8"
extra_names[28] = "F9"
extra_names[29] = "F10"
extra_names[30] = "F11"
extra_names[31] = "F12"
extra_names[32] = "Numpad 0"
extra_names[33] = "Numpad 1"
extra_names[34] = "Numpad 2"
extra_names[35] = "Numpad 3"
extra_names[36] = "Numpad 4"
extra_names[37] = "Numpad 5"
extra_names[38] = "Numpad 6"
extra_names[39] = "Numpad 7"
extra_names[40] = "Numpad 8"
extra_names[41] = "Numpad 9"
extra_names[42] = "Multiply"
extra_names[43] = "Divide"
extra_names[44] = "Add"
extra_names[45] = "Subtract"
extra_names[46] = "Decimal"
extra_names[47] = "Face Button 1"
extra_names[48] = "Face Button 2"
extra_names[49] = "Face Button 3"
extra_names[50] = "Face Button 4"
extra_names[51] = "Left Bumper"
extra_names[52] = "Right Bumper"
extra_names[53] = "Right Trigger"
extra_names[54] = "Left Trigger"
extra_names[55] = "Select"
extra_names[56] = "Start"
extra_names[57] = "Left Stick"
extra_names[58] = "Right Stick"
extra_names[59] = "D-Pad Up"
extra_names[60] = "D-Pad Down"
extra_names[61] = "D-Pad Left"
extra_names[62] = "D-Pad Right"
extra_names[63] = "H-Axis Left"
extra_names[64] = "V-Axis Left"
extra_names[65] = "H-Axis Right"
extra_names[66] = "V-Axis Right"
extra_names[67] = "Mouse Left"
extra_names[68] = "Mouse Middle"
extra_names[69] = "Mouse Right"
extra_names[70] = "0"
extra_names[71] = "1"
extra_names[72] = "2"
extra_names[73] = "3"
extra_names[74] = "4"
extra_names[75] = "5"
extra_names[76] = "6"
extra_names[77] = "7"
extra_names[78] = "8"
extra_names[79] = "9"

//map control numbers to names
global.cnames = ds_map_create()

var start = ord('A')
for (var i=start; i<start+26; i++)
{
    ds_map_add(global.cnames,i,chr(i))
}

for (var i=0; i<getLength(extras); i++)
{
    ds_map_add(global.cnames,extras[i],extra_names[i])
}

//try to set the dead zones preemptively, if any controllers connected
set_gamepad_deadzones()

//print_ds_map(global.cnames)
