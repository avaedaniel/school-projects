/* Ava Daniel */
/* prototype 2 for new iterate, print the list in alphabetical order */

#include <stdio.h>
#include <stdbool.h>

#include "debug.h"
#include "libll.h"
#include "node.h"

void iterate_new(void *head, ActionFunction doSomething)
{
    struct Node *head_ptr = (Node*) head;
    while(head_ptr != NULL)
    {
        doSomething(head_ptr->data);
        // use "next" member of Node struct
        head_ptr = head_ptr->next;
    }
}

// want to put linked list in alphabetical order
// copied from Ava's /lab3/p_mascot_xpos.c
bool in_order(void *data1, void *data2)
{
    // d1 and d2 are void pointers, ptr1 and ptr2 are pointers to char (valid)
    char *ptr1 = data1;
    char *ptr2 = data2;

    // in_order() returns true if ptr1 comes before ptr2 alphabetically
    return (*ptr1 < *ptr2);
}

// ACTION FUNCTION, print list
// copied from Ava's /lab4/p2.c
void print_for_iterate(void *list)
{
    char *input = list;
    if(DEBUG)printf("Printing object: %s\n", input);
}

int main()
{
    // set void pointers to NULL (write-up)
    void *head_ptr = NULL;
    // same insert() format as lab3 prototypes
    bool rval = insert(&head_ptr, "Go", in_order, TEXT);
    rval = insert(&head_ptr, "Brutus", in_order, TEXT);
    rval = insert(&head_ptr, "Buckeye", in_order, TEXT);
    iterate_new(head_ptr, print_for_iterate);
    // main returns an int, does it have to be 0?
    return 0;
}