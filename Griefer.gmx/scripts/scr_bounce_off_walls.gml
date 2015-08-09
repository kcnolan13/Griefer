bounce_type = argument0
bounce_obj = argument1

//room_speed = 1
if bounce_obj.object_index = block2_top
scr_move_contact_object(block2_top,direction+180,speed,1)
else
scr_move_contact_object(block,direction+180,speed,1)

x += trigx(1,direction)
y += trigy(1,direction)

if bounce_obj.object_index = block2_top
normal = scr_normal_detect(x,y,block2_top,sprite_width/1.5,1)
else
normal = scr_normal_detect(x,y,block,sprite_width/1.5,1)

direction = normal + (normal - (direction+180))
//bounce_counter ++

if bounce_obj.object_index = block2_top
scr_move_contact_object(block2_top,direction,speed,1)
else
scr_move_contact_object(block,direction,speed,1)

switch string(bounce_type)
{
    case "decay":
        /*if object_index = bullet_fragment
        {speed = 40+random(40) if bounce_counter < 2 bounce_counter = 2}*/
        
        //audio_play_sound_at(snd_plasma_wall,mister_dj.x-x,y-mister_dj.y,0,weapon_falloff_ref,weapon_falloff_dist,1,false,4)
        //if bounce_counter > 3
        instance_destroy()
        break
        
    case "tossable":
         //audio_play_sound_at(sound_land,mister_dj.x-x,y-mister_dj.y,0,movement_falloff_ref,movement_falloff_dist,1,false,4)
        speed = speed/3
        break
        
    case "fragment":
        for (i=-25;i<=25;i+=50)
        {
            //audio_play_sound_at(snd_plasma_wall,mister_dj.x-x,y-mister_dj.y,0,weapon_falloff_ref,weapon_falloff_dist,1,false,4)
            /*ID = instance_create(x,y,bullet_fragment)
            ID.direction = direction+i
            ID.image_angle = ID.direction
            ID.speed = 40+random(40)
            ID.friendly = friendly*/
        }
        instance_destroy()
        break

}
