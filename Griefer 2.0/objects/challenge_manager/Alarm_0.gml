/// @description snap to grid

///manage challenge objects
if not in_match()
{
    //bring all challenge objects back to where they belong in the grid
    snap_challenges_to_grid(FL_PROGRESSION)
    snap_challenges_to_grid(FL_COMPETITIVE)
    snap_challenges_to_grid(FL_CHALLENGES)
	snap_challenges_to_grid(FL_BOT)
}

alarm[0] = room_speed*3

