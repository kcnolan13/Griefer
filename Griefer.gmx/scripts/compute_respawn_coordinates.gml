///compute_respawn_coordinates(player_object, flag)
//CALLABLE FROM NET_MANAGER ONLY

var player_object = argument0
var flag = argument1

//printf("OPTIMIZING Respawn Coordinates for Player #"+objVarRead(player_object,"uniqueId"))

//list of spawn points with LOS to an enemy --> key = candidate id, val = min LOS to enemy
var points_with_los = ds_map_create()

//map of spawn points with no LOS to an enemy --> key = candidate id, val = min dist to enemy
var points_with_no_los = ds_map_create()

for (var dat_index=0; dat_index < instance_number(spawn_point_generic); dat_index++)
{
    var candidate = instance_find(spawn_point_generic,dat_index)

    //if DEBUG
        //printf(":::    analyzing spawn point @ "+candidate.x+", "+candidate.y)
    
    if net_manager.starting_match
    {
        //rule out opposing spawn points at the beginning of the match
        var my_team = get_team(player_object)
        
        if net_manager.team > -1 and 
              ((my_team = 1 and candidate.object_index = spawn_point0) 
            or (my_team = 0 and candidate.object_index = spawn_point1))
        {
            //if DEBUG
                //printf(":::        bad candidate --> wrong team")
                
            //toss this one --> next spawn point candidate please
            continue
        }
        
        //also rule out neutral spawn points at the beginning of the match
        if candidate.object_index = spawn_point_neutral and objVarRead(net_manager,"game_mode") != "ffa"
        {
            //if DEBUG
                //printf(":::        bad candidate --> neutral spawn @ match start")
                
            //toss this one --> next spawn point candidate please
            continue
        }
    }
    
    //rule out spawn points that already have a guy on them
    if instance_position(candidate.x, candidate.y, player)
    {
        //if DEBUG
            //printf(":::        bad candidate --> spawn point occupied")
            
        //toss this one --> next spawn point candidate please
        continue
    }
    
    //rule out spawn points too close to explosions
    if in_ink(candidate) or in_flame(candidate) or in_snare(candidate)
    {
        continue
    }
    
    //---- BUILD DS MAPS FROM FILTERED CANDIDATES ----//
    
    //does this spawn point have LOS to an enemy?
    var los = min_line_of_sight_to_enemy(candidate)
    if los > -1
    {
        ds_map_add(points_with_los,candidate,los)
    } 
    else
    {
        //no LOS, so now get candidate's min distance to enemies
        var dat_min_dist = min_distance_to_enemy(candidate)
        if dat_min_dist > -1
        {
            ds_map_add(points_with_no_los,candidate,dat_min_dist)
        }
        else
        {
            //printf("        ERROR: Spawn Point Candidate "+candidate+" has neither LOS nor Min Distance to enemies")
        }
    }
}

//we now have valid DS Maps of spawn points with and without LOS to an enemy
//if DEBUG
{
    //printf("found "+ds_map_size(points_with_no_los)+" points with no LOS to an enemy")
    //printf("found "+ds_map_size(points_with_los)+" points with LOS to an enemy")
}


if flag = FL_RANDOM
{
    printf("::: OVERLAPPING SPAWNS --> randomizing to avoid further confusion...")
    
    if (not ds_map_empty(points_with_los) or not ds_map_empty(points_with_no_los))
    {
        //select one of the ds lists
        if (random(1) > 0.5 or ds_map_empty(points_with_los)) and not ds_map_empty(points_with_no_los)
        {
            rando_list = points_with_no_los
        } else rando_list = points_with_los
        
        //select a random spawn from this list
        spawn_ind = floor(random_range(0,ds_map_size(rando_list)))
        var i=0
        var cand = ds_map_find_first(rando_list)
        var whiles = 0
        while (i<spawn_ind-1) and whiles < 1000
        {
            whiles++
            i++
            cand = ds_map_find_next(rando_list,cand)
        }
        
        //SET SPAWN_X AND SPAWN_Y
        spawn_x = cand.x
        spawn_y = cand.y
        spawn_fail_message = ""
        
    }
    else
    {
        if DEBUG
        {
            printf("SUPER ERROR: all spawn points have neither LOS nor Min Distance to enemies.")
            printf("-----> this error is neither a bird, nor a plane... in case anyone was wondering.")
            printf("-------> it could be due to Super Campers! ... directly on all the spawn points? really?")
        }
    }
    
}

//these are the normal spawn and should happen with FL_NORMAL, not FL_RANDOM
if flag != FL_RANDOM
{
    if not ds_map_empty(points_with_no_los)
    {
        //this is the ideal scenario -- there are some with no Line-Of-Sight
        //now pick the spawn point with maximum min-dist from enemies
        var cand = ds_map_find_first(points_with_no_los)
        var optimal_spawn_point = cand //to contain the best candidate
        var dist_from_enemies = ds_map_find_value(points_with_no_los,cand)
        
        //if DEBUG
          //  printf("            optimizing ... "+truncate(dist_from_enemies/64,1)+" blocks from enemy")
        
        for (var cand_index = 0; cand_index < ds_map_size(points_with_no_los) - 1; cand_index++)
        {
            cand = ds_map_find_next(points_with_no_los,cand)
            //search through the whole ds map and find point with maximum min-dist from enemies
            var temp_dist = ds_map_find_value(points_with_no_los,cand)
            
            //if DEBUG
              //  printf("            optimizing ... "+truncate(temp_dist/64,1)+" blocks from enemy")
                
            if temp_dist > dist_from_enemies
            {
                //this is a better spawn point
                optimal_spawn_point = cand
                dist_from_enemies = temp_dist
            }
        }
        
        //SET SPAWN_X AND SPAWN_Y
        spawn_x = optimal_spawn_point.x
        spawn_y = optimal_spawn_point.y
        spawn_fail_message = ""
        
        //if DEBUG
        {
            printf(":::OPTIMAL SPAWN POINT FOUND @ ("+string(spawn_x)+", "+string(spawn_y)+")")
            printf(":::    No LOS to enemy and "+string(truncate(dist_from_enemies/64,1))+" blocks from nearest enemy")
        }
        
        //DOPE BEATS, WE'RE DONE
        
    }
    else if not ds_map_empty(points_with_los)
    {
        //this is the non-ideal scenario. all spawns have LOS to an enemy
        //hopefully there is one at least MIN_ENEMY_SPAWN_DIST away from all enemies
        var cand = ds_map_find_first(points_with_los)
        var optimal_spawn_point = cand //to contain the best candidate
        var dist_from_enemies = ds_map_find_value(points_with_los,cand)
        
        //if DEBUG
          //  printf("            optimizing ... "+truncate(dist_from_enemies/64,1)+" blocks from enemy")
        
        for (var cand_index = 0; cand_index < ds_map_size(points_with_los) - 1; cand_index++)
        {
            cand = ds_map_find_next(points_with_los,cand)
            //search through the whole ds map and find point with maximum min-dist from enemies
            var temp_dist = ds_map_find_value(points_with_los,cand)
            
            //if DEBUG
              //  printf("            optimizing ... "+truncate(dist_from_enemies/64,1)+" blocks from enemy")
            
            if temp_dist > dist_from_enemies
            {
                //this is a better spawn point
                optimal_spawn_point = cand
                dist_from_enemies = temp_dist
            }
        }
        
        //is the best one far enough away from enemies to actually spawn at it?
        if dist_from_enemies > MIN_ENEMY_SPAWN_DIST
        {
            //SET SPAWN_X AND SPAWN_Y
            spawn_x = optimal_spawn_point.x
            spawn_y = optimal_spawn_point.y
            spawn_fail_message = ""
            
            {
            printf(":::SUB-OPTIMAL SPAWN POINT FOUND @ ("+string(spawn_x)+", "+string(spawn_y)+")")
            printf(":::    There is LOS to enemy, but "+string(truncate(dist_from_enemies/64,1))+" blocks from nearest enemy")
            }
            
        }
        else
        {
            printf(":::CAMPER ALERT! You don't want to spawn yet. Really.")
            spawn_fail_message = "CAMPER ALERT! Waiting for them to quit it . . ."
        }
        
    }
    else
    {
        if DEBUG
        {
            printf("SUPER ERROR: all spawn points have neither LOS nor Min Distance to enemies.")
            printf("-----> this error is neither a bird, nor a plane... in case anyone was wondering.")
            printf("-------> it could be due to Super Campers! ... directly on all the spawn points? really?")
        }
    }
}

//free dynamically allocated memory and return
ds_map_destroy(points_with_los)
ds_map_destroy(points_with_no_los)
return true
