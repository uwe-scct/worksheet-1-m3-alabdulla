; task2_name.asm (robust memory-counter version)
; Reads name (string) and an integer count, validates (51-99)
; prints welcome message exactly count times. Counter is stored in memory.

%include "asm_io.inc"

section .bss
    name_buf  resb 128

section .data
    prompt_name    db "Enter your name: ",0
    prompt_count   db "Enter number of times (51-99): ",0
    err_msg        db "Error: number too large or too small",10,0
    welcome_msg    db "Welcome, %s",10,0

    local_str      db "%s",0
    local_int      db "%i",0

section .text
    global asm_main_name

    extern scanf
    extern printf
    extern print_string

asm_main_name:
    enter   8,0          ; reserve 8 bytes for local storage at [ebp-4] and [ebp-8]
    pusha

    ; prompt: name
    lea     eax, [prompt_name]
    call    print_string

    ; scanf("%s", name_buf)
    push    name_buf
    push    dword local_str
    call    scanf
    add     esp, 8

    ; prompt: count
    lea     eax, [prompt_count]
    call    print_string

    ; read integer into [ebp-4]
    lea     eax, [ebp-4]
    push    eax
    push    dword local_int
    call    scanf
    add     esp, 8

    ; validate range 51..99 using a temp register, then store count to [ebp-8]
    mov     eax, [ebp-4]
    cmp     eax, 51
    jl      .err
    cmp     eax, 99
    jg      .err

    ; store count into memory counter slot [ebp-8]
    mov     [ebp-8], eax

.print_loop:
    ; load counter
    mov     eax, [ebp-8]
    cmp     eax, 0
    jle     .done_loop

    ; print welcome (printf takes format then args on stack)
    push    dword name_buf
    push    dword welcome_msg
    call    printf
    add     esp, 8

    ; decrement counter in memory
    dec     dword [ebp-8]
    jmp     .print_loop

.done_loop:
    popa
    leave
    ret

.err:
    lea     eax, [err_msg]
    call    print_string
    popa
    leave
    ret
