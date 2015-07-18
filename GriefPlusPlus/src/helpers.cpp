//
//  helpers.cpp
//
//  Created by Kyle Nolan on 5/4/2015
//
#include "helpers.h"

string retString = "blah";
bool integrityCheck = false;
bool debug = false;

genVal::genVal()
{
	sVal = "";
	dVal = GENVAL_DNULL;
	isString = false;
}

genVal::genVal(string strVal)
{
	sVal = strVal;
	dVal = GENVAL_DNULL;
	isString = true;
}

genVal::genVal(double dubVal)
{
	sVal = "";
	dVal = dubVal;
	isString = false;
}

void console(string output)
{
	if (debug || ((output.find("{Osefsdf}:") != string::npos) || (output.find(":::") != string::npos) || (output.find("llJSON") != string::npos) || (output.find("ERROR") != string::npos) || (output.find("error") != string::npos)))
		cout << output << endl;
}

void popup( string output)
{
	::MessageBoxA(NULL, output.c_str(), "GriefPlusPlus", MB_ICONINFORMATION);
}

string dubString(double val)
{
	return to_string(static_cast<float>(val));
}

string dubString(int val)
{
	return to_string(static_cast<float>(val));
}

string dubString(float val)
{
	return to_string(val);
}

double getMapReal(message::ptr const& data, string key)
{
	if (data->get_map()[key]->get_flag() == message::flag_integer)
	{
		return static_cast<double>(data->get_map()[key]->get_int());
	}
	else {
		return data->get_map()[key]->get_double();
	}
}

string getMapString(message::ptr const& data, string key)
{
	return data->get_map()[key]->get_string();
}

genVal getMapGenVal(message::ptr const& data, string key)
{
	if (data->get_map()[key]->get_flag() == message::flag_integer)
	{
		return genVal(static_cast<double>(data->get_map()[key]->get_int()));
	}
	else {
		if (data->get_map()[key]->get_flag() == message::flag_double) {
			//console("building dub genVal");
			return genVal(data->get_map()[key]->get_double());
		}
		else {
			//console("ERROR: making string genVal: " + data->get_map()[key]->get_string());
			return genVal(data->get_map()[key]->get_string());
		}
	}
}

string snatchFront(deque<string> *deck)
{
	if (deck->size() < 0)
		return "";

	string ret = deck->front();
	deck->pop_front();
	return ret;
}

double snatchFront(deque<double> *deck)
{
	if (deck->size() < 0)
		return 0;

	double ret = deck->front();
	deck->pop_front();
	return ret;
}

string snatchGenValFrontStr(deque<genVal> *deck)
{
	if (deck->size() < 0)
		return "";

	string ret = deck->front().sVal;
	deck->pop_front();
	return ret;
}

double snatchGenValFrontReal(deque<genVal> *deck)
{
	if (deck->size() < 0)
		return 0;

	double ret = deck->front().dVal;
	deck->pop_front();
	return ret;
}

string readGenValType(genVal checkDis)
{
	if (checkDis.isString)
		return "String";
	else return "Real";
}

string peakGenValFrontType(deque<genVal> *deck)
{
	if (deck->size() < 1)
		return "";

	genVal checkDis = deck->front();
	return readGenValType(checkDis);
}
double messagesWaiting(deque<string> *deck)
{
	double ret = 1;
	if (deck->size() < 1) ret = 0;
	return ret;
}
double messagesWaiting(deque<double> *deck)
{
	double ret = 1;
	if (deck->size() < 1) ret = 0;
	return ret;
}
double messagesWaiting(deque<genVal> *deck)
{
	double ret = 1;
	if (deck->size() < 1) ret = 0;
	return ret;
}

string field(string name, const char *val)
{
	string v(val);
	string ret = "\"" + name + "\": \"" + v + "\"";
	return ret;
}
string field(string name, double val)
{
	string ret = "\"" + name + "\": " + dubString(val);
	return ret;
}
string objHeaderJSON(string name, char * oid_string)
{
	string ret = "{" + field("name", name.c_str()) + ", " + field("oid_string", oid_string) + ", ";
	return ret;
}
string objUpdateJSON(char * oid_string, char * netVar, char *value, double flag)
{
	string ret = objHeaderJSON("objUpdate", oid_string);
	ret += field("netvar", netVar) + ", " + field("val", value) + ", " + field("flag", flag) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string objUpdateJSON(char * oid_string, char * netVar, double value, double flag)
{
	string ret = objHeaderJSON("objUpdate", oid_string);
	string nv(netVar);
	string val = dubString(value);
	ret += field("netvar", netVar) + ", " + field("val", value) + ", " + field("flag", flag) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string objCreateJSON(double object_index, double uniqueId, double myX, double myY)
{
	string ret = "{" + field("name", "objCreate") + ", " + field("object_index", object_index) + ", " + field("uniqueId", uniqueId) + ", ";
	ret += field("myX", myX) + ", " + field("myY", myY) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string genMessageJSON(char *message_string, const char *value)
{
	string ret = "{" + field("name", "generalMessage") + ", " + field("msg", message_string) + ", " + field("val", value) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string genMessageJSON(char *message_string, double value)
{
	string msgStr(message_string);
	string val = dubString(value);
	string ret = "{" + field("name", "generalMessage") + ", " + field("msg", message_string) + ", " + field("val", value) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string bigMessageJSON(char *message_string, double value1, double value2, double value3)
{
	string ret = "{" + field("name", "bigMessage") + ", " + field("msg", message_string) + ", " + field("val1", value1) + ", " + field("val2", value2) + ", " + field("val3", value3) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string bigMessageJSON(char *message_string, const char *value1, const char *value2, const char *value3)
{
	string ret = "{" + field("name", "bigMessage") + ", " + field("msg", message_string) + ", " + field("val1", value1) + ", " + field("val2", value2) + ", " + field("val3", value3) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string bigMessageJSON(char *message_string, const char * value1, double value2, double value3)
{
	string ret = "{" + field("name", "bigMessage") + ", " + field("msg", message_string) + ", " + field("val1", value1) + ", " + field("val2", value2) + ", " + field("val3", value3) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
string bigMessageJSON(char *message_string, const char * value1, char *value2, double value3)
{
	string ret = "{" + field("name", "bigMessage") + ", " + field("msg", message_string) + ", " + field("val1", value1) + ", " + field("val2", value2) + ", " + field("val3", value3) + "}";

	console("JSON Constructed: " + ret);
	return ret;
}
double chopDeck(double chopTo, deque<string> *longer)
{
	int i = 0;
	while (i<100 && longer->size() > chopTo)
	{
		i++;
		longer->pop_front();
	}
	return 0;
}
double chopDeck(double chopTo, deque<double> *longer)
{
	int i = 0;
	while (i<100 && longer->size() > chopTo)
	{
		i++;
		longer->pop_front();
	}
	return 0;
}
double chopDeck(double chopTo, deque<genVal> *longer)
{
	int i = 0;
	while (i<100 && longer->size() > chopTo)
	{
		i++;
		longer->pop_front();
	}
	return 0;
}