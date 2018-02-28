
color = make_color_rgb(random(255),random(255),random(255));
intensity = random_range(1,2);
sprite = spr_light_mask_spot;
scale = random_range(0.5,1)
light = glr_lightsimple_create(sprite, 0, x, y,color, 1);
rot = 270
glr_lightsimple_set_scaling(light,scale,scale)
glr_lightsimple_set_position(light,x,y)
glr_lightsimple_set_rotation(light,rot)

