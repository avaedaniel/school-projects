/* Ava Daniel */
/* versions of linked list functions written by Ava Daniel */

// list < > style headers first
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// includ3 constants and structs next
#include "node.h"
#include "debug.h"
#include "altmem.h"
#include "delete_functions.h"
#include "iterate_functions.h"
#include "sort_functions.h"


/* these are the function pointer signatures needed */
// copied by Ava Daniel from "libll.h"
typedef void (* ActionFunction)( void *data);
typedef bool (* ComparisonFunction)(void *data1, void *data2);
typedef bool (* CriteriaFunction)(void *data, void *helper);
typedef double (* NumericFunction)(void *data);

//bool insert_new(struct Node *newnode, struct Node **p2p2change)
/* insert returns FALSE when it fails to do the insert */
bool insert(void *p2head, void *data, ComparisonFunction goesInFrontOf, 
		int text)
{
    bool inserted = false;
    // pointer to pointer to Node = (pointer to) pointer to void
    struct Node **p2p2change = p2head;
    // create newnode to be the next node
    struct Node *newnode = malloc(sizeof(struct Node));
    newnode->data = data;
    newnode->next = NULL;


    //printf("Inserting %d (lives at %p)\n", newnode->data, newnode);

    while( *p2p2change != NULL && !goesInFrontOf(newnode->data, (*p2p2change)->data))
    {
        p2p2change = &((**p2p2change).next);
    }

    if(*p2p2change = NULL)
    {
        if(DEBUG)printf("Object failed to add to the list.");
        inserted = false;
    }
    else
    {
        if(DEBUG)printf("Currently pointing to %p, next pointing to %p.", (void*)*p2p2change, (void*)newnode->next);
        newnode->next = *p2p2change;
        *p2p2change = newnode;
    }
    return inserted;
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
        if (mustGo(ptr_holder->data, helper))
        // delete node from list
        {
            disposal(ptr_holder->data);
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

bool any_new(void *head, CriteriaFunction yes, void *helper)
{
    // result = true one CriteriaFunction returns true
    bool result = false;

    //quit sorting when you reach the end of the list aka NULL value
    Node *quit = NULL;

    while(!result)
    {
        // hptr to point to Node, use name 'now' to match struct member name
        struct Node *current_node = head;
        while(current_node != NULL && current_node->next != quit)
        {
            // store now->next inside loop
            struct Node *next_node = current_node->next;

            /* typedef bool (* CriteriaFunction)(void *data, void *helper),
            returns true if object meets CriteriaFunction */
            if(yes(current_node->data, NULL)) result = true;
            current_node = current_node->next;
        }
        // while-loop exited, meaning current = NULL and next_node = NULL. Done sorting
        quit = current_node;
    }
    return result;
}


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

// sort function from linked list
void sort_new(void *head, ComparisonFunction comp)
{
    // Goal: want hptr to point to struct Node eventually
    // sorted = true once all values are in order
    bool sorted = false;

    //quit sorting when you reach the end of the list aka NULL value
    Node *quit = NULL;

    while(!sorted)
    {
        // hptr to point to Node, use name 'now' to match struct member name
        struct Node *current_node = head;
        sorted = true;
        while(current_node != NULL && current_node->next != quit)
        {
            // store now->next inside loop
            struct Node *next_node = current_node->next;

            /* typedef bool (* ComparisonFunction)(void *data, void *data),
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