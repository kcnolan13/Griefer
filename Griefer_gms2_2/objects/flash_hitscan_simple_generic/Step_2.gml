/// @description dissipate
if delay
delay --

depth = -90

if not enabled and not delay
{
    enabled = true
    current_xscale = xscale
    current_yscale = yscale
}

if varRead("xscale") > 0
{
    if DEBUG
        printf("muzzle flash xscale override: "+varRead("xscale"))
    xscale = varRead("xscale")
    current_xscale = xscale
    varWrite("xscale",-1)
}

if varRead("yscale") > 0
{
    if DEBUG
        printf("muzzle flash yscale override: "+varRead("yscale"))
    yscale = varRead("yscale")
    current_yscale = yscale
    varWrite("yscale",-1)
}

if enabled
{
    life --
    
    if not life or current_intensity < 0.25 or current_xscale < 0.05
    {
        instance_destroy()
        exit
    }
    
    current_intensity /= intensity_divisor
    current_intensity_flicker = random_range(-intensity_flicker,intensity_flicker)
        
    current_xscale /= scale_divisor*xscale_divisor
    current_yscale /= scale_divisor
    current_scale_flicker = random_range(-scale_flicker,scale_flicker)
}

