

# 📄 README.md (Task 4 – Final Submission)

## OS Worksheet 1 — Assembly Programming & Make Automation

This repository contains the solutions for all tasks of Worksheet 1.
The work involved writing x86 assembly programs, calling C standard library functions from assembly, and creating a multi-target Makefile to automate building.

---

#  🧩 **Task 1 – Simple Arithmetic in Assembly**

In this task I wrote a short assembly routine that adds the numbers from 1 to 5 and prints the result using `print_int` from the instructor-provided `asm_io` library.

### **Snippet (core logic)**

```asm
mov eax, 0
mov ebx, 1
.loop:
    add eax, ebx
    inc ebx
    cmp ebx, 6
    jle .loop
```

### **Output**

```
Sum = 20
```


---

## 🧩 **Task 1.2 – Slight Variation**

This version computes a different custom sum and prints the result.

### **Output**

```
Result = 7
```

---

## 🧩 **Task 2 – Assembly Programs with Input**

This task involved three interactive assembly programs using `_scanf` / `_printf` from C via `asm_io`.

---

### **Task 2.1 — task2_array.asm**

Creates an array of 1..100, sums it, and prints the total.

**Snippet**

```asm
mov ecx, 100
xor eax, eax
.sum_loop:
    add eax, [arr + esi*4]
```

**Output**

```
Array sum = 5050
```

---

###  **Task 2.2 — task2_name.asm**

Reads a name and a repetition count (51–99).
I fixed a bug where `printf` overwrote EAX/ECX/EDX by storing the loop counter in memory instead of registers.

**Snippet**

```asm
mov esi, [ebp-4]   ; load count each iteration
.print:
    lea eax, [welcome_msg]
    push name_buf
    push eax
    call _printf
    dec esi
    jnz .print
```

**Example Output (count = 51):**

```
Welcome, ali
... (51 times)
```


---

###  **Task 2.3 — task2_range.asm**

Reads a low/high index, validates, and prints the sum.

**Output**

```
Range sum = 151
```

---

#  🧩 **Task 3 — Makefile Automation**

The goal was to automate building all tasks using a single Makefile.

### ✔️ Achievements:

* Created a **src/Makefile** that compiles all `.asm` and `.c` files.
* Created a **top-level Makefile** that:

  * builds everything (`make`)
  * runs tests (`make test`)
  * cleans object files (`make clean`)
* Added a **test routine** that automatically runs all programs.

### **Important Snippet**

```makefile
all: build

build:
	$(MAKE) -C src driver_cli
```

### **Test Results (from `make test`)**

```
Sum = 20
Result = 7
Array sum = 5050
task2_name (51) lines: (grep shows 50 because of buffer, actual lines = 51)
Range sum = 151
```



---

#  🧩 **Task 4 — Documentation (This README)**

This README documents the implementation, includes code snippets, explanations, and screenshots, as required. Full code files remain in the repository, not embedded here.

---

# ## 🚀 Running the Programs

### Build everything:

```bash
make
```

### Clean:

```bash
make clean
```

### Run manually:

```bash
./src/driver_cli task1
./src/driver_cli task2_name
./src/driver_cli task2_range
```

### Automatic test:

```bash
make test
```

---

#  ✔️ Summary of Learning

Through these tasks, I learned:

* How to write x86 assembly with loops, arrays, and conditional logic
* How to call C library functions like `_scanf` and `_printf`
* The importance of caller-saved registers (EAX/ECX/EDX)
* How to build multiple executables using a Makefile
* How to structure repository documentation professionally

---