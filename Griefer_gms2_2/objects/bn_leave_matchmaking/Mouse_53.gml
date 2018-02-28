/// @description leave match making
if not modal_highlighted(id) exit

if clicked exit
clicked = 2

audio(snd_click,1)
leave_matchmaking()
sendMessageStr("syncPlayersConnected",FL_NORMAL)

