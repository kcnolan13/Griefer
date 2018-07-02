/// @description initialize!
counter = 0
color = make_color_rgb(255,50,50)
intensity = 1.25
sprite = spr_light_mask_spot;
scale = random_range(0.5,1)
rot = 270
muzzle_length = 25

ID = instance_place(x,y,col_generic)
if instance_exists(ID)
    color = ID.col
    
ID = instance_place(x,y,intensity_generic)
if instance_exists(ID)
    intensity = ID.intensity
    
myLight = noone

