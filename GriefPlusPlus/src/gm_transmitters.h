//
//  gm_transmitters.h
//
//  Created by Kyle Nolan on 5/3/2015
//

#ifndef GM_TRANSMITTERS_H
#define GM_TRANSMITTERS_H

#include "sio_client.h"
#include "receivers.h"
#include <string>
#include <functional>
#include <windows.h>
#include <thread>
#include <mutex>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <condition_variable>
#include <deque>

void pkgOrSend(string emitString, string msgJSON);

GMEXPORT const void myPrintf(char *out);

GMEXPORT const double objUpdateStr(char * oid_string, char *netVar, char *value, double flag);
GMEXPORT const double objUpdateReal(char * oid_string, char *netVar, double value, double flag);
GMEXPORT const double objCreate(double object_index, double uniqueId, double myX, double myY);

GMEXPORT const double pkgCreate();
GMEXPORT const double pkgSend();

GMEXPORT const double statUpdateReal(char *stat, double value, double flag);
GMEXPORT const double statUpdateStr(char *stat, char *value, double flag);
GMEXPORT const double otherPlayerStatUpdateReal(char *player_name, char *stat, double value, double flag);
GMEXPORT const double otherPlayerStatUpdateStr(char *player_name, char *stat, char *value, double flag);
GMEXPORT const double sendGenMessageStr(char *message_string, char *value);
GMEXPORT const double sendGenMessageReal(char *message_string, double value);
GMEXPORT const double sendBigMessageStr(char *message_string, char *value1, char *value2, char *value3);
GMEXPORT const double sendBigMessageReal(char *message_string, double value1, double value2, double value3);
GMEXPORT const double sendBigMessageStrReal(char *message_string, char  *value1, double value2, double value3);

GMEXPORT const double startMatchMaking(char * gameMode);
GMEXPORT const double leaveMatchMaking();
GMEXPORT const double authenticate(char * username, char *password);
GMEXPORT const double createUser(char * username, char *password);
GMEXPORT const double logIn(char * username);
GMEXPORT const double logOut();

GMEXPORT const double setGppDebug(double value);

#endif // __GM_TRANSMITTERS_H__