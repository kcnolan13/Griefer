/// @description dissipate
if delay
delay --

//printf("angle = "+varRead("angle"))

light.loc = loc
glr_lightsimple_set_rotation(light,varRead("angle"))
prev_angle = varRead("angle")

if not enabled and not delay
{
    glr_lightsimple_set_intensity(light,intensity)
    glr_lightsimple_set_active(light)
    enabled = true
    current_xscale = xscale
    current_yscale = yscale
    
    if SUPER_DEBUG
        printf("glare light count = "+glr_lightsimple_get_count())
}

if varRead("xscale") > 0
{
    //if DEBUG
       // printf("muzzle flash xscale override: "+varRead("xscale"))
    xscale = varRead("xscale")
    current_xscale = xscale
    varWrite("xscale",-1)
}

if varRead("yscale") > 0
{
    //if DEBUG
       // printf("muzzle flash yscale override: "+varRead("yscale"))
    yscale = varRead("yscale")
    current_yscale = yscale
    varWrite("yscale",-1)
}

if enabled
{
    if object_index != splosion_ink and object_index != splosion_snare and object_index != splosion_flame
        life --
    
    if not life or current_intensity < 0.25 
    {
        if object_index != splosion_ink and object_index != splosion_snare and object_index != splosion_flame
            instance_destroy()
        else
            {
                intensity = 0
                current_intensity = 0
                enabled = false
            }
            
        return false
    }
    
    current_intensity /= intensity_divisor
    current_intensity_flicker = random_range(-intensity_flicker,intensity_flicker)
    
    if current_intensity+current_intensity_flicker < 0
        glr_lightsimple_set_active(light)
    else
        glr_lightsimple_set_active(light)
        
    current_xscale /= scale_divisor
    current_yscale /= scale_divisor
    current_scale_flicker = random_range(-scale_flicker,scale_flicker)
    
    if prev_xscale != current_xscale+current_scale_flicker or prev_yscale !=  current_yscale+current_scale_flicker
        {
            glr_lightsimple_set_scaling(light,current_xscale+current_scale_flicker, current_yscale+current_scale_flicker)
            prev_xscale = current_xscale+current_scale_flicker
            prev_yscale = current_yscale+current_scale_flicker
        }
        
    if prev_intensity != current_intensity+current_intensity_flicker
    {
        glr_lightsimple_set_intensity(light,current_intensity+current_intensity_flicker)
        prev_intensity = current_intensity+current_intensity_flicker
    }
    
}

