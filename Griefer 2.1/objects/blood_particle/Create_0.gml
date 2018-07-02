/// @description create logic

if not truthval(global.gc[GC_VIOLENT_CONTENT,1]) or not truthval(global.gc[GC_PARTICLES,1])
{
    alarm[0] = 1
    visible = false
    exit
}

alpha = 0.25
sprite = spr_blood2
intensity = 0.25

xscale = random_range(0.05,0.5)
//make it tougher to get big ones
if xscale > 0.3
    xscale = random_range(0.05,0.5)
    
yscale = xscale//random_range(xscale-0.1,xscale+0.1)
grav = 2
hsp = 0
vsp = 0
counter = 0
rot = random(360)
blend = c_red//make_color_rgb(70,0,0)
destroy = 0
trailing = false
trailing_counter = 0
trailing_counter_max = 30*1.5
fade = 0
grav_original = -1
splatted = false

