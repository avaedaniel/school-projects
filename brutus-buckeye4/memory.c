
// COpyright 2024 Neil Kirby
// Not for distribution without permission

// list < > style headers first
#include <stdio.h>
#include <stdlib.h>

// includ3 constants and structs next
#include "altmem.h"
#include "debug.h"

// include our own file last
#include "memory.h"

void *allocate_struct(int size)
{
	static int objects = 0;
	void *ptr;

	if( ptr = alternative_malloc(size))
	{
	    objects++;
	    if(TEXT)
	    {
    if(DEBUG)printf("DIAGNOSTIC: allocation #%d allocated %d bytes\n", objects, size);
	    }

	}
	else
	{
	    if(TEXT)printf("ERROR: failed to allocate %d bytes.\n", size);
	}
	return ptr;

}

void free_struct(void *thing)
{
	static int count = 0;

	alternative_free(thing);
	count++;
	if(TEXT)printf("DIAGNOSTIC: %d objects freed\n", count);
}

