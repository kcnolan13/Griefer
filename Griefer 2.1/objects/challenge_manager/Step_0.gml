/// @description decrement challenges showing popup
if challenge_showing_popup
    challenge_showing_popup --
    
if string_counter > 0
{
    string_counter = sub_real(string_counter,1)
    if string_counter = 0
    {
        string_kills = 0
    }
}   

if not in_match() {
	if menmode() == "challenges" {
		if challenge_generic.loading_alpha_target < 0.5 {
			printf("::: snapping challenges to on screen")
			//bring all challenge objects back to where they belong in the grid
			challenge_index = 0
		    snap_challenges_to_grid(FL_PROGRESSION, true)
		    snap_challenges_to_grid(FL_COMPETITIVE, true)
			snap_challenges_to_grid(FL_BOT, true)
		    snap_challenges_to_grid(FL_CHALLENGES, true)
			
		}
	} else {
		if challenge_generic.loading_alpha_target > 0.5 {
			printf("::: snapping challenges to off screen")
			//bring all challenge objects back to where they belong in the grid
			challenge_index = 0
		    snap_challenges_to_grid(FL_PROGRESSION, false)
		    snap_challenges_to_grid(FL_COMPETITIVE, false)
			snap_challenges_to_grid(FL_BOT, false)
		    snap_challenges_to_grid(FL_CHALLENGES, false)
		}
	}
}

