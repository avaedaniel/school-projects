/* Ava Daniel */
/* helper functions for delete_new */

#include <stdio.h>
#include <stdbool.h>

#include "debug.h"
#include "altmem.h"
#include "libll.h"
#include "node.h"

// sort needs to be able to move values. make static?
void swap(struct Node *node1, struct Node *node2)
{
    void *temp = node1->data;
    node1->data = node2->data;
    node2->data = temp;
}

// ACTION FUNCTION
// print list
void print_sort(void *list)
{
    double *input = list;
    if(DEBUG)printf("Printing object: %lf\n", *input);
}

// COMPARISON FUNCTION
// want to put linked list in increasing numerical order
// copied from Ava's /lab3/p_mascot_xpos.c
bool in_order_sort(void *data1, void *data2)
{
    // d1 and d2 are void pointers, ptr1 and ptr2 are pointers to double (valid)
    double *ptr1 = data1;
    double *ptr2 = data2;

    // in_order() returns true if ptr2 should come before ptr1 
    return (*ptr1 > *ptr2);
}