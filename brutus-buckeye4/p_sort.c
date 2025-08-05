/* Ava Daniel */
/* prototype 2 for new version of sort, sort the list */

#include <stdio.h>
#include <stdbool.h>

#include "node.h"
#include "libll.h"
#include "debug.h"

// sort needs to be able to move values. make static?
void swap(struct Node *node1, struct Node *node2)
{
    void *temp = node1->data;
    node1->data = node2->data;
    node2->data = temp;
}

// sort function from linked list
void sort_new(void *hptr, ComparisonFunction comp)
{
    // Goal: want hptr to point to struct Node eventually
    // sorted = true once all values are in order
    bool sorted = false;

    //quit sorting when you reach the end of the list aka NULL value
    Node *quit = NULL;

    while(!sorted)
    {
        // hptr to point to Node, use name 'now' to match struct member name
        struct Node *current_node = hptr;
        sorted = true;
        while(current_node != NULL && current_node->next != quit)
        {
            // store now->next inside loop
            struct Node *next_node = current_node->next;

            /* typedef bool (* ComparisonFunction)(void *data1, void *data2),
            returns true when the first object belongs earlier in the list */
            if(next_node != NULL && comp(next_node->data, current_node->data))
            {
                // not at the end of list and datas need swapped
                swap(current_node, next_node);
                sorted = false;
            }
            current_node = current_node->next;
        }
        // while loop exited, meaning current = NULL and next_node = NULL. Done sorting
        quit = current_node;
    }
}

// ACTION FUNCTION
// print list
void print_sort(void *list)
{
    char *input = list;
    printf("Printing object: %s\n", input);
}

// COMPARISON FUNCTION
// want to put linked list in alphabetical order
// copied from Ava's /lab3/p_mascot_xpos.c
bool in_order_sort(void *data1, void *data2)
{
    // d1 and d2 are void pointers, ptr1 and ptr2 are pointers to char (valid)
    char *ptr1 = data1;
    char *ptr2 = data2;

    // in_order() returns true if ptr2 should come before ptr1 alphabetically
    return (*ptr1 > *ptr2);
}

int main()
{
    void *list = NULL;
    //use &list for insert and deleteSome
    bool rval = insert(&list, "Go", in_order_sort, TEXT);
    rval = insert(&list, "Brutus", in_order_sort, TEXT);
    rval = insert(&list, "Buckeye", in_order_sort, TEXT);
    sort_new(list, in_order_sort);
    iterate(list, print_sort);
}