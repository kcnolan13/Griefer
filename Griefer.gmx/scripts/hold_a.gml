if not varRead("controllable") 
{
    printf("::: player not controllable")
    return false
}

if slide_left = 1
{
    bail_slide_timer += 2
    if bail_slide_timer < bail_slide_timer_max
        return false
    else
    {
        wall_delay = wall_delay_max
        bail_slide_timer = 0
        slide_left = 0
        varSub("myX",bail_slide_offset)
    }
}

if x > 0 and slide_right = 0 and redirect_counter = 0
{
    walking = true
    
    if crawling = 0
    {
        var accel = accel_walk
        if in_air accel *= accel_air_scaler
        if hsp > -1*speed_walk/mass hsp -= ceil(accel/mass)
        
        if varRead("speed_multiplier") < 1
        {
            if hsp < -1*speed_walk/mass*varRead("speed_multiplier")
                hsp = -1*speed_walk/mass*varRead("speed_multiplier")
        }
    }
    else
    {
        var accel = accel_crawl
        if in_air accel *= accel_air_scaler
        if hsp > -1*speed_crawl/mass hsp -= ceil(accel/mass)
        
        if varRead("speed_multiplier") < 1
        {
            if hsp > -1*speed_crawl/mass*varRead("speed_multiplier")
                hsp = -1*speed_crawl/mass*varRead("speed_multiplier")
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
