/// @description lerp_real meter bar

//inherited modal behavior
event_inherited()

if popped_in
{
    meter_actual_percent = constrict(meter_actual_percent,0,1)
    
    if dif(meter_percent,1) < 0.01
        meter_percent = 1
    else
    {
        var cand_percent = lerp_real(meter_percent,meter_actual_percent,meter_lerp_real)
        if dif(meter_percent, cand_percent) > 0.025
            meter_percent = cand_percent
        else
            meter_percent += 0.025
            
        meter_percent = constrict(meter_percent,0,meter_actual_percent)
    }
    
    if dif(meter_backing_percent,1) < 0.01
        meter_backing_percent = 1
    else 
        meter_backing_percent = lerp_real(meter_backing_percent,1,meter_backing_lerp_real)
}

