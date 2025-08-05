# Ava Daniel - CSE2421, Lab6

# BY SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CODE FOUND WITHIN THIS FILE WAS CREATED BY ME WITH NO
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE 
# OR ONE OF OUR UNDERGRADUATE GRADERS. I WROTE THIS CODE BY HAND,
# IT IS NOT MACHINE GENRATED OR TAKEN FROM MACHINE GENERATED CODE.

.file "ops.s"
.section    .rodata     #required directives for rodata
.data                   #required for file scope data: read-write program data
                    #of static storage class
.globl ops
    .type   ops, @function
.globl plus
    .type   plus, @function
.globl left_shift
    .type   left_shift, @function
.globl times
    .type   times, @function
.globl divide
    .type   divide, @function
.text 
plus:
    pushq %rbp                  #set up stack frame
    movq %rsp, %rbp

    addq %rdi, %rsi             #add first param to second param - store in %rsi
    movq %rsi, %rax             #put result in %rax

    leave                       #mov %rsp, %rbp
                                #pop %rbp
    ret                         #return value
.size plus, .-plus

left_shift:
    pushq %rbp                  #set up stack frame
    movq %rsp, %rbp

    movl %edi, %eax             #put value to be shifted (first param) in %eax (DON'T NEED?)
    movb %sil, %cl               #put number of places to be shifted (second param) in %cl (DON'T NEED?)
    sall %cl, %eax               #left shift the first param by second param places

    leave                       #mov %rsp, %rbp
                                #pop %rbp
    ret                         #return value
.size left_shift, .-left_shift

times:
    pushq %rbp                  #set up stack frame
    movq %rsp, %rbp

    # imul or imulq?                
    imul %rdi, %rsi         #multiply first param by second param
    movq %rsi, %rax         #result in %rax

    leave                       #mov %rsp, %rbp
                                #pop %rbp
    ret                         #return value
.size times, .-times

divide:
    pushq %rbp                      #set up stack frame
    movq %rsp, %rbp

    # when to use 'r' or 'e'
    movl %esi, %ecx                 #store second param in %ecx (caller saved)
    movl %edi, %eax                 #store first param as result
    cltd                            #extend %eax and trash %edx
    idivl %ecx                      #divide %eax by %ecx (result in %eax)

    leave                           #mov %rsp, %rbp
                                     #pop %rbp
    ret                             #return value
.size divide, .-divide
