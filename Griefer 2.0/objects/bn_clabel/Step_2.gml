/// @description fade out if no cedit
event_inherited()

if not instance_exists(myCedit)
    fade_out = true
    
if text = global.cactions[C_SWAP_STICKS]
{
    if global.using_gamepad
    {
        if not visible
        {
            scale = 0.25
            alpha = 0
        }  
        visible = true
    }
    else
    {
        visible = false
    }
}

