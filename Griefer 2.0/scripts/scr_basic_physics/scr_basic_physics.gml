/// @description basic physics
if collision_rectangle(bbox_left,bbox_top+2,bbox_right,bbox_bottom-2,block,true,true) and not slide_left and not slide_right
    scr_unstick_guy()

//sync up x and y
x = varRead("myX")
y = varRead("myY")

var xbefore = x
var ybefore = y

gfric_max = 2

if (hsp > 1000) or vsp > 1000
{
    printf("ERROR: object's speed is too large to be processed by basic_physics")
    return false
}

was_standing = false
sthresh = 5
if continue_standing or collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+sthresh,block,true,false) or collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+sthresh,block2_top,true,false) or standing_2way
{
    was_standing = true
    continue_standing = false
}
//position adjustment based on hsp and vsp
scr_pixel_horizontal(2)

standing_2way = false

floating_2way = false
scr_compute_floating()

if vsp<0
    scr_pixel_vertical(8) //8 pixels in advance jumping collision checking because of too many glitches
else
    scr_pixel_vertical(2) //normal collision checking (original script)

//maximum pull-up px distance onto nearby platform
scr_pull_up(36)

if !position_meeting(x,bbox_bottom+1,block)
{
    if object_index = player
    {
        //player must not be sliding for this gravity to take effect
        if slide_right = 0 && slide_left = 0
            grav = 2
    }
    else grav = 2
    
    if vsp < 40 and not in_snare(id)
        vsp += real_speed(grav)
}

//friction --> only if local player!
if object_index != player or myPlayer() = id
{
    //original friction code
    if position_meeting(x,bbox_bottom+3,block) || standing_2way = true
    {
        grav = 0
        if not rolling and not input_check(mapped_control(C_MOVE_LEFT)) and not input_check(mapped_control(C_MOVE_RIGHT))
        {
            gfric = 1
            //make sure you don't damp past zero
            if abs(hsp) <= 2
            {
                if abs(hsp) <= 0.5
                hsp = 0
                else
                hsp /= 2
            }
            //damp
            if hsp>0
            hsp -= real_speed(gfric)
            if hsp<0
            hsp += real_speed(gfric)
            //exit
        }
    }
        
    //code that might help with frictional problems for slanted surfaces
    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+5,block,true,true) || standing_2way = true
    {
        in_air = false
        grav = 0
        if not rolling and not input_check(mapped_control(C_MOVE_LEFT)) and not input_check(mapped_control(C_MOVE_RIGHT))
        {
            gfric = gfric_max
            //make sure you don't damp past zero
            if abs(hsp) <= 2
            {
                if abs(hsp) <= 0.5
                hsp = 0
                else
                hsp /= 2
            }
            //damp
            if hsp>0
            hsp -= real_speed(gfric)
            if hsp<0
            hsp += real_speed(gfric)
            //exit
        }
    }
    else 
    {
        gfric = 0
        in_air = true
    }
}

//sync up myX and myY again
varWrite("myX",x)
varWrite("myY",y)
varAdd("myX_true",x-xbefore)
varAdd("myY_true",y-ybefore)
