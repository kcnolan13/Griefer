
color = make_color_rgb(random(255),random(255),random(255));
intensity = choose(0, random(1.5));
sprite = spr_light_mask_point;
light = glr_light_create(sprite, 0, x, y, color, intensity);
rot = 0;
glr_light_set_shadow_strength(light, 0.6)
glr_light_set_static(light, true);
glr_light_set_layer(light, 2);

