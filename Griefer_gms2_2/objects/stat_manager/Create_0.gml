/// @description init
stat_flag = FL_NORMAL
ts = NO_HANDLE

grav_name = "GoshDarnNoOne"
grav_ready = false

netvars = ds_map_create()

time_match_start = 0
time_match = 0
time_match_end = 0
time_match_total = 0

tabs[0] = "Competitive"
tabs[1] = "Bot Mode"
tabs[2] = "Leaderboards"

stat_tab = tabs[0]

wiped = false

//history chart
history_chart = NO_HANDLE
history_chart_width = 64*7
history_chart_height = 64*5

//working copy of YOUR stats to be displayed on the stats page
varWrite("ppl",-1)
varWrite("kdr",-1)
varWrite("wl",-1)
varWrite("kills",-1)
varWrite("deaths",-1)
varWrite("assists",-1)
varWrite("wins",-1)
varWrite("losses",-1)
varWrite("kill_streak",-1)
varWrite("win_streak",-1)
varWrite("global_rank",-1)
varWrite("rank",-1)
varWrite("xp",-1)
varWrite("time",-1)
varWrite("points",-1)
varWrite("true_skill",-1)

//arrays for YOUR personal stat labels
pstats[PSTAT_KILLS] = "kills"
pstats[PSTAT_DEATHS] = "deaths"
pstats[PSTAT_ASSISTS] = "assists"
pstats[PSTAT_WINS] = "wins"
pstats[PSTAT_LOSSES] = "losses"
pstats[PSTAT_KILL_STREAK] = "kill_streak"
pstats[PSTAT_WIN_STREAK] = "win_streak"
pstats[PSTAT_TIME] = "time"
pstats[PSTAT_TSKILL] = "true_skill"

len = getLength(pstats)

pstat_labels[len-1] = -5

for (var i=0; i<len; i++)
{
    pstat_labels[i] = NO_HANDLE
}

pstat_vals[len-1] = -5
for (var i=0; i<len; i++)
{
    pstat_vals[i] = NO_HANDLE
}

pstat_pname = NO_HANDLE
pstat_title = NO_HANDLE
leaderboards_title = NO_HANDLE

//used for kdr, wl, ppl computations
varWrite("kdr_history","")
varWrite("ppl_history","")
varWrite("win_history","")
varWrite("kills_valid",false)
varWrite("deaths_valid",false)
varWrite("assists_valid",false)
varWrite("wins_valid",false)
varWrite("losses_valid",false)
varWrite("points_valid",false)
update_kdr = true
update_wl = false
update_ppl = false

update_flag = FL_COMPETITIVE

ppl_max = POINTS_KILL*10

//meters
meters[METER_KDR] = NO_HANDLE
meters[METER_WL] = NO_HANDLE
meters[METER_PPL] = NO_HANDLE
meters[METER_RANK] = NO_HANDLE

meter_stats[METER_KDR] = "kdr"
meter_stats[METER_WL] = "wl"
meter_stats[METER_PPL] = "ppl"
meter_stats[METER_RANK] = "rank"

meter_col_outs[METER_KDR] = web_hsv(0,100,100)
meter_col_outs[METER_WL] = web_hsv(207,100,100)
meter_col_outs[METER_PPL] = web_hsv(149,100,100)
meter_col_outs[METER_RANK] = web_hsv(0,0,0)

meter_col_ins[METER_KDR] = web_hsv(0,100,100)
meter_col_ins[METER_WL] = web_hsv(207,100,100)
meter_col_ins[METER_PPL] = web_hsv(149,100,100)
meter_col_ins[METER_RANK] = web_hsv(0,0,0)

meter_descs[METER_KDR] = "KDR"
meter_descs[METER_WL] = "W/L"
meter_descs[METER_PPL] = "PPL"
meter_descs[METER_RANK] = global.tskill

meter_radius = 64*3.5
meter_swath = 135
meter_ang_i = 90+meter_swath/2
meter_ang_f = 90-meter_swath/2
meter_ang_dif = abs(meter_ang_i - meter_ang_f)

