///manage_meters()
if not instance_exists(net_manager.stat_gravatar)
{
    printf("ERROR: manage_meters cannot find stat_gravatar")
    return false
}

if not varRead("kills_valid") or not varRead("deaths_valid") or not varRead("wins_valid") or not varRead("losses_valid") or not varRead("points_valid")
{
    printf("WARNING: cannot manage_meters yet -- some required stats have not been validated")
    return false
}

var guy = net_manager.stat_gravatar

if getLength(meters) < 1
{
    printf("ERROR: manage_meters cannot seem to locate meters array")
}

if not instance_exists(history_chart)
{
    history_chart = instance_create(WVIEW/2-32,HVIEW/2+64*1.75,modal_stat_history)
    history_chart.birth_delay = 20
}

var bdelay = 3
var birthmas = 3

var met_xst = WVIEW/2-history_chart.width/2-32
var met_yst = 64*2+32

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
    
    met.x = met_xst
    met_xst += 64*2.25
    met.y = met_yst
    
    if instance_exists(met)
    {
        if not met.fade_out
        {
            //keep each meter up-to-date with stats
            if i = METER_KDR
            {
                var temp_kdr = truncate(varRead("kdr"),2)//truncate(varRead("kills") / max(1,varRead("deaths")),2)
                //printf("::: kdr="+string(varRead("kdr"))+", temp_kdr="+string(temp_kdr))
                varWrite("kdr",temp_kdr)
                met.meter_val = varRead("kdr")
                met.meter_val_places = 2
                if varRead("kills") > 0
                    met.meter_actual_percent = varRead("kills") / (varRead("kills")+varRead("deaths"))
                else    
                    met.meter_actual_percent = 0
            }
            else if i = METER_WL
            {
                varWrite("wl",truncate(varRead("wl"),2))
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

var xst = room_width*3/4+32
var xst_original = xst
var yst = 72+20
var xsep = 128
var ysep = 120

var w = 64*3
var h = 36

{

    bdelay = bdelay
    birthmas = 1
    
    yst += ysep*1.75
    
    for (var i=0; i<getLength(pstats); i++)
    {
        if not instance_exists(pstat_labels[i])
        {
            lab = instance_create(xst-48,yst,bn_slabel)
            
            //the stat title!
            lab.header_text = capwords_super(pstats[i])+":"
            
            if pstats[i] = "time"
            {
                lab.header_text = global.time_played
            }
            
            printf("::: lab text: "+string(lab.header_text))
            lab.text_color = c_white
            lab.label = lab.header_text
            lab.birth_delay = bdelay
            bdelay += birthmas
            pstat_labels[i] = lab
            pstat_vals[i] = lab
            lab.color = web_hsv(235,50,50)
            
            //the stat value!
            strval = string(varRead(pstats[i]))
            if pstats[i] = "time"
            {
                printf("::: Time Stat [in manage meters]: "+string(real(varRead("time"))))
                strval = time_ms_2string(real(varRead("time")),true)
                printf("::: time string: "+strval)
            }
            lab.text = strval
        }
        
        xst += ysep
        
        if (i+1) mod 3 = 0
        {
            yst += ysep
            xst = xst_original
        }
            
        lab = pstat_vals[i]
        //keep vals up-to-date
        if instance_exists(lab)
        {
            strval = string(varRead(pstats[i]))
            if pstats[i] = "time"
                strval = time_ms_2string(real(varRead("time")),true)
            lab.text = strval 
        }
    }

}
