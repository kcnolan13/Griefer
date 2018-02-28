color = make_color_rgb(random(255),random(255),random(255));
intensity = 0//choose(0, 0, random(1.5));
sprite = spr_light_mask_point;
light = glr_light_create(sprite, 0, x, y, color, intensity );
rot = 0;
scal = random_range(1,1.5);
glr_light_set_scaling(light, scal,scal);
glr_light_set_layer(light, 1);
glr_light_set_shadow_strength(light, 0.6);

