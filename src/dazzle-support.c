#include <dazzle.h>

// cw: Extract definition for DzlCounterArena into this file.

DzlCounter *create_dazzle_counter (void) {
	return g_new0(DzlCounter, 1);
}

DzlCounterArena *create_dazzle_counter_arena (void) {
	return g_new0(DzlCounterArena, 1);
}
