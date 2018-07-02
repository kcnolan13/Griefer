/// @description snap to grid

///manage challenge objects
if not in_match()
{
	if menmode() == "challenges"
	{
	    //bring all challenge objects back to where they belong in the grid
		challenge_index = 0
	    snap_challenges_to_grid(FL_PROGRESSION, true)
	    snap_challenges_to_grid(FL_COMPETITIVE, true)
		snap_challenges_to_grid(FL_BOT, true)
	    snap_challenges_to_grid(FL_CHALLENGES, true)
	}
	else {
		//bring all challenge objects back to where they belong in the grid
		challenge_index = 0
	    snap_challenges_to_grid(FL_PROGRESSION, false)
	    snap_challenges_to_grid(FL_COMPETITIVE, false)
		snap_challenges_to_grid(FL_BOT, false)
	    snap_challenges_to_grid(FL_CHALLENGES, false)
	}
}

//alarm[0] = room_speed*3

