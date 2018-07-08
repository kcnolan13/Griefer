//
//  receivers.h
//
//  Created by Kyle Nolan on 5/3/2015
//

#ifndef RECEIVERS_H
#define RECEIVERS_H

#include "sio_client.h"
#include "helpers.h"

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

#if defined(_WIN32)
#include <windows.h>
#endif

using namespace sio;
using namespace std;

class object_update_container
{
public:
	deque<double> *indices;
	deque<string> *uniqueIds;
	deque<string> *oid_strings;
	deque<string> *netvars;
	deque<genVal> *vals;
	deque<double> *flags;
	object_update_container();
};

class object_create_container
{
public:
	deque<double> *indices;
	deque<string> *uniqueIds;
	deque<double> *myXs;
	deque<double> *myYs;
	object_create_container();
};

class pkg
{
public:
	string json;
	pkg();
	bool is_empty;

	void firstEntry(string json_str);
	void nextEntry(string json_str);
	void closePkg();

	void newEntry(string json_str);
};

extern bool closeDown;
extern recursive_mutex _lock;
extern condition_variable_any _cond;
extern bool connect_finish;

class connection_listener
{
	sio::client &handler;

public:

	connection_listener(sio::client& h) :
		handler(h)
	{
	}

	void on_connected()
	{
		_lock.lock();
		_cond.notify_all();
		connect_finish = true;
		_lock.unlock();
	}

	void on_close(client::close_reason const& reason)
	{
		//std::cout << "sio closed " << std::endl;
		exit(0);
	}

	void on_fail()
	{
		//std::cout << "sio failed " << std::endl;
		exit(0);
	}
};


extern object_update_container *object_updates;
extern object_create_container *object_creates;
extern deque<string> *generalMessages;
extern deque<genVal> *generalValues;
extern deque<string> *bigMessages;
extern deque<genVal> *bigValues1;
extern deque<genVal> *bigValues2;
extern deque<genVal> *bigValues3;
extern pkg *bigPkg;
extern message::ptr myPlayer;

extern socket::ptr current_socket;
extern sio::client h;
extern connection_listener l;

void processObjUpdate(message::ptr const& message);
void processObjCreate(message::ptr const& message);
void processGeneralMessage(message::ptr const& message);
void processBigMessage(message::ptr const& message);

double maintainDeckIntegrity();

GMEXPORT const double objPushBackStr(char * oid_string, char *netVar, char *value, double flag);
GMEXPORT const double objPushBackReal(char * oid_string, char  *netVar, double value, double flag);


#endif // __RECEIVERS_H__