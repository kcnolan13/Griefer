/// @description do physics and make particles

counter += real_speed(1)

printf("smoke splosion!")
if counter > 2 and not computed_challenge and find_player(varRead("senderId")) = net_manager.local_player 
{
    computed_challenge = true
    //update smoke totals
    increment_weapon_accolade("spr_smoke")
    challenge_manager.smokes ++
    printf("challenge smokes = "+string(challenge_manager.smokes))
}

part_emitter_region(sys_smoke,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

if counter < life
{
    part_type_speed(ps,0,real_speed(3),real_speed(0.015),real_speed(0.1))
    if random(1) < 0.035
        part_emitter_burst(sys_smoke,em,ps,1)
}

if counter > life+part_life
{
    printf("destroying smoke system")
    instance_destroy()
}

