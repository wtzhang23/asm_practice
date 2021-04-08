#include "asm_practice.h"
#include <stdio.h>
#include <stdlib.h>

static int dummy_values[] = {5, 4, 3, 2, 1, 0};
static int dummy_len = 6;
static const int N_CALLEE_REGISTERS = 6; // need to modify this!
static const int STACK_SIZE = 1 << 8;

int main(int argc, const char** argv) {
    print_begin();

    // problem 0
    print_str("Problem 0");
    print_new_line();
    print_str("Printing a special integer: ");
    print_int(42);
    print_new_line();
    print_new_line();

    // problem 1
    print_str("Problem 1");
    print_new_line();
    print_arr(dummy_len, dummy_values);
    print_new_line();
    print_new_line();

    // problem 2
    print_str("Problem 2");
    print_new_line();
    int a = 2;
    int b = 1;
    { // first conditional swap
        print_str("Conditionally swapping ");
        print_int(a);
        print_str(" ");
        print_int(b);
        print_str(" results in ");
        bool swap_occurred = cond_swap(&a, &b);
        print_int(a);
        print_str(" ");
        print_int(b);
        print_new_line();
        if (swap_occurred) {
            print_str("The values swapped!");
            print_new_line();
        }
    }
    { // second conditional swap 
        print_str("Conditionally swapping ");
        print_int(a);
        print_str(" ");
        print_int(b);
        print_str(" results in ");
        bool swap_occurred = cond_swap(&a, &b);
        print_int(a);
        print_str(" ");
        print_int(b);
        print_new_line();
        if (swap_occurred) {
            print_str("The values swapped!");
            print_new_line();
        }
    }
    { // nonconditional swap
        print_str("Swapping ");
        print_int(a);
        print_str(" ");
        print_int(b);
        print_str(" results in ");
        swap(&a, &b);
        print_int(a);
        print_str(" ");
        print_int(b);
        print_new_line();
    }
    print_new_line();

    print_str("Problem 3");
    print_new_line();
    bubble_up(dummy_len, dummy_values);
    print_arr(dummy_len, dummy_values);
    print_new_line();
    print_new_line();

    print_str("Problem 4");
    print_new_line();
    bubble_sort(dummy_len, dummy_values);
    print_arr(dummy_len, dummy_values);
    print_new_line();
    print_new_line();

    print_str("Problem 5");
    print_new_line();
    print_int(fib_recursive(0));
    for (int i = 1; i < 10; i++) {
        print_str(" ");
        print_int(fib_recursive(i));
    }
    print_new_line();
    print_new_line();

    print_str("Problem 6");
    print_new_line();
    uintptr_t* stack = (uintptr_t*) aligned_alloc(16, STACK_SIZE * sizeof(uintptr_t)); // 16 byte aligned
    void* new_rsp = (void*) &stack[STACK_SIZE - N_CALLEE_REGISTERS - 1]; // minus 1 for the return value
    stack[STACK_SIZE - 1] = (uintptr_t) context_entry;
    context_switch(new_rsp);
    print_str("We are back!");
    free(stack);
    print_new_line();

    return 0;
}

void todo() {
    printf("\n"); // flush write buffer
    fprintf(stderr, "%s\n", "Solution not implemented yet!");
    exit(1);
}

void middle_of_nowhere(void* old_rsp) {
    print_str("Where are we?");
    print_new_line();
    context_switch(old_rsp);
}