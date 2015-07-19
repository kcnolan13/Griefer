#include <iostream>
#include <string>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

class MyClass {
public:
        double hash(char *str) {
        	int hash = 0;
        	if (strlen(str) == 0)
        			return hash;
        	for (int i=0; i< strlen(str); i++)
        	{
        		char c = str[i];
        		hash = ((hash<<5)-hash)+c;
        		cout << "::: intermediary hash: " << hash;
        		hash = hash & hash;
        		cout << "::: after anding: " << hash;
        	}
        	cout << "::: HASHED " << string(str) << " ---> " << hash;
        	if (hash < 0)
        		hash = hash*2;
        	hash = abs(hash);
        	cout << "::: final result: " << string(str);
        	return static_cast<double>(hash);
        }

        MyClass(int &num) {
        	cout << "::: dealer initialized";
        	return;
        }

        void sayHello() {
        	cout << "::: dealer saying hello ";
        	return;
        }
};