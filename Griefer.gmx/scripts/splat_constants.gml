///splat_constants(seed)
var seed = argument0

random_set_seed(seed)

var num_splats = 5
var off = 50
var alpha_min = 0.5     var alpha_max = 1.25
var scale_min = 0.25    var scale_max = 1.5
var sub_min = 0         var sub_max = 4.99
var rot_min = 0         var rot_max = 360

for (var i=0; i<num_splats; i++)
{
    global.splat_scales[i] = random_range(scale_min,scale_max)
    global.splat_alphas[i] = random_range(alpha_min,alpha_max)
    global.splat_subs[i] = floor(random_range(sub_min,sub_max))
    global.splat_rots[i] =   random_range(rot_min,rot_max)
    global.splat_xoffs[i] = random_range(-1*off,off)
    global.splat_yoffs[i] = random_range(-1*off,off)
}   

randomize()
