# Ava Daniel - CSE2421, Lab6

# BY SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CODE FOUND WITHIN THIS FILE WAS CREATED BY ME WITH NO
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE 
# OR ONE OF OUR UNDERGRADUATE GRADERS. I WROTE THIS CODE BY HAND,
# IT IS NOT MACHINE GENRATED OR TAKEN FROM MACHINE GENERATED CODE.

.file "do_op.s"
.section    .rodata     #required directives for rodata

#print statements
print_1:
    .string "%d %c %d = ...\n"

print_2:
    .string "...%d %c %d = %d\n\n"

.data                   #required for file scope data: read-write program data
                    #of static storage class
.globl do_op
    .type   do_op, @function
.text 

do_op:
    pushq %rbp                  #set up stack frame
    movq %rsp, %rbp

    #start ordering parameters for first print
    pushq %r12                      #hold struct ('op')
    movq %rdi, %r12                 #store the struct in %r12 before print
    pushq %r13                      #hold table
    movq %rsi, %r13                 #store table in %r13
    movq $print_1, %rdi             #store first print statement in first parameter
    movl 8(%r12), %esi              #8 bytes into struct is int a
    movsbq 4(%r12), %rdx            #4 bytes into struct is printable (caller saved) 
                                    #does this need sign extend to match int?
    movl 12(%r12), %ecx             #12 bytes into struct is int b
   
    movq $0, %rax                   #0 floating point values
    call print

    movswq 6(%r12), %r11                #6 bytes into struct is operation 
    movl 8(%r12), %edi                  #8 bytes into struct is int a
    movl 12(%r12), %esi                 #12 bytes into struct is int b
    movq (%r13, %r11, 8), %r8
    call *%r8                           #int rval = table[op->operation](op->a, op->b);
    movl %eax, (%r12)                   #op->result = rval

    #start reordering parameters for second print
    movq $print_2, %rdi
    movl 8(%r12), %esi                  #8 bytes into struct is int a (have to access again?)
    movsbq 4(%r12), %rdx                #4 bytes into struct is printable 
                                        #does this need sign extend to match int?
    movl 12(%r12), %ecx                 #12 bytes into struct is int b
    movl (%r12), %r8d                   #0 bytes into struct is int result

    movq $0, %rax                       #0 floating point values
    call print                          #printf("...%d %c %d = %d\n\n", op->a, op->printable, op->b, op->result);
    movl (%r12), %eax                   #restore return value from op to return value for do_op

    popq %r13
    popq %r12

    leave                               #mov %rsp, %rbp
                                        #pop %rbp
    ret                                 #return rval;
.size do_op, .-do_op



# should do this:
#int do_op( struct Operation *op, mathOp table[])
#{
    #printf("%d %c %d = ...\n", op->a, op->printable, op->b); 
    #int rval = table[op->operation](op->a, op->b);
    #op->result = rval;
    #printf("...%d %c %d = %d\n\n", op->a, op->printable, op->b, op->result);
    #return rval;
#}
