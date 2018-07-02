/// @description adjust for aligns
if halign = fa_center
    x -= width/2
if valign = fa_center
    y -= height/2
    
text_normal = text

//printf("::: "+string(label_name)+" initialized with sense val: "+string(sens_val))

if is_sens
{
    sens_percent = (sens_val-sens_low)/(sens_high - sens_low)
}

