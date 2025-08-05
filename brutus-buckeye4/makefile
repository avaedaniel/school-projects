# Sample lab 3 Makefile for SP 2024
# AVA DANIEL modified to create lab 4 Makefile for SP 2024

CFLAGS= -std=c99 -pedantic -Wformat -Wreturn-type 
all:  tags headers lab4


headers: *.c tags
	headers.sh

tags: *.c
	ctags -R .


# this is our master compiler rule to generate .o files.
# It needs all 4 warnings

%.o:%.c *.h
	gcc $(CFLAGS) -g -c $< -o $@


lab4: lab4.o reliable.o callbacks.o memory.o bits.o input.o physics.o sim.o output.o n2.o linkedlist.o sort_functions.o delete_functions.o iterate_functions.o
	gcc -g -o $@ $^  -L. -lbtp -lncurses -lm -llinkedlist

lab4u: lab4.o unreliable.o callbacks.o memory.o bits.o input.o physics.o sim.o output.o n2.o linkedlist.o sort_functions.o delete_functions.o iterate_functions.o
	gcc -g -o $@ $^  -L. -lbtp -lncurses -lm -llinkedlist


# Prototypes go here
p_insert: p_insert.o 
	gcc -g -o $@ $^  -L. -lbtp -lncurses -lm -llinkedlist

p_sort: p_sort.o node.h libll.h debug.h
	gcc -g -o $@ $^  -L. -lbtp -lncurses -lm -llinkedlist -llinkedlist

p_iterate: p_iterate.o node.h libll.h debug.h
	gcc -g -o $@ $^  -L. -lbtp -lncurses -lm -llinkedlist -llinkedlist

p_delete: p_delete.o node.h libll.h debug.h
	gcc -g -o $@ $^  -L. -lbtp -lncurses -lm -llinkedlist -llinkedlist


# Zip target goes here.  
# If it doesn't self test lab4, your lab is late.


lab4.zip: makefile *.c *.h README_LAB4
	# in the rule below, $^ can save you – why?
	zip $@ $^
	# self-test is required: first remove old install folder
	rm –rf install
	# create the install folder
	mkdir install
	# unzip to the install folder
	unzip lab4.zip –d install
	# make ONLY the lab4 target, not lab4.zip
	# make all other things that get graded too (never the zip!)
	# the above means things like stuff and all prototypes
	# LOOK FOR ERRORS BELOW HERE
	make –C install -r lab4
	make –C install –r p_insert
	make –C install –r p_sort
	make –C install –r p_iterate
	make –C install –r p_delete
	# LOOK FOR BUILD ERRORS ABOVE HERE
	# Finally: remove install folder so we don’t accidentally use it rm –rf install
	rm –rf install
