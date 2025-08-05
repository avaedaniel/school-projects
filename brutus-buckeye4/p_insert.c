/* Ava Daniel */
/* prototype 1 for new version of insert, insert 50 into the list */

#include <stdio.h>
#include <stdbool.h>

// create Struct Node
struct Thing
{
    int dval;
    struct Thing *next;
};

/* insert returns FALSE when it fails to do the insert (from notes) */
void insert_new(struct Thing *newnode, struct Thing **p2p2change)
{
    printf("Inserting %d (lives at %p)\n", newnode->dval, newnode);

    while( *p2p2change != NULL && (**p2p2change).dval > newnode->dval)
    {
        printf("Going past %d\n", (**p2p2change).dval);
        p2p2change = &((**p2p2change).next);
    }

    newnode->next = *p2p2change;
    *p2p2change = newnode;
}

// insert 50 into the list
int main()
{
    // initialize structs to NULL
    struct Thing newnode = {50, NULL};
    // *head is *p2p2change
    struct Thing *head = NULL; 

    // call insert on addresses
    insert_new(&newnode, &head);
}