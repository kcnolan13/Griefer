//
//  gm_transmitters.cpp
//
//  Created by Kyle Nolan on 5/3/2015.
//
#include "gm_transmitters.h"

void pkgOrSend(string emitString, string msgJSON)
{
	if (bigPkg == NULL)
	{
		//if (emitString == "obj_update")
			//console("emitting obj_update: "+msgJSON);
		current_socket->emit(emitString, msgJSON);
	}
	else {
		bigPkg->newEntry(msgJSON);
	}
	return;
}

GMEXPORT const void myPrintf(char *out)
{
	_lock.lock();
		string s(out);
	string res = "GMs: " + s;
	console(res);
	_lock.unlock();
}

GMEXPORT const double objUpdateStr(char * oid_string, char *netVar, char *value, double flag)
{
	_lock.lock();
	string msgJSON = objUpdateJSON(oid_string, netVar, value, flag);
	pkgOrSend("obj_update", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double objUpdateReal(char * oid_string, char *netVar, double value, double flag)
{
	_lock.lock();
	string msgJSON = objUpdateJSON(oid_string, netVar, value, flag);
	//console("json prepared: " + msgJSON);
	pkgOrSend("obj_update", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double objCreate(double object_index, char *uniqueId, double myX, double myY)
{
	_lock.lock();
	string msgJSON = objCreateJSON(object_index, uniqueId, myX, myY);
	pkgOrSend("obj_create", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double pkgCreate()
{
	_lock.lock();
	if (bigPkg != NULL)
	{
		console("ERROR: PKG CREATE: pkg already exists");
		return 0;
	}
	else {
		//console("creating pkg!");
		bigPkg = new pkg();
	}
	_lock.unlock();
}
GMEXPORT const double pkgSend()
{
	_lock.lock();
	if (bigPkg == NULL)
	{
		//console("ERROR: PKG SEND: no existing package to send");
		_lock.unlock();
		return 0;
	}
	else {
		bigPkg->closePkg();
		//console("sending pkg: " + bigPkg->json);
		current_socket->emit("pkg", bigPkg->json);
		delete bigPkg;
		bigPkg = NULL;
		_lock.unlock();
		return 0;
	}
	
}
GMEXPORT const double statUpdateReal(char *stat, double value, double flag)
{
	_lock.lock();
	string obj = "{" + field("name", "statUpdate") + ", " + field("netvar", stat) + ", " + field("val", value) + ", " + field("flag", flag) + "}";
	current_socket->emit("stat_update", obj);
	_lock.unlock();
	return 0;
}
GMEXPORT const double statUpdateStr(char *stat, char *value, double flag)
{
	_lock.lock();
	string obj = "{" + field("name", "statUpdate") + ", " + field("netvar", stat) + ", " + field("val", value) + ", " + field("flag", flag) + "}";
	//console("\nprepared stat update: \n\t" + obj);
	current_socket->emit("stat_update", obj);
	_lock.unlock();
	return 0;
}
GMEXPORT const double otherPlayerStatUpdateReal(char *player_name, char *stat, double value, double flag)
{
	_lock.lock();
	string obj = "{" + field("name", "otherPlayerStatUpdate") + ", " + field("netvar", stat) + ", " + field("val", value) + ", " + field("flag", flag) + "}";
	current_socket->emit("other_player_stat_update", obj);
	_lock.unlock();
	return 0;
}
GMEXPORT const double otherPlayerStatUpdateStr(char *player_name, char *stat, char *value, double flag)
{
	_lock.lock();
	string obj = "{" + field("name", "otherPlayerStatUpdate") + ", " + field("netvar", stat) + ", " + field("val", value) + ", " + field("flag", flag) + "}";
	current_socket->emit("other_player_stat_update", obj);
	_lock.unlock();
	return 0;
}
GMEXPORT const double sendGenMessageStr(char *message_string, char *value)
{
	_lock.lock();
	string msgJSON = genMessageJSON(message_string, value);
	pkgOrSend("general_message", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double sendGenMessageReal(char *message_string, double value)
{
	_lock.lock();
	string msgJSON = genMessageJSON(message_string, value);
	pkgOrSend("general_message", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double sendBigMessageStr(char *message_string, char *value1, char *value2, char *value3)
{
	_lock.lock();
	string msgJSON = bigMessageJSON(message_string, value1, value2, value3);
	pkgOrSend("big_message", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double sendBigMessageReal(char *message_string, double value1, double value2, double value3)
{
	_lock.lock();
	string msgJSON = bigMessageJSON(message_string, value1, value2, value3);
	pkgOrSend("big_message", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double sendBigMessageStrReal(char *message_string, char  *value1, double value2, double value3)
{
	_lock.lock();
	string msgJSON = bigMessageJSON(message_string, value1, value2, value3);
	pkgOrSend("big_message", msgJSON);
	_lock.unlock();
	return 0;
}
GMEXPORT const double sendBigMessageStrReal2(char *message_string, char  *value1, char *value2, double value3)
{
	_lock.lock();
	string msgJSON = bigMessageJSON(message_string, value1, value2, value3);
	pkgOrSend("big_message", msgJSON);
	_lock.unlock();
	return 0;
}

GMEXPORT const double startMatchMaking(char * gameMode)
{
	_lock.lock();
	string gm(gameMode);
	//console("joining " + gm + " lobby");
	current_socket->emit("start_matchmaking", gm);
	_lock.unlock();
	return 0;
}
GMEXPORT const double leaveMatchMaking()
{
	_lock.lock();
	//console("leaving matchmaking");
	current_socket->emit("cancel_matchmaking");
	_lock.unlock();
	return 0;
}
GMEXPORT const double authenticate(char * username, char *password)
{
	_lock.lock();
	console("authenticating");
	string msg = "{" + field("username", username) + ", " + field("password", password) + "}";
	current_socket->emit("authenticate", msg);
	_lock.unlock();
	return 0;
}
GMEXPORT const double createUser(char * username, char *password)
{
	_lock.lock();
	string msg = "{" + field("username", username) + ", " + field("password", password) + "}";
	current_socket->emit("create_user", msg);
	_lock.unlock();
	return 0;
}
GMEXPORT const double logIn(char * username)
{
	_lock.lock();
	console("emitting logIn");
	current_socket->emit("login_player", username);
	_lock.unlock();
	return 0;
}
GMEXPORT const double logOut()
{
	_lock.lock();
	current_socket->emit("disconnect");
	_lock.unlock();
	return 0;
	//h.close();
	//current_socket->~socket();
}

GMEXPORT const double setGppDebug(double value)
{
	if (value != 0)
	{
		debug = true;
	}
	else {
		debug = false;
	}
	return 1;
}