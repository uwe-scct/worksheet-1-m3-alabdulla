; task2_range.asm
; Asks user to enter low and high indices, checks valid range, sums and prints result.

%include "asm_io.inc"

section .data
    msg_prompt_low   db "Enter low index (1-100): ",0
    msg_prompt_high  db "Enter high index (1-100): ",0
    msg_range_err    db "Invalid range",10,0
    msg_sum_fmt      db "Range sum = %i",10,0

    local_int        db "%i",0

section .bss
    arr resd 100

section .text
    global asm_main_range

    extern scanf
    extern printf
    extern print_string

asm_main_range:
    enter   8,0        ; reserve space for two ints at [ebp-4] and [ebp-8]
    pusha

    ; initialize array 1..100
    mov     ecx, 100
    xor     esi, esi
    mov     ebx, 1
.init_arr:
    mov     dword [arr + esi*4], ebx
    inc     esi
    inc     ebx
    loop    .init_arr

    ; prompt low
    lea     eax, [msg_prompt_low]
    call    print_string

    lea     eax, [ebp-4]    ; address to store low
    push    eax
    push    dword local_int
    call    scanf
    add     esp, 8

    ; prompt high
    lea     eax, [msg_prompt_high]
    call    print_string

    lea     eax, [ebp-8]    ; address to store high
    push    eax
    push    dword local_int
    call    scanf
    add     esp, 8

    mov     eax, [ebp-4]    ; low
    mov     ebx, [ebp-8]    ; high

    ; validate 1 <= low <= high <= 100
    cmp     eax, 1
    jl      .invalid
    cmp     ebx, eax
    jl      .invalid
    cmp     ebx, 100
    jg      .invalid

    ; compute sum from low..high
    xor     ecx, ecx        ; ecx = sum (32-bit)
    mov     edi, eax        ; edi = current index
.sum_loop:
    mov     eax, [arr + (edi-1)*4]
    add     ecx, eax
    inc     edi
    cmp     edi, ebx
    jle     .sum_loop
    ; add last element ebx
    mov     eax, [arr + (ebx-1)*4]
    add     ecx, eax

    ; print result using printf format "%i\n"
    push    ecx
    push    dword msg_sum_fmt
    call    printf
    add     esp, 8

    jmp     .done

.invalid:
    lea     eax, [msg_range_err]
    call    print_string

.done:
    popa
    leave
    ret
