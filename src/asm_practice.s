    .data   # Defines all statements below to be in the "data segment".
            # The "data segment" is where most static and global variables are stored.
            # Exception: Static and global variables initialized to zero are typically stored in the "BSS segment"
            #            as a small optimization when loading programs into memory
str_format:
    .asciz "%s" # defines a string with "%s" as its value

int_format:
    .asciz "%d" 

new_line:
    .asciz "\n"

space:
    .asciz " "

begin_msg:
    .asciz "Hello Assembly!"

####################################################################################################################
    
    .text   # Defines all statements below to be in the "text segment".
            # The "text segment" is where instructions inside functions are stored.

    .extern printf # specifies that this function is defined outside of this file
    .extern todo
    .extern get
    .extern middle_of_nowhere
# ------------------------------------------sample assembly 0-------------------------------------------------------
#  `void print_str(const char* str)`, prints `str` to standard output
#  
#  Return Value: None
# ------------------------------------------------------------------------------------------------------------------
    .global print_str # specifies that the print_begin label is visible outside of this file
print_str:
    movq %rdi, %rsi
    leaq str_format(%rip), %rdi # Locations in memory are typically referred
                                # to through an offset to the instruction pointer.
                                # Can you guess why? If you are interested, google relocation.

    # why don't we have to save caller-saved registers here?

    movq $0, %rax # rax is used to denote the number of vector arguments in printf
    jmp printf@plt # Why does this work? Why do we not have to call print_begin and instead just jump straight to it?
    # callq printf@plt

    # why don't we have to restore caller-saved registers here?
    # retq

# ------------------------------------------sample assembly 1-------------------------------------------------------
#  `void print_new_line()`, prints a new line to standard output
#  
#  Return Value: None
# ------------------------------------------------------------------------------------------------------------------
    .global print_new_line
print_new_line:
    leaq new_line(%rip), %rdi
    jmp print_str

# -----------------------------------------sample assembly 2--------------------------------------------------------
#  `void print_begin()`, prints a begin message to standard output
#  
#  Return Value: None
# ------------------------------------------------------------------------------------------------------------------
    .global print_begin
print_begin:
    pushq %rbp
    movq %rsp, %rbp # set up stack frame to ensure it is 16 byte aligned
    leaq begin_msg(%rip), %rdi
    callq print_str
    callq print_new_line
    popq %rbp
    retq

# -----------------------------------------sample assembly 3--------------------------------------------------------
#  `void print_arr(int n_elems, const int* arr)`, prints an array of integers to standard output
#  
#  Return Value: None
# ------------------------------------------------------------------------------------------------------------------
    .global print_arr
print_arr:
    pushq %rbp
    movq %rsp, %rbp
    movq $0, %rax
    subq $0x20, %rsp # set up space to store variables on the stack
                     # needs to be 16 byte aligned
1:
    cmp %rax, %rdi
    je 2f

    # save variables on the stack
    movq %rdi, (%rsp)
    movq %rsi, 0x8(%rsp) 
    movq %rax, 0x10(%rsp)
    
    movq %rax, %rdi
    callq get
    
    movq %rax, %rdi
    callq print_int

    leaq space(%rip), %rdi
    callq print_str
    
    movq 0x10(%rsp), %rax
    movq 0x8(%rsp), %rsi
    movq (%rsp), %rdi
    addq $1, %rax
    jmp 1b
2:
    addq $0x20, %rsp # deallocate variables on the stack 
    popq %rbp
    retq

# -----------------------------------------sample assembly 4--------------------------------------------------------
#  `void context_entry()`, jumps to `middle_of_nowhere`
#  
#  Return Value: None
# ------------------------------------------------------------------------------------------------------------------
    .global context_entry
context_entry:
    movq %rax, %rdi
    callq middle_of_nowhere # callq needed to preserve stack alignment

####################################################################################################################

# -------------------------------------------problem 0--------------------------------------------------------------
#  Implement `void print_int(int a)`, where `a` is printed out into standard output. No new line character should be
#  appended.
#  
#  Hints: Look at the above implementation of `print_str`
#  Return Value: None
# ------------------------------------------------------------------------------------------------------------------
    .global print_int
print_int:
    jmp todo


# -------------------------------------------problem 1--------------------------------------------------------------
#  Implement `int get(int idx, const int* arr)`, where the integer at index idx` of the array `arr` is returned.
#
#  Hints: Use an addressing mode that can access memory and remember to use the correct register size to return 
#         an integer
#  Return Value: `arr[idx]`
# ------------------------------------------------------------------------------------------------------------------
    .global get
get:
    jmp todo


# -------------------------------------------problem 2, part a-------------------------------------------------------
#  Implement `void swap(int* a, int* b)`, where the integer at address `a` is swapped with the 
#  integer at address `b`.
#
#  Hints: Make sure that you preserve callee saved registers or use a caller saved register as an intermediate.
#  Return Value: None
# -------------------------------------------------------------------------------------------------------------------
    .global swap
swap:
    jmp todo


# -------------------------------------------problem 2, part b-------------------------------------------------------
#  Implement `bool cond_swap(int* a, int* b)`, where the two values behind the two references are
#  swapped only if *a > *b.
#
#  Hints: Reuse code you have written in part a but use conditional statements. Search up labels to define jump 
#         points. Like problem 1, be careful with register sizes.
#  Return Value: Whether the swap occurred
# -------------------------------------------------------------------------------------------------------------------
    .global cond_swap
cond_swap:
    jmp todo


# -------------------------------------------problem 3---------------------------------------------------------------
#  Implement `void bubble_up(int count, int* start)`, which should implement the inner for loop in bubble sort:
#  ```
#    void bubble_up(int count, int* start) {
#        for (int offset = 0; offset < count - 1; offset++) {
#            cond_swap(start + offset, start + offset + 1);
#        }
#    }
#  ```
#
#  Hints: Reuse code you have written in problem 2.
#  Return Value: None
# -------------------------------------------------------------------------------------------------------------------
    .global bubble_up
bubble_up:
    jmp todo


# -------------------------------------------problem 4---------------------------------------------------------------
#  Implement `void bubble_sort(int size, int* arr)`, which should implement bubble sort.
#
#  Hints: Reuse code you have written in problem 3.
#  Return Value: None
# -------------------------------------------------------------------------------------------------------------------
    .global bubble_sort
bubble_sort:
    jmp todo


# -------------------------------------------problem 5---------------------------------------------------------------
#  Implement `int fib_recursive(int n)`, which should implement the nth fibonacci sequence:
#       fib(0) = 1
#       fib(1) = 1
#       fib(2) = 2
#
#  Hints: Keep track of caller and callee-saved registers
#  Return Value: the nth fibonacci number
# -------------------------------------------------------------------------------------------------------------------
    .global fib_recursive
fib_recursive:
    jmp todo


# -------------------------------------------problem 6---------------------------------------------------------------
#  Implement `int tree_sum(nptr_t node)`, which should print the sum of all nodes in the tree rooted at this node
#
#  Hints: See the header file for the definition of `node_t` and `nptr_t`. Remember to account for struct padding.
#  Return Value: the sum
# -------------------------------------------------------------------------------------------------------------------
    .global tree_sum
tree_sum:
    jmp todo


# -------------------------------------------additional practice-----------------------------------------------------
#  Implement `void* context_switch(void* new_rsp)`, which should implement the following routine:
#  ```
#  void* context_switch(void* new_rsp) {
#      push(callee_saved_registers);
#      void* old_rsp = %rsp;
#      %rsp = new_rsp;
#      pop(callee_saved_registers);
#      return old_rsp;
#  }
#
#  ```
#
#  Hints: The order in which the registers are pushed and popped should be symmetric and the stack pointer should not
#         be pushed or popped. You will need to modify the .c file with the correct number of callee-saved registers.
#  Return Value: the old stack pointer
# -------------------------------------------------------------------------------------------------------------------
.global context_switch
context_switch:
    jmp todo
