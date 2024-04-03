SECTION .data
i db 3
n db 0
text db 48,10

SECTION .text
    GLOBAL _start


_start:
    mov r15b, byte [i]
    mov r14b, byte [n]

_loop:
    mov rax,1
    mov rdi,1
    mov rsi,text
    mov rdx,2
    syscall

    dec r15
    cmp r15,r14
    jg _loop

_quit:
    mov rax, 60
    mov rdi, 0
    syscall



