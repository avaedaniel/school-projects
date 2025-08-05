/* Ava Daniel */
/* prototype 4 for new delete, print the list */

#include <stdio.h>
#include <stdbool.h>

#include "debug.h"
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
    char *input = list;
    if(DEBUG)printf("Printing object: %s\n", input);
}

void free_data(void *data)
{
    char *ptr = data;
    // need to free what was allocted if working with actual allocators and not strings
    free(ptr);
    printf("%s has been freed.\n", ptr);
}

// returns the numnber of nodes deleted
int delete_new(void *p2head, CriteriaFunction mustGo, void *helper,
		ActionFunction disposal, int text)
{
    int num_deleted = 0;
    struct Node **ptr = p2head;
    // iterate until ptr is NULL
    while(*ptr != NULL)
    {
        // 
        struct Node *ptr_holder = *ptr;
        // CriteriaFunction gone() from Ava's /lab3/p_iterate_free
        if (gone(ptr_holder->data, helper))
        // delete node from list
        {
            trash(ptr_holder->data);
            // use member "next" of struct Node
            *ptr = ptr_holder->next;
            //increment number of nodes deleted
            num_deleted++;
        }
        else
        {
            // don't delete node from list
            ptr = &ptr_holder->next;
        }
    }
    return num_deleted;
}

int main()
{

    // list is head ptr to linked list
    void *list = NULL;

    // from the write up:
    // list is pointer to void
    bool rval = insert(&list, "Go Buckeyes!", in_order_delete, TEXT);
    rval = insert(&list, "Beat Michigan.", in_order_delete, TEXT);
    printf("Iterating and printing list:\n");
    iterate(list, print_for_delete);
    
    // delete "Boo Michigan" from list
    printf("Delete Michigan...\n");
    int freed_nodes = delete_new(&list, gone, "Beat Michigan.", free_data, TEXT);
    printf("Nodes freed: %d\n", freed_nodes);
    printf("Iterating and printing list:\n");
    iterate(list, print_for_delete);
}