/// @description do whateva an accolade generic does...

//inherited modal behavior
event_inherited()

if not in_match() and menmode() = "stats"
{
    x = lerp(x,xtarget,0.25)
}

if in_match() and not match_ending() and counter > intended_fade_delay
{
    if not fade_out
    {
        printf("ERROR: accolade_generic has counter > intended_fade_delay")
        fade_out = true
    }
    else if counter > intended_fade_delay*2
    {
        printf("ERROR: accolade_generic has been around for "+string(counter)+" steps and is trying to fade_out but scale is still "+string(scale))
    }
}

