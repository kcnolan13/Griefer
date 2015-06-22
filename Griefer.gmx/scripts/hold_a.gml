if not varRead("controllable") 
{
    printf("::: player not controllable")
    return false
}

if x > 0 and slide_right = 0 and redirect_counter = 0
{
    walking = true
    
    if crawling = 0
    {
        if hsp > -10/mass
        hsp -= 5/mass
        
        if varRead("speed_multiplier") < 1
        {
            if hsp < -10/mass*varRead("speed_multiplier")
                hsp = -10/mass*varRead("speed_multiplier")
        }
        
        if slide_left = 1
        varSub("myX",7)
    }
    else
    {
        if hsp > -5/mass
        hsp -= 5/mass
        
        if varRead("speed_multiplier") < 1
        {
            if hsp > -5/mass*varRead("speed_multiplier")
                hsp = -5/mass*varRead("speed_multiplier")
        }
        
    }
    
    if (cursor.x > varRead("myX"))
        varWrite("animation_speed",-1*SPD_WALK)
    else
        varWrite("animation_speed",SPD_WALK)
    
    if (crawling = 0 && rolling = 0)
        animation_walk()
    else if rolling = 0
        animation_crawl()
}