# Assembly Practice Problems
### Getting started
* To compile, run `make build`.
* To clean the build directory, run `make clean`.
* To compile the reference solution, run `SRC="ref" make build`

### Tips and Tricks
* Read the code under `sample assembly` and use them as skeletons in your design
* Use gdb to debug your assembly
* Avoid looking at the reference solution
* Make sure that your stack is 16-byte aligned, especially so if you call library functions (e.g. `printf`)
    * When a function is called, the return value is pushed onto the stack, making the stack *not* aligned
    * Pushing `%rbp` to save the previous stack frame at the beginning of the function restores the stack alignment
    * Make sure that when saving local variables onto the stack that you decrement or increment by an amount divisible
      by 16 before you call a function!
* Try out the context switch problem; will be very useful in Operating Systems