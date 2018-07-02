obj = argument0

above = false
switch (obj.direction)
{
    case 315:
        if bbox_bottom <= obj.y+64-(x-obj.x) //&& bbox_bottom < obj.y+64-(bbox_left-obj.x)
            {above = true
            return true}
        else if (x-obj.x) > 64 && bbox_bottom <= obj.y
            {above = true
            return true}
        break
    
    case 225:
        if bbox_bottom <= obj.y+(x-obj.x) //&& bbox_bottom < obj.y+(bbox_right-obj.x)
            {above = true
            return true}
        else if (x-obj.x) <= 0 && bbox_bottom <= obj.y
            {above = true
            return true}
        break
        
    default:
        if bbox_bottom <= obj.y
        {above = true
        return true}
        break
}