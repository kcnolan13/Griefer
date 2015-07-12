///ai_retarcus(percent_active, percent_reflexes)
var percent_active = argument0
var percent_reflexes = argument1

{
    weapon_time ++
    
    percent_active += 0.05
    
    if varRead("flash_hp") < 75
        return false
    
    //point the cursor at a random player
    target = nearest_enemy(id)
    if instance_exists(target) and varRead("flash_hp") > 75 and not in_smoke(target)
    {
        xaim = lerp(xaim,target.x, percent_reflexes)
        yaim = lerp(yaim,target.y, percent_reflexes)
    }
    
    if instance_exists(weapon_contemplating) and weapon_time > weapon_time_min and random(1) < 0.8 and id != myPlayer()
    {
        printf("::: bot trying to pick up weapon")
        weapon_time = 0
        with (weapon_contemplating) 
        {
            weapon_press_space()
        }
    }
    
    if random(1) < percent_active
    {
        do_me = floor(random_range(player_controls_placeholder1+1,player_controls_placeholder2-0.1))
        
        if do_me = press_x do_me ++
        
        script_execute(do_me)
        
        //pick a random thing to do with the active weapon
        if instance_exists(varRead("active_weapon"))
        {
            if (objVarRead(varRead("active_weapon"),"name") = global.frag and varRead("rank") < 12) or random(1) < 0.75
            {
                if weapon_time > weapon_time_min
                {
                    weapon_time = 0
                    next_weapon()
                }
            }
                
            do_me = floor(random_range(weapon_controls_placeholder1+1,weapon_controls_placeholder2-0.1))
            
            if do_me = weapon_press_r do_me ++
            if (do_me = weapon_press_right) and (random(1 < 0.8) or not instance_exists(target) or collision_line(x,y,other.id.target.x,other.id.target.y,solid_generic,true,false))
                do_me +=3
                
            shooting_dist = 768+512*varRead("rank")/array_length_1d(global.rank_names)
            shooting_prob = varRead("rank")/array_length_1d(global.rank_names)+0.3
            
            with varRead("active_weapon")
            {
                if other.id.do_me != weapon_press_left and other.id.do_me != weapon_hold_left
                    script_execute(other.id.do_me)
                    
                if instance_exists(other.id.target) and (not in_smoke(other.id.target)) and not collision_line(x,y,other.id.target.x,other.id.target.y,solid_generic,true,false) and point_distance(x,y,other.id.target.x,other.id.target.y) < other.id.shooting_dist and random(1) < other.id.shooting_prob
                {
                    script_execute(weapon_press_left)
                    script_execute(weapon_hold_left)
                }
            }
        }
        
    }
}
