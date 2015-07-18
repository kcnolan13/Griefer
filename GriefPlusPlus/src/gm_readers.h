//
//  gm_readers.h
//
//  Created by Kyle Nolan on 5/3/2015
//

#ifndef GM_READERS_H
#define GM_READERS_H

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

GMEXPORT const double isString(char *type);

GMEXPORT const double genMessagesWaiting();
GMEXPORT const char * readGenMessage();
GMEXPORT const char * readGenValType();
GMEXPORT const char * readGenValStr();
GMEXPORT const double readGenValReal();

GMEXPORT const double bigMessagesWaiting();
GMEXPORT const char * readBigMessage();
GMEXPORT const char * readBigValType(double val_num);
GMEXPORT const char * readBigValStr(double val_num);
GMEXPORT const double readBigValReal(double val_num);
deque<genVal> * bigValDeque(double val_num);

GMEXPORT const double objUpdatesWaiting();
GMEXPORT const double readObjUpdateIndex();
GMEXPORT const double readObjUpdateUniqueId();
GMEXPORT const char * readObjUpdateOidStr();
GMEXPORT const char * readObjUpdateNetvar();
GMEXPORT const char * readObjUpdateValType();
GMEXPORT const char * readObjUpdateValStr();
GMEXPORT const double readObjUpdateValReal();
GMEXPORT const double readObjUpdateFlag();

GMEXPORT const double objCreatesWaiting();
GMEXPORT const double readObjCreateIndex();
GMEXPORT const double readObjCreateUniqueId();
GMEXPORT const double readObjCreateMyX();
GMEXPORT const double readObjCreateMyY();

GMEXPORT const double hash_string(char *str);


#endif // __GM_READERS_H__