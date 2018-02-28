/// @description change light intensity and launch players

if intensity_dir = 1
    intensity_target = intensity_max
else
    intensity_target = intensity_min
    
intensity = lerp_real(intensity, intensity_target, intensity_lerp_real)

if abs(intensity-intensity_target) < 0.005
    intensity_dir *= -1
    
light.intensity = intensity
light.rot = image_angle

if not truthval(global.gc[GC_PARTICLES,1])
    visible = true
else visible = false

///launch ragdolls

for (var i=0; i<instance_number(rag_generic); i++)
{
    dude = instance_find(rag_generic,i)
    if instance_place(x,y,dude)
    {
        launch_angle = image_angle+90 mod 360
        
        if launch_angle > 270
        launch_angle -= 360
        
        //printf("launch_angle_before = "+launch_angle)
        
        //add some more verticality to the launch
        launch_angle = lerp_real(launch_angle,90,0.5)
        
        //printf("launch_angle REAL = "+launch_angle)
        
        dude.forx = trigx(10,launch_angle)
        dude.fory = trigy(10,launch_angle)
        
        with dude
        {
            physics_apply_impulse(x,y,forx,fory)
        }
        
        intensity = intensity_max*2
        intensity_dir = -1
        
        if not audio_is_playing(snd_launch_pad) and not net_manager.match_countdown and not net_manager.starting_match and dude.launch_pad_counter <= dude.launch_pad_threshold
        {
            dude.launch_pad_counter++
            audio(snd_launch_pad,0.75)
        }
    }
}

///launch players

for (var i=0; i<instance_number(player); i++)
{
    dude = instance_find(player,i)
    if instance_place(x,y,dude)
    {
        launch_angle = image_angle+90 mod 360
        
        if launch_angle > 270
        launch_angle -= 360
        
        //printf("launch_angle_before = "+launch_angle)
        
        //add some more verticality to the launch
        launch_angle = lerp_real(launch_angle,90,0.5)
        
        //printf("launch_angle REAL = "+launch_angle)
        
        dude.id.hsp = trigx(launch_speed,launch_angle)
        dude.id.vsp = trigy(launch_speed,launch_angle)
        
        intensity = intensity_max*2
        intensity_dir = -1
        
        if not audio_is_playing(snd_launch_pad) and not net_manager.match_countdown and not net_manager.starting_match
            audio(snd_launch_pad,1)
    }
}

///launch tossables

for (var i=0; i<instance_number(tossable_generic); i++)
{
    tossable = instance_find(tossable_generic,i)
    if instance_place(x,y,tossable)
    {
        tossable.id.have_hit_target = true
        launch_angle = image_angle+90 mod 360
        
        if launch_angle > 270
        launch_angle -= 360
        
        //printf("launch_angle_before = "+launch_angle)
        
        //add some more verticality to the launch
        launch_angle = lerp_real(launch_angle,90,0.5)
        
        //printf("launch_angle REAL = "+launch_angle)
        
        tossable.id.hsp = trigx(launch_speed,launch_angle)
        tossable.id.vsp = trigy(launch_speed,launch_angle)
        
        intensity = intensity_max*2
        intensity_dir = -1
        
        if not audio_is_playing(snd_launch_pad)
            audio(snd_launch_pad,1)
    }
}

