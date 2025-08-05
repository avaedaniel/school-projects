
# lab 6 Makefile for SP 2024
# Ava Daniel

CFLAGS= -std=c99 -pedantic -Wformat -Wreturn-type 
all:  tags headers ops_test lab6

tags: *.c
	ctags -R .

headers: *.c tags
	headers.sh

#####################################################################

	
bonus: bonus.o s_shim.o d_shim.o print.o search.s do_op.s ops.s
	gcc -g -m64 -o $@ $^
	
lab6: lab6.o d_shim.o print.o do_op.s ops.s
	gcc -g -m64 -o $@ $^
	
ops_test: ops_test.o o_shim.o ops.s
	gcc -g -m64 -o $@ $^
	


#####################################################################

# this is our master compiler rule to generate .o files.
# It needs all 4 warnings

%.o:%.c *.h
	gcc $(CFLAGS) -g -c $< -o $@


# Zip target goes here.  
# If it doesn't self test all of your executables, your lab is late.
# AVA!! CHECK THIS BEFORE YOU TURN IT IN
lab6.zip: makefile *.h *.c *.s README_LAB6 d_shim.o o_shim.o print.o
	# in the rule below, $^ can save you - why?
	zip $@ $^
	# self-test is required: first remove old install folder
	rm -rf install
	# create the install folder
	mkdir install
	# unzip to the install folder
	unzip lab6.zip -d install
	# make ONLY the lab6 target, not lab6.zip
	# make all other things that get graded too (never the zip!)
	# the above means things like 
	# LOOK FOR BUILD ERRORS BELOW HERE
	make -C install -r lab6
	make -C install -r ops_test
	# LOOK FOR BUILD ERRORS ABOVE HERE
	# Finally: remove install folder so we don't accidentally use it 
	rm -rf install

