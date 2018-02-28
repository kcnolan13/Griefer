/// @description annotate death if debug
if SUPER_DEBUG
    printf("Expiration: hit_marker with uniqueId "+varRead("uniqueId"))

action_kill_object();
