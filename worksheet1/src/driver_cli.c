#include <stdio.h>
#include <string.h>

extern void asm_main(void);
extern void asm_main2(void);
extern void asm_main_name(void);
extern void asm_main_array(void);
extern void asm_main_range(void);

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <task>\n", argv[0]);
        printf("Tasks: task1 task1.2 task2_name task2_array task2_range\n");
        return 1;
    }

    if (strcmp(argv[1], "task1") == 0) {
        asm_main();
    } else if (strcmp(argv[1], "task1.2") == 0) {
        asm_main2();
    } else if (strcmp(argv[1], "task2_name") == 0) {
        asm_main_name();
    } else if (strcmp(argv[1], "task2_array") == 0) {
        asm_main_array();
    } else if (strcmp(argv[1], "task2_range") == 0) {
        asm_main_range();
    } else {
        printf("Unknown task '%s'\n", argv[1]);
        return 2;
    }
    return 0;
}
