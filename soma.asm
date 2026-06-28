BITS 64

section .data
    msg db "Resultado da soma: ", 0
    msg_len equ $ - msg - 1
    newline db 10

section .bss
    buffer resb 12

section .text
global _start

_start:
    mov rax, 15
    mov rbx, 27
    add rax, rbx             ; RAX = 42

    lea rsi, [rel buffer + 11]
    mov byte [rsi], 0
    mov rcx, 10

converte:
    dec rsi
    xor rdx, rdx
    div rcx
    add rdx, '0'
    mov [rsi], dl
    test rax, rax
    jnz converte

    mov r12, rsi              ; salva início da string numérica

    ; imprime "Resultado da soma: "
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel msg]
    mov rdx, msg_len
    syscall

    ; imprime o número convertido
    lea rdx, [rel buffer + 11]
    sub rdx, r12              ; tamanho da string numérica
    mov rax, 1
    mov rdi, 1
    mov rsi, r12
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall