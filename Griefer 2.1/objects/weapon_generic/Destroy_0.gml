/// @description free net vars

printf("::: destroying weapon "+string(varRead("name"))+", my_player="+string(varRead("my_player")))

if instance_exists(myCursor)
    myCursor.active = false
    
ds_map_destroy(netvars)
destroyed = true

