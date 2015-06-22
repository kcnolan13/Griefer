if not varRead("controllable") return false

if x < room_width and slide_left = 0 and redirect_counter = 0
{
    walking = true
    
    if crawling = 0
    {
        if hsp < 10/mass
            hsp += 5/mass
        if slide_right = 1
            varAdd("myX",7)
            
        if varRead("speed_multiplier") < 1
        {
            if hsp > 10/mass*varRead("speed_multiplier")
                hsp = 10/mass*varRead("speed_multiplier")
        }
            
    }
    else
    {
        if hsp < 5/mass
        hsp += 5/mass
        
        if varRead("speed_multiplier") < 1
        {
            if hsp > 5/mass*varRead("speed_multiplier")
                hsp = 5/mass*varRead("speed_multiplier")
        }
    }
    
    if (cursor.x > varRead("myX"))
        varWrite("animation_speed",SPD_WALK)
    else
        varWrite("animation_speed",-1*SPD_WALK)
    
    if (crawling = 0 && rolling = 0)
        animation_walk()
    else if rolling = 0
        animation_crawl()
}