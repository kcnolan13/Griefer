///manage_meters()
if not instance_exists(net_manager.stat_gravatar)
{
    printf("ERROR: manage_meters cannot find stat_gravatar")
    return false
}

var guy = net_manager.stat_gravatar

if getLength(meters) < 1
{
    printf("ERROR: manage_meters cannot seem to locate meters array")
}

if not instance_exists(history_chart) and instance_exists(pstat_title)
{
    history_chart = instance_create(pstat_title.x+64*2.25+history_chart_width/2,pstat_title.y+64*2+12+history_chart_height/2,modal_stat_history)
    history_chart.birth_delay = 20
}

var bdelay = 3
var birthmas = 3

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
                var temp_kdr = truncate(varRead("kdr"),2)
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

var xst = room_width*1/2
var yst = 72+64
var xsep = 128
var ysep = 40

var w = 64*3
var h = 36

bdelay = bdelay
birthmas = 1

//recreate title
if not instance_exists(pstat_title)
{
    tit = instance_create(xst+xsep/3-10,yst-24+15,bn_slabel)
    pstat_title = tit
    
    if stat_tab = tabs[0]
        tit.text = "Competitive   Stats"
    else
        tit.text = "Bot   Mode   Stats"
        
    tit.width = 64*8
    tit.height = 64
    tit.font = fnt_pstats_title
    tit.birth_delay = 2
    tit.text_color = c_dkgray
}

//recreate pname
if not instance_exists(pstat_pname)
{
    tit = instance_create(xst+xsep/3+64*5.9,yst-24+8,bn_slabel)
    pstat_pname = tit
    
    tit.text = capwords(objVarRead(guy,"pName"))
        
    tit.width = 64*8
    tit.height = 64
    tit.font = fnt_pname_title
    tit.birth_delay = 15
    tit.text_color = c_white
}

yst += ysep*1.75

for (var i=0; i<getLength(pstats); i++)
{
    if not instance_exists(pstat_labels[i])
    {
        lab = instance_create(xst-48,yst,bn_slabel)
        lab.text = capwords_super(pstats[i])+":"
        
        if pstats[i] = "time"
        {
            lab.text = global.time_played
        }
        
        printf("::: lab text: "+string(lab.text))
        lab.text_color = c_dkgray
        lab.width = w
        lab.height = h
        lab.label = lab.text
        lab.birth_delay = bdelay
        lab.font = fnt_pstats
        bdelay += birthmas
        pstat_labels[i] = lab
    }
    
    if not instance_exists(pstat_vals[i])
    {
        val = instance_create(xst+xsep,yst,bn_slabel)
        
        strval = string(varRead(pstats[i]))
        if pstats[i] = "time"
        {
            printf("::: Time Stat [in manage meters]: "+string(real(varRead("time"))))
            strval = time_ms_2string(real(varRead("time")),true)
            printf("::: time string: "+strval)
        }
        val.text = strval
        printf("::: val text: "+string(val.text))
        
        val.text_color = c_black
        val.width = w
        val.height = h
        val.label = val.text
        val.font = fnt_pstats
        val.birth_delay = bdelay
        bdelay += birthmas
        pstat_vals[i] = val
    }
    
    yst += ysep
    val = pstat_vals[i]
    //keep vals up-to-date
    if instance_exists(val)
    {
        strval = string(varRead(pstats[i]))
        if pstats[i] = "time"
            strval = time_ms_2string(real(varRead("time")),true)
        val.text = strval
        val.label = val.text   
    }
}
