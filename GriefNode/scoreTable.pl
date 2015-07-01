
#load modules
use DBI;
use Math::Round;
use Math::Trig;
#use warnings;
use Time::HiRes;
use LWP::UserAgent;
use POSIX qw(ceil floor);

use Math::Trig ':pi';


#---- GLOBAL VARS ----#
$fNameTemp = "/home/kyle/www/html/games/temp_scores.html";
$fName = "/home/kyle/www/html/games/griefer/leaderboards.html";

#print("opening $fNameTemp\n");
open (TEMP, ">", $fNameTemp) or die("ERROR: unable to create $fNameTemp\n");
#print("output files opened\n");

@scores;

open (SCORES, "/home/kyle/www/html/kServer/griefer_stats_raw.txt") or die("could not open raw stats");

$counter = 0;

foreach $line (<SCORES>) {
    #print $line;
    $line =~ s/^\n//;
    @vals = split(" :: ",$line);

    $valc = 0;

    foreach (@vals) {
        if ($valc == 8) {
            last;
        }
        $scores[$counter][$valc] = $_;
        $valc++;
    }

    $counter++;
}

#---- BUILD THE ACTUAL HTML FILE ----#
print TEMP '<!DOCTYPE html> <html> <head> <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"> <meta name="apple-mobile-web-app-capable" content="yes"> <title>Griefer Leaderboards</title> <style type="text/css"> .datagrid table { border-collapse: collapse; text-align: left; width: 100%; } .datagrid {font: normal 12px/150% Geneva, Arial, Helvetica, sans-serif; background: #fff; overflow: hidden; border: 2px solid #652299; -webkit-border-radius: 9px; -moz-border-radius: 9px; border-radius: 9px; }.datagrid table td, .datagrid table th { padding: 6px 10px; }.datagrid table thead th {background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #652299), color-stop(1, #4D1A75) );background:-moz-linear-gradient( center top, #652299 5%, #4D1A75 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=\'#652299\', endColorstr=\'#4D1A75\');background-color:#652299; color:#FFFFFF; font-size: 13px; font-weight: bold; border-left: 1px solid #714399; } .datagrid table thead th:first-child { border: none; }.datagrid table tbody td { color: #4D1A75; border-left: 1px solid #E7BDFF;font-size: 14px;font-weight: normal; }.datagrid table tbody .alt td { background: #F4E3FF; color: #4D1A75; }.datagrid table tbody td:first-child { border-left: none; }.datagrid table tbody tr:last-child td { border-bottom: none; }.datagrid table tfoot td div { border-top: 1px solid #652299;background: #F4E3FF;} .datagrid table tfoot td { padding: 0; font-size: 12px } .datagrid table tfoot td div{ padding: 2px; }.datagrid table tfoot td ul { margin: 0; padding:0; list-style: none; text-align: right; }.datagrid table tfoot  li { display: inline; }.datagrid table tfoot li a { text-decoration: none; display: inline-block;  padding: 2px 8px; margin: 1px;color: #FFFFFF;border: 1px solid #652299;-webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #652299), color-stop(1, #4D1A75) );background:-moz-linear-gradient( center top, #652299 5%, #4D1A75 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=\'#652299\', endColorstr=\'#4D1A75\');background-color:#652299; }.datagrid table tfoot ul.active, .datagrid table tfoot ul a:hover { text-decoration: none;border-color: #4D1A75; color: #FFFFFF; background: none; background-color:#652299;}div.dhtmlx_window_active, div.dhx_modal_cover_dv { position: fixed !important; } </style>';
print TEMP '<div class="datagrid"><table><thead><tr><th></th><th>Username</th><th>Level</th><th>KDR</th><th>WLR</th><th>Wins</th><th>Losses</th><th>Kills</th><th>Deaths</th><th>Assists</th></tr></thead>';

print TEMP '<tbody>';

$playas = 0;
foreach (@scores)
{
    if ($playas%2 == 0)
    {
        print TEMP '<tr>';
    }   else
    {
        print TEMP '<tr class="alt">'
    }

    print TEMP '<td>'.($playas+1).'</td>';

    for ($i=0; $i<9; $i++)
    {
        print TEMP '<td>';

        if (($i != 2)&&($i != 3))
        {
            if ($i == 1)
            {
                print TEMP $scores[$playas][2];
            }
            else 
            {
                if ($i==0)
                {
                    print TEMP $scores[$playas][$i];
                } else {
                    print TEMP $scores[$playas][$i-1];
                }
            }
        } elsif ($i != 3) {
            $deaths = $scores[$playas][6];
            if ($deaths < 1) {
                $deaths = 1;
            }
            $kdr = nearest(.01,$scores[$playas][5]/$deaths);
            $kdr = sprintf("%1.2f",$kdr);
            print TEMP $kdr;
        } else {
            $wins = $scores[$playas][4];
            if ($wins < 1) {
                $wins = 1;
            }
            $wlr = nearest(.01,$scores[$playas][3]/$wins);
            $wlr = sprintf("%1.2f",$wlr);
            print TEMP $wlr;
        }
        
        print TEMP '</td>';
    }

    print TEMP '</tr>';

    $playas++;
}

print TEMP '</tbody></table></div></body></html>';

#temp build is now complete
close(TEMP);

#copy over the temp file to its permanent address
$result = `mv $fNameTemp $fName`;