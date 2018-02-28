/// @description fix disappearing lights
counter++

if counter = 30
{
    myLight = glr_lightsimple_create(sprite, 0, x+trigx(muzzle_length,rot), y+trigy(muzzle_length,rot),color, 1);
    glr_lightsimple_set_rotation(myLight,rot)
    glr_lightsimple_set_scaling(myLight,scale,scale)
}

if counter > 30
{
    if counter % 1 = 0
    {
        printf("recreating light")
        
        //if glr_light_get_active(myLight)
            //glr_lightsimple_destroy(myLight)
            
        //myLight = glr_lightsimple_create(sprite, 0, x, y,color, 1, intensity);
    }
    //glr_lightsimple_set_scaling(myLight,scale,scale)
    //glr_lightsimple_set_position(myLight,x+trigx(muzzle_length,rot),y+trigy(muzzle_length,rot))
    //glr_lightsimple_set_rotation(myLight,rot)
}

