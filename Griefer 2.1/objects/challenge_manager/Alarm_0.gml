/// @description snap to grid

///manage challenge objects
if not in_match()
{
	if menmode() == "challenges"
	{
	    //bring all challenge objects back to where they belong in the grid
	    snap_challenges_to_grid(FL_PROGRESSION, true)
	    snap_challenges_to_grid(FL_COMPETITIVE, true)
	    snap_challenges_to_grid(FL_CHALLENGES, true)
		snap_challenges_to_grid(FL_BOT, true)
	}
	else {
		//bring all challenge objects back to where they belong in the grid
	    snap_challenges_to_grid(FL_PROGRESSION, false)
	    snap_challenges_to_grid(FL_COMPETITIVE, false)
	    snap_challenges_to_grid(FL_CHALLENGES, false)
		snap_challenges_to_grid(FL_BOT, false)
	}
}

alarm[0] = room_speed*3

