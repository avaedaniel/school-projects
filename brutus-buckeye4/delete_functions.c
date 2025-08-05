/* Ava Daniel */
/* helper functions for delete_new */

#include <stdio.h>
#include <stdbool.h>

#include "debug.h"
#include "altmem.h"
#include "libll.h"
#include "node.h"

// compare the first characters of two strings - comparison function
bool in_order_delete(void *char1, void *char2)
{
    // char1 is a void pointer and ptr1 is a char pointer (valid)
    char *ptr1 = char1;
    char *ptr2 = char2;

    // determine which char is first
    return (*ptr1 < *ptr2);
}

// coin as the data and mascot as the helper, return true if object needs to be removed - criteria function
bool gone(void *char1, void *helper) 
{
    // char1 and helper are void pointers, ptr1 and ptr2 are char pointers (valid)
    char *ptr1 = char1;
    char *ptr2 = helper;

    // function returns true 
    return (*ptr1 == *ptr2);
}

void trash(void *data)
{
    char *ptr = data;
    // setting pointer to NULL deletes char from the list
    ptr = NULL;
}

/* prints a string (pointer to char) that came in as a pointer to void 
ACTION FUNCTION, print list
copied from Ava's /lab4/p2.c */
void print_for_delete(void *list)
{
    double *input = list;
    if(DEBUG)printf("Printing object: %lf\n", *input);
}


/* function added by Ava Daniel:
frees the space allocated for a mascot */
void free_data_delete(void *data)
{
    struct Buckeye *buckeye = data;
    // need to free what was allocted if working with actual allocators and not strings
    alternative_free(buckeye);
    if(DEBUG)printf("Mascot pointer has been freed.\n");
}