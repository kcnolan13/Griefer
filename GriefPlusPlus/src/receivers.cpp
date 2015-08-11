//
//  receivers.cpp
//
//  Created by Kyle Nolan on 5/3/2015.
//
#include "receivers.h"

object_update_container::object_update_container()
{
	indices = new deque<double>();
	uniqueIds = new deque<double>();
	oid_strings = new deque<string>();
	netvars = new deque<string>();
	vals = new deque<genVal>();
	flags = new deque<double>();
}

object_create_container::object_create_container()
{
	indices = new deque<double>();
	uniqueIds = new deque<double>();
	myXs = new deque<double>();
	myYs = new deque<double>();
}

pkg::pkg()
{
	json = "[";
	is_empty = true;
}

void pkg::firstEntry(string json_str)
{
	json += json_str;
	is_empty = false;
}
void pkg::nextEntry(string json_str)
{
	json += "," + json_str;
}
void pkg::newEntry(string json_str)
{
	if (is_empty)
		firstEntry(json_str);
	else
		nextEntry(json_str);
}

void pkg::closePkg()
{
	json += "]";
	//console("pkg prepared for blastoff: " + json);
}

object_update_container *object_updates = new object_update_container();
object_create_container *object_creates = new object_create_container();
deque<string> *generalMessages = new deque<string>();
deque<genVal> *generalValues = new deque<genVal>();
deque<string> *bigMessages = new deque<string>();
deque<genVal> *bigValues1 = new deque<genVal>();
deque<genVal> *bigValues2 = new deque<genVal>();
deque<genVal> *bigValues3 = new deque<genVal>();

pkg *bigPkg = NULL;
socket::ptr current_socket;
bool connect_finish = false;
recursive_mutex _lock;
condition_variable_any _cond;
sio::client h;
connection_listener l(h);
message::ptr myPlayer;
bool closeDown = false;

double maintainDeckIntegrity()
{
	//console("{O}: checking deck integrity");
	size_t minsize = 10000000000;
	bool corrupted = false;

	if (object_updates->flags->size() < minsize) {
		minsize = object_updates->flags->size();
		if (minsize != object_updates->oid_strings->size())
			corrupted = true;
	}

	if (object_updates->oid_strings->size() < minsize) {
		minsize = object_updates->oid_strings->size();
		corrupted = true;
	}

	if (object_updates->netvars->size() < minsize) {
		minsize = object_updates->netvars->size();
		corrupted = true;
	}

	if (object_updates->vals->size() < minsize) {
		minsize = object_updates->netvars->size();
		corrupted = true;
	}

	if (corrupted)
	{
		/*console("ERROR: obj_update decks corrupted");
		std::string str = "ERROR: ";
		str = str+"oid_strings: " + dubString(static_cast<int>(object_updates->oid_strings->size()));
		str = str+", netvars: " + dubString(static_cast<int>(object_updates->netvars->size()));
		str = str + ", vals: " + dubString(static_cast<int>(object_updates->vals->size()));
		str = str + ", flags: " + dubString(static_cast<int>(object_updates->flags->size()));
		console(str);*/
		if (minsize < 0)
		{
			minsize = 0;
		}
		
		//console("ERROR: would have chopped decks to size " + dubString(static_cast<int>(minsize)));
		/*chopDeck(static_cast<double>(minsize), object_updates->oid_strings);
		chopDeck(static_cast<double>(minsize), object_updates->netvars);
		chopDeck(static_cast<double>(minsize), object_updates->vals);*/
	}
	//console("{O}: done checking deck integrity");
	return 0;

}

void processObjUpdate(message::ptr const& message)
{
	//console("{O}: processing obj_update");

	//validate message as object
	if (message->get_flag() != message::flag_object) { 
		console("malformed objUpdate"); 
		return; 
	}
	
	if (integrityCheck) {
		maintainDeckIntegrity();
		integrityCheck = false;
	}

	//process message object
	//object_updates->indices->push_back(getMapReal(message, "object_index"));
	//object_updates->uniqueIds->push_back(getMapReal(message, "uniqueId"));
	object_updates->oid_strings->push_back(getMapString(message, "oid_string"));
	object_updates->netvars->push_back(getMapString(message, "netvar"));

	//construct the right kind of genVal based on message payload
	if (message->get_map()["val"]->get_flag() == message::flag_string)
		object_updates->vals->push_back(genVal(getMapString(message, "val")));
	else
		object_updates->vals->push_back(genVal(getMapReal(message, "val")));

	object_updates->flags->push_back(getMapReal(message, "flag"));
	//console("{O}: done processing obj_update");
}

void processObjCreate(message::ptr const& message)
{
	//validate message as object
	if (message->get_flag() != message::flag_object) { console("malformed objCreate"); return; }
	
	//process message object
	object_creates->indices->push_back(getMapReal(message, "object_index"));
	object_creates->uniqueIds->push_back(getMapReal(message, "uniqueId"));
	object_creates->myXs->push_back(getMapReal(message, "myX"));
	object_creates->myYs->push_back(getMapReal(message, "myY"));
}

void processGeneralMessage(message::ptr const& message)
{
	//validate message as object
	if (message->get_flag() != message::flag_object) { console("malformed generalMessage"); return; }
	
	//process message object
	generalMessages->push_back(getMapString(message, "msg"));
	generalValues->push_back(getMapGenVal(message, "val"));
}

void processBigMessage(message::ptr const& message)
{
	//validate message as object
	if (message->get_flag() != message::flag_object) { console("malformed generalMessage"); return; }
	
	//process message object
	bigMessages->push_back(getMapString(message, "msg"));
	bigValues1->push_back(getMapGenVal(message, "val1"));
	bigValues2->push_back(getMapGenVal(message, "val2"));
	bigValues3->push_back(getMapGenVal(message, "val3"));
}

GMEXPORT const double objPushBackStr(char * oid_string, char *netVar, char *value, double flag)
{
	_lock.lock();
	string s(oid_string), nv(netVar), v(value);
	console("WARNING: objPushBack(string) for oid " + s);
	object_updates->oid_strings->push_back(s);
	object_updates->netvars->push_back(nv);
	object_updates->vals->push_back(genVal(v));
	object_updates->flags->push_back(flag);
	_lock.unlock();
	return 0;
	//current_socket->emit("loop_back", objUpdateJSON(oid_string, netVar, value, flag));
}
GMEXPORT const double objPushBackReal(char * oid_string, char * netVar, double value, double flag)
{
	_lock.lock();
	string s(oid_string), nv(netVar);
	console("WARNING: objPushBack(real) for obj_index  " + s);
	object_updates->oid_strings->push_back(s);
	object_updates->netvars->push_back(nv);
	object_updates->vals->push_back(genVal(value));
	object_updates->flags->push_back(flag);
	_lock.unlock();
	return 0;
	//current_socket->emit("loop_back", objUpdateJSON(oid_string, netVar, value, flag));
}