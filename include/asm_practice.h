#ifndef ASM_PRACTICE_H_
#define ASM_PRACTICE_H_

#include <stdbool.h>
#include <stdint.h>

extern void print_str(const char* str);
extern void print_int(int i);
extern void print_arr(int n_elems, const int* arr);
extern void print_new_line();
extern void print_begin();
extern int get(int idx, const int* arr);
extern void swap(int* a, int* b);
extern bool cond_swap(int* a, int* b);
extern void bubble_up(int count, int* start);
extern void bubble_sort(int arr_len, int* arr);
extern int fib_recursive(int n);
extern void* context_switch(void* new_rsp);
void context_entry();
void middle_of_nowhere(void* old_rsp);
#endif