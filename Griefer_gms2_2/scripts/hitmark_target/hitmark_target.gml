/// @description hitmark_target(bullet,target)
/// @function hitmark_target
/// @param bullet
/// @param target
//MUST HAVE bullet x and y synched with myX and myY for this to work

var bullet = argument0
var target = argument1

var xpos = objVarRead(bullet,"myX")
var ypos = objVarRead(bullet,"myY")

have_hit_target = true

if DEBUG
{
    var marker = instance_create_for_everyone(xpos,ypos,hit_marker)
    if target.object_index = player
    {
        target.bullet_temp = bullet
        target.marker_temp = marker
        with (target)
        {
            if in_head(bullet_temp)
                objVarWrite(marker_temp,"image_blend",c_red)
            else
                objVarWrite(marker_temp,"image_blend",c_white)
        }
        
    }
    
    //update the marker params for everyone
    obj_update_real(marker,"image_blend",FL_NORMAL)
}