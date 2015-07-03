///manage_meters()
if not instance_exists(net_manager.my_doll)
{
    printf("ERROR: manage_meters cannot find local player")
    return false
}

var guy = net_manager.my_doll

if getLength(meters) < 1
{
    printf("ERROR: manage_meters cannot seem to locate meters array")
}

var bdelay = 10
var birthmas = 10

for (var i=0; i<getLength(meters); i++)
{
    var ang = meter_ang_i - i*(meter_ang_dif/(getLength(meters)-1))
    var met = NO_HANDLE
    var met_x = guy.x+trigx(meter_radius,ang)
    var met_y = guy.y-36+trigy(meter_radius,ang)
    
    if not instance_exists(meters[i])
    {
        met = instance_create(met_x,met_y,modal_meter)
        meters[i] = met
        met.birth_delay = bdelay
        bdelay += birthmas
        
        met.meter_col_out = meter_col_outs[i]
        met.meter_col_in = meter_col_ins[i]
        met.meter_desc = meter_descs[i]
    }
    
    met = meters[i]
    
    met.x = met_x
    met.y = met_y
    
    if instance_exists(met)
    {
        if not met.fade_out
        {
            //keep each meter up-to-date with stats
            if i = METER_KDR
            {
                met.meter_val = truncate(varRead("kdr"),2)
                met.meter_val_places = 2
                if varRead("kills") > 0
                    met.meter_actual_percent = varRead("kills") / (varRead("kills")+varRead("deaths"))
                else    
                    met.meter_actual_percent = 0
            }
            else if i = METER_WL
            {
                met.meter_val = truncate(varRead("wl"),2)
                met.meter_val_places = 2
                if varRead("wins") > 0 or varRead("losses") > 0
                    met.meter_actual_percent = varRead("wins") / (varRead("wins")+varRead("losses"))
                else    
                    met.meter_actual_percent = 0
            }
            else if i = METER_PPL
            {
                met.meter_val_places = 0
                met.meter_val = truncate(varRead("ppl"),0)
                met.meter_actual_percent = varRead("ppl") / ppl_max
            }
            else if i = METER_RANK
            {
                met.meter_val = varRead("rank")
                if global.num_ranks > -1 and varRead("rank") > -1
                    met.meter_actual_percent = varRead("rank")/global.num_ranks
                else    
                    met.meter_actual_percent = 0
            }
        }
    }
    else
    {
        printf("ERROR: something went wrong with handles in manage_meters")
        return false
    }
    
}
