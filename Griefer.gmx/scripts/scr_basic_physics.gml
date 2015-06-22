///basic physics
if collision_rectangle(bbox_left,bbox_top+2,bbox_right,bbox_bottom-2,block,true,true) and not slide_left and not slide_right
scr_unstick_guy()

//sync up x and y
x = varRead("myX")
y = varRead("myY")

gfric_max = 2

//position adjustment based on hsp and vsp
    scr_pixel_horizontal(2)

    standing_2way = false
    
    floating_2way = false
    scr_compute_floating()
    
    if vsp<0
        scr_pixel_vertical(8) //8 pixels in advance jumping collision checking because of too many glitches
    else
        scr_pixel_vertical(2) //normal collision checking (original script)
        
    scr_pull_up(36)

    //if vsp < 0 && abs(vsp) < 5

//gravity and friction integration

    //gravity
    if !position_meeting(x,bbox_bottom+1,block)
    {
        if object_index = player
        {
            if slide_right = 0 && slide_left = 0
            grav = 2
        }
        else grav = 2
        
        if vsp < 40 and not in_snare(id)
        vsp += grav
    }
    
    //friction
    //original friction code
    if position_meeting(x,bbox_bottom+3,block) || standing_2way = true
    {
        grav = 0
        if not rolling and not keyboard_check(ord('A')) and not keyboard_check(ord('D'))
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
            hsp -= gfric
            if hsp<0
            hsp += gfric
            //exit
        }
    }
    
    //code that might help with frictional problems for slanted surfaces
    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+5,block,true,true) || standing_2way = true
    {
        grav = 0
        if not rolling and not keyboard_check(ord('A')) and not keyboard_check(ord('D'))
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
            hsp -= gfric
            if hsp<0
            hsp += gfric
            //exit
        }
    }
    else gfric = 0
    
    //sync up myX and myY again
    varWrite("myX",x)
    varWrite("myY",y)
    //don't put anything after this because there are "exits" in the friction code