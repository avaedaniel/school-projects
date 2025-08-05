/* Ava Daniel */
/* helper functions for iterate_new */

#include <stdio.h>
#include <stdbool.h>

#include "debug.h"
#include "altmem.h"
#include "libll.h"
#include "node.h"

// want to put linked list in alphabetical order
// copied from Ava's /lab3/p_mascot_xpos.c
bool in_order(void *data1, void *data2)
{
    // d1 and d2 are void pointers, ptr1 and ptr2 are pointers to char (valid)
    double *ptr1 = data1;
    double *ptr2 = data2;

    // in_order() returns true if ptr1 comes before ptr2 alphabetically
    return (*ptr1 < *ptr2);
}

// ACTION FUNCTION, print list
// copied from Ava's /lab4/p2.c
void print_for_iterate(void *list)
{
    double *input = list;
    if(DEBUG)printf("Printing object: %lf\n", *input);
}