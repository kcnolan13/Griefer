/// @description adjust image index depending on cursor location
image_speed = 0

if cursor.x > bbox_left and cursor.x < bbox_right and cursor.y > bbox_top and cursor.y < bbox_bottom
{
    if image_index = 0
        audio(snd_scroll2,1)
    image_index = 1
    txt_alpha = 1
    txt_scale = 1.1
}
else
{
        
    image_index = 0
    if not active
    {
        txt_alpha = txt_alpha_min
        txt_scale = 1
    }
}

if clicked
    clicked --

