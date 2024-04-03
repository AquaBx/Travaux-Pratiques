SECTION .data
x: dw 5
y: dw 10

text1 db "0",10
text2 db "1",10

SECTION .text
    GLOBAL _start


_start:
    mov r14b, byte [x]
    mov r15b, byte [y]
    cmp r14,r15
    jl _true ; if r14 < r15 :

    _false:
        mov rax,1
        mov rdi,1
        mov rsi,text1
        mov rdx,2
        syscall
        jmp _endif
    _true:
        mov rax,1
        mov rdi,1
        mov rsi,text2
        mov rdx,2
        syscall 
    _endif:
    


_quit:
    mov rax, 60
    mov rdi, 0
    syscall



