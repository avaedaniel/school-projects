/* Ava Daniel */

/* these are the function pointer signatures needed */
// copied by Ava Daniel from "libll.h"
typedef void (* ActionFunction)( void *data);
typedef bool (* ComparisonFunction)(void *data1, void *data2);
typedef bool (* CriteriaFunction)(void *data, void *helper);
typedef double (* NumericFunction)(void *data);

bool any_new(void *head, CriteriaFunction yes, void *helper);
int delete_new(void *p2head, CriteriaFunction mustGo, void *helper,
		ActionFunction disposal, int text);
bool insert(void *p2head, void *data, ComparisonFunction goesInFrontOf, 
		int text);
void iterate_new(void *head, ActionFunction doSomething);
void sort_new(void *head, ComparisonFunction comp);
