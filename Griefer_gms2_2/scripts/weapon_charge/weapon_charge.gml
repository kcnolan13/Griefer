if varRead("charge_counter") < 0
{
    varWrite("charge_counter",varRead("charge_delay"))
} else {
    if varRead("charge_counter") > 0
    {
        varSub("charge_counter",1)   
    }
}

//charge % = charge_offset + ((charge_delay-charge_counter-charge_offset*charge_delay)+charge_delay*charge_weight)/(charge_delay*(1+charge_weight))
varWrite("charge",(varRead("charge_delay")-varRead("charge_counter"))/varRead("charge_delay"))

var my_dude = find_player(varRead("my_player"))
objVarWrite(my_dude,"arm_animation_speed",0)
objVarWrite(my_dude,"arm_animation_index",0)