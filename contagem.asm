BITS 64

section .data
    newline db 10

section .bss
    buffer resb 12

section .text
global _start

_start:
    mov r13, 1                ; contador, começa em 1

loop_contagem:
    cmp r13, 10
    jg fim                     ; se contador > 10, encerra o loop

    mov rax, r13               ; copia o contador pra RAX (vai ser convertido)

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

    mov r12, rsi               ; início da string numérica

    ; imprime o número
    lea rdx, [rel buffer + 11]
    sub rdx, r12
    mov rax, 1
    mov rdi, 1
    mov rsi, r12
    syscall

    ; imprime quebra de linha
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel newline]
    mov rdx, 1
    syscall

    inc r13                    ; contador++
    jmp loop_contagem

fim:
    mov rax, 60
    xor rdi, rdi
    syscall