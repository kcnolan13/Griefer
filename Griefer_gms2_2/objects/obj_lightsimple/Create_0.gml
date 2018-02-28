
color = make_color_rgb(random(255),random(255),random(255));
intensity = 0//choose(0, 0, random(1.5));

alpha_d = random(3.14);

light = glr_lightsimple_create(spr_light_mask_point, 0, x, y, color, 1 );
glr_light_set_scaling(light, 2, 2);


