gcc /usr/src/libdazzle-3.42.0/src/util/dzl-counter.c `pkg-config --libs libdazzle-1.0` -I. -I/usr/src/libdazzle-3.42.0/src/util -fPIC -c -o dzl-counter.c
gcc dazzle-support.c -o `pkg-config --cflags libdazzle-1.0` -fPIC -c -o dazzle-support.o 
gcc dzl-counter.c dazzle-support.o -fPIC -shared -o dazzle-support.so
