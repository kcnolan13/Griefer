if (string(animation_previous) != string(varRead("animation")))
    {
        switch (string(varRead("animation")))
        {
            case "stand":
                animation_stand()
            break
            
            case "walk":
                animation_walk()
            break
            
            case "roll":
                animation_roll()
            break
            
            case "crawl":
                animation_crawl()
            break
            
            case "wall":
                animation_wall()
            break
            
            case "die":
                animation_die()
            break
            
            case "die_headshot":
                animation_die_headshot()
            break
        }      
    }
    animation_previous = varRead("animation")
    
    if (string(arm_pose_previous) != string(varRead("arm_pose")))
    {
        switch (string(varRead("arm_pose")))
        {
            case "pistol":
                pose_pistol()
            break
            
            case "rifle":
                pose_rifle()
            break
            
            case "nade":
                pose_nade()
            break
        }
    }
    arm_pose_previous = varRead("arm_pose")