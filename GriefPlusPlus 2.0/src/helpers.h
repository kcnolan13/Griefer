//
//  helpers.h
//
//  Created by Kyle Nolan on 5/4/2015
//

#ifndef HELPERS_H
#define HELPERS_H

#include "sio_client.h"
#include <string>
#include <functional>
#include <thread>
#include <mutex>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <condition_variable>
#include <deque>

#define GENVAL_DNULL -9999

#if defined(_WIN32)
# define WIN32_LEAN_AND_MEAN
#define GMEXPORT extern "C" __declspec ( dllexport )
# include <windows.h>
# include <stdio.h>
# include <tchar.h>
#else
# define GMEXPORT extern "C"
#endif

//---- GLOBALS ----//
using namespace sio;
using namespace std;

extern string retString;
extern bool debug;
extern bool integrityCheck;
extern string serverURL;
extern double alive;

class genVal
{
public:
	string sVal;
	double dVal;
	bool isString;
	genVal();
	genVal(string strVal);
	genVal(double dubVal);
};

void console(string output);
void popup(string output);
string dubString(double val);
string dubString(int val);
string dubString(float val);

double getMapReal(message::ptr const& data, string key);
string getMapString(message::ptr const& data, string key);
genVal getMapGenVal(message::ptr const& data, string key);
string snatchFront(deque<string> *deck);
double snatchFront(deque<double> *deck);
string snatchGenValFrontStr(deque<genVal> *deck);
double snatchGenValFrontReal(deque<genVal> *deck);
string peakGenValFrontType(deque<genVal> *deck);
string readGenValType(genVal val);
double messagesWaiting(deque<string> *deck);
double messagesWaiting(deque<double> *deck);
double messagesWaiting(deque<genVal> *deck);

double chopDeck(double chopTo, deque<string> *longer);
double chopDeck(double chopTo, deque<double> *longer);
double chopDeck(double chopTo, deque<genVal> *longer);

//JSON construction
string field(string name, const char *val);
string field(string name, double val);
string objUpdateJSON(char * oid_string, char * netVar, char *value, double flag);
string objUpdateJSON(char * oid_string, char * netVar, double value, double flag);
string objCreateJSON(double object_index, char *uniqueId, double myX, double myY);
string objHeaderJSON(string name, char * oid_string);
string genMessageJSON(char *message_string, const char *value);
string genMessageJSON(char *message_string, double value);
string bigMessageJSON(char *message_string, double value1, double value2, double value3);
string bigMessageJSON(char *message_string, const char *value1, const char *value2, const char *value3);
string bigMessageJSON(char *message_string, const char * value1, double value2, double value3);
string bigMessageJSON(char *message_string, const char * value1, char *value2, double value3);
#endif // __HELPERS_H__
