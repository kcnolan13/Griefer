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

