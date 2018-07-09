# export CPATH=boost/
# export C_INCLUDE_PATH=boost/
# export CPLUS_INCLUDE_PATH=boost/
# export OBJC_INCLUDE_PATH=boost/

# export DYLD_LIBRARY_PATH="Users/kylenolan/source/boost/lib:${DYLD_LIBRARY_PATH}"
# g++ -std=c++11 -stdlib=libc++ -m32 -fPIC -dynamiclib -compatibility_version 1.0 -current_version 1.0.0 -Os -o GriefPlusPlus.dylib -I/Users/kylenolan/Documents/games/griefer/GriefPlusPlus\ 2.0/lib/rapidjson/include -I/Users/kylenolan/Documents/games/griefer/GriefPlusPlus\ 2.0/lib/websocketpp -I/Users/kylenolan/source/boost/include -L/Users/kylenolan/source/boost/lib -lboost_system main.cpp src/*.cpp src/internal/*.cpp #-I "/Users/kylenolan/Documents/games/griefer/GriefPlusPlus 2.0/"

export DYLD_LIBRARY_PATH="/opt/local/lib:${DYLD_LIBRARY_PATH}"
g++ -std=c++11 -stdlib=libc++ -fPIC -dynamiclib -compatibility_version 1.0 -current_version 1.0.0 -Os -o GriefPlusPlus.dylib -I/Users/kylenolan/Documents/games/griefer/GriefPlusPlus\ 2.0/lib/rapidjson/include -I/Users/kylenolan/Documents/games/griefer/GriefPlusPlus\ 2.0/lib/websocketpp -I/opt/local/include -L/opt/local/lib -lboost_system-mt main.cpp src/*.cpp src/internal/*.cpp #-I "/Users/kylenolan/Documents/games/griefer/GriefPlusPlus 2.0/"
