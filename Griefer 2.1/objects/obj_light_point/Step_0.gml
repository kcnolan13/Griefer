rot += delta_time/10000;
x = xstart + lengthdir_x(10,rot);
y = ystart + lengthdir_y(10,rot);
glr_light_set_position(light, x, y);
glr_light_set_rotation(light, rot);

