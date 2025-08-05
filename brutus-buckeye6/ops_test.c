
// SP24 Lab6 header file
// not written by Ava Daniel

#include <stdio.h>
#include <stdlib.h>

#include "ops.h"

typedef int (*mathOp)(int a, int b);

// this signature is not the one for your 4 functions
// the shim works differently here.  Just write your 4 functions to be a
// mathOp and it will work
int o_shim(int a, int b, mathOp fp);

int main()
{
	int rval;
	int a = 16, b = 4;
	char printable;
	mathOp fp;

	// comment out blocks of statements until that
	// operation is ready to test
	
	// code for plus
	fp = plus; printable = '+';
	printf("%d %c %d = ...\n", a, printable, b);
	rval = o_shim(a, b, fp);
	printf("...%d %c %d = %d\n\n", a, printable, b, rval);

	// code for left shift
	fp = left_shift; printable = '<';
	printf("%d %c %d = ...\n", a, printable, b);
	rval = o_shim(a, b, fp);
	printf("...%d %c %d = %d\n\n", a, printable, b, rval);

	// code for times
	fp = times; printable = '*';
	printf("%d %c %d = ...\n", a, printable, b);
	rval = o_shim(a, b, fp);
	printf("...%d %c %d = %d\n\n", a, printable, b, rval);

	// code for divide
	fp = divide; printable = '/';
	printf("%d %c %d = ...\n", a, printable, b);
	rval = o_shim(a, b, fp);
	printf("...%d %c %d = %d\n\n", a, printable, b, rval);

	return EXIT_SUCCESS;
}


