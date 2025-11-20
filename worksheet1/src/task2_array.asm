; task2_array.asm
; Creates array 1..100, sums and prints the sum

%include "asm_io.inc"

section .data
    msg_prefix db "Array sum = %i",10,0
    local_int  db "%i",0

section .bss
    arr resd 100

section .text
    global asm_main_array

    extern printf
    extern print_string

asm_main_array:
    push    ebp
    mov     ebp, esp

    ; initialize array with 1..100
    mov     ecx, 100
    xor     esi, esi
    mov     ebx, 1
.init_loop:
    mov     [arr + esi*4], ebx
    inc     esi
    inc     ebx
    loop    .init_loop

    ; sum into eax
    xor     eax, eax
    mov     ecx, 100
    xor     esi, esi
.sum_loop:
    add     eax, [arr + esi*4]
    inc     esi
    loop    .sum_loop

    ; print prefix + sum
    push    eax
    push    dword msg_prefix
    call    printf
    add     esp, 8

    leave
    ret
