//
//  gm_readers.cpp
//
//  Created by Kyle Nolan on 5/3/2015.
//
#include "gm_readers.h"

GMEXPORT const double hash_string(char *str)
{
	long hash = 0;
	if (strlen(str) == 0)
		return hash;
	for (int i = 0; i< strlen(str); i++)
	{
		char c = str[i];
		hash = ((hash << 5) - hash) + c;
		//cout << "::: intermediary hash: " << hash << endl;
		hash |= 0; //convert to 32-bit int
		//cout << "::: after anding: " << hash << endl;
	}
	//cout << "::: HASHED " + string(str) + " ---> " << hash << endl;
	hash = abs(hash);
	//cout << "::: final result: " << hash << endl;
	return static_cast<double>(hash);
}

std::string toString(int val) {
	return std::to_string(static_cast<float>(val));
}

GMEXPORT const double isString(char *type)
{
	_lock.lock();
	genVal checkDis;
	double ret = 0;
	string t(type);

	if (t == "genMessage")
		checkDis = generalValues->front();
	else if (t == "bigMessage")
		checkDis = bigValues1->front();
	else if (t == "bigMessage1")
		checkDis = bigValues1->front();
	else if (t == "bigMessage2")
		checkDis = bigValues2->front();
	else if (t == "bigMessage3")
		checkDis = bigValues3->front();
	else checkDis = object_updates->vals->front();

	if (checkDis.isString)
		ret = 1;

	_lock.unlock();
	return ret;
}

//GENERAL MESSAGES
GMEXPORT const double genMessagesWaiting()
{
	_lock.lock();
	_lock.unlock();
	return messagesWaiting(generalMessages);
}
GMEXPORT const char * readGenMessage()
{
	//console("readGenMessage");
	_lock.lock();
	retString = snatchFront(generalMessages);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const char * readGenValType()
{
	//console("readGenValType");
	_lock.lock();
	retString = peakGenValFrontType(generalValues);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const char * readGenValStr()
{
	//console("readGenValStr");
	_lock.lock();
	retString = snatchGenValFrontStr(generalValues);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const double readGenValReal()
{
	_lock.lock();
	double dubret = snatchGenValFrontReal(generalValues);
	_lock.unlock();
	//console("readGenValReal: "+dubString(dubret));
	return dubret;
}


//BIG MESSAGES
GMEXPORT const double bigMessagesWaiting()
{
	_lock.lock();
	_lock.unlock();
	return messagesWaiting(bigMessages);
}
GMEXPORT const char * readBigMessage()
{
	_lock.lock();
	retString = snatchFront(bigMessages);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const char * readBigValType(double val_num)
{
	_lock.lock();
	retString = peakGenValFrontType(bigValDeque(val_num));
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const char * readBigValStr(double val_num)
{
	_lock.lock();
	retString = snatchGenValFrontStr(bigValDeque(val_num));
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const double readBigValReal(double val_num)
{
	_lock.lock();
	double dubret = snatchGenValFrontReal(bigValDeque(val_num));
	_lock.unlock();
	//console("readGenValReal: "+dubString(dubret));
	return dubret;
}
deque<genVal> * bigValDeque(double val_num)
{
	if (val_num == 1)
		return bigValues1;
	else if (val_num == 2)
		return bigValues2;
	else if (val_num == 3)
		return bigValues3;
	else return bigValues1;
}

//OBJECT UPDATES
GMEXPORT const double objUpdatesWaiting()
{
	_lock.lock();
	_lock.unlock();
	return messagesWaiting(object_updates->oid_strings);
}
GMEXPORT const double readObjUpdateIndex()
{
	_lock.lock();
	_lock.unlock();
	return (snatchFront(object_updates->indices));
}
GMEXPORT const char * readObjUpdateUniqueId()
{
	_lock.lock();
	retString = snatchFront(object_updates->uniqueIds);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const char * readObjUpdateNetvar()
{
	_lock.lock();
	retString = snatchFront(object_updates->netvars);
	_lock.unlock();
	return  retString.c_str();
}
GMEXPORT const char * readObjUpdateOidStr()
{
	_lock.lock();
	retString = snatchFront(object_updates->oid_strings);
	_lock.unlock();
	return  retString.c_str();
}
GMEXPORT const char * readObjUpdateValType()
{
	_lock.lock();
	retString = peakGenValFrontType(object_updates->vals);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const char * readObjUpdateValStr()
{
	_lock.lock();
	retString = snatchGenValFrontStr(object_updates->vals);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const double readObjUpdateValReal()
{
	_lock.lock();
	_lock.unlock();
	return snatchGenValFrontReal(object_updates->vals);
}
GMEXPORT const double readObjUpdateFlag()
{
	_lock.lock();
	double retFl = snatchFront(object_updates->flags);
	integrityCheck = true;
	_lock.unlock();
	return retFl;
}

//OBJECT CREATES
GMEXPORT const double objCreatesWaiting()
{
	_lock.lock();
	_lock.unlock();
	return messagesWaiting(object_creates->indices);
}
GMEXPORT const double readObjCreateIndex()
{
	_lock.lock();
	_lock.unlock();
	return snatchFront(object_creates->indices);
}
GMEXPORT const char * readObjCreateUniqueId()
{
	_lock.lock();
	retString = snatchFront(object_creates->uniqueIds);
	_lock.unlock();
	return retString.c_str();
}
GMEXPORT const double readObjCreateMyX()
{
	_lock.lock();
	_lock.unlock();
	return snatchFront(object_creates->myXs);
}
GMEXPORT const double readObjCreateMyY()
{
	_lock.lock();
	_lock.unlock();
	return snatchFront(object_creates->myYs);
}

GMEXPORT const double cleanse_double(double val)
{
	return (double)val;
}