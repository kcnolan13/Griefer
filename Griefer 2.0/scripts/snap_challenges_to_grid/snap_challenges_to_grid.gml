/// @description snap_challenges_to_grid(snap_flag)
/// @function snap_challenges_to_grid
/// @param snap_flag
var fl = argument0

var xst = global.challenge_grid_xstart
var yst = global.challenge_grid_ystart

var challenge_grid_index = get_challenge_grid_index(fl)
var xst = 0
for (var i=0; i<challenge_grid_index; i++) {
	xst += global.challenge_grid_widths[i]*(global.challenge_grid_sep+global.challenge_slot_width)+global.challenge_grids_xsep
}
	
var grid_left = xst

for (var i=0; i<instance_number(challenge_generic); i++)
{
    for (var j=0; j<instance_number(challenge_generic); j++)
    {
        cID = instance_find(challenge_generic,j)
        if cID.challenge_index = i
            break
    }
    
    if cID.challenge_index != i
    {
        printf("ERROR: couldn't find cID with challenge_index = "+string(i))
        continue
    }
    
    //skip certain challenges by grouping (progression-based or not)
    if cID.is_progression and fl != FL_PROGRESSION continue
    if cID.is_challenge and fl != FL_CHALLENGES continue
    if cID.is_competitive and fl != FL_COMPETITIVE continue
	if cID.is_bot_mode and fl != FL_BOT continue
    
    //now snap snap snap yo fingas
    cID.x = xst
    cID.y = yst
    printf("placing challenge @ "+string(cID.x)+", "+string(cID.y))
    xst += global.challenge_slot_width+global.challenge_grid_sep
    if xst >= grid_left+global.challenge_grid_widths[challenge_grid_index]*(global.challenge_grid_sep+global.challenge_slot_width)
    {
        printf("carriage return")
        xst = grid_left
        yst += global.challenge_slot_width+global.challenge_grid_sep
    }
}
