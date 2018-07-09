# export CPATH=boost/
# export C_INCLUDE_PATH=boost/
# export CPLUS_INCLUDE_PATH=boost/
# export OBJC_INCLUDE_PATH=boost/

g++ -std=c++11 -stdlib=libc++ -m32 -fPIC -dynamiclib -compatibility_version 1.0 -current_version 1.0.0 -Os -o GriefPlusPlus.dylib main.cpp #-I "/Users/kylenolan/Documents/games/griefer/GriefPlusPlus 2.0/"
# g++ -m32 -fPIC -dynamiclib -compatibility_version 1.0 -current_version 1.0.0 -Os *.cpp -o GriefPlusPlus.dylib -I "/Users/kylenolan/Documents/games/griefer/GriefPlusPlus 2.0/" -L -std=c++0x

# -Weverything