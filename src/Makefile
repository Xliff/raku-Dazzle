DAZZLE_CFLAGS = $(shell pkg-config libdazzle-1.0 --cflags)
DAZZLE_LIBS = $(shell pkg-config libdazzle-1.0 --libs)

all: dazzle-support.so 

glib-support.so: dazzle-support.c
	gcc dazzle-support.c $(DAZZLE_CFLAGS) -shared -fPIC -o dazzle-support.so $(DAZZLE_LIBS)

clean:
	rm -rf *o
	rm -rf *exe
	rm -rf dazzle-support.so
