///compute_falloff(bullet_obj,shot_range)
var bullet_obj = argument0
var shot_range = argument1

var xi, xf, yi, yf

if shot_range < objVarRead(bullet_obj,"falloff_x1")
{
    return 1
    /*xi = 0
    yi = 1
    xf = objVarRead(bullet_obj,"falloff_x1")
    yf = objVarRead(bullet_obj,"falloff_y1")*/
} else if shot_range < objVarRead(bullet_obj,"falloff_x2")
{
    xi = objVarRead(bullet_obj,"falloff_x1")
    xf = objVarRead(bullet_obj,"falloff_x2")
    yi = objVarRead(bullet_obj,"falloff_y1")
    yf = objVarRead(bullet_obj,"falloff_y2")
} else if shot_range < objVarRead(bullet_obj,"falloff_x3")
{
    xi = objVarRead(bullet_obj,"falloff_x2")
    xf = objVarRead(bullet_obj,"falloff_x3")
    yi = objVarRead(bullet_obj,"falloff_y2")
    yf = objVarRead(bullet_obj,"falloff_y3")
} else {
    return objVarRead(bullet_obj,"falloff_y3")
    /*xi = objVarRead(bullet_obj,"falloff_x3")
    xf = objVarRead(bullet_obj,"falloff_x3")
    yi = objVarRead(bullet_obj,"falloff_y3")
    yf = objVarRead(bullet_obj,"falloff_y3")*/
}

var falloff = (yf-yi)/(xf-xi)*(shot_range-xi)+yi//(1 - (shot_range-xi)/(xf-xi)*(yi-yf))

return falloff