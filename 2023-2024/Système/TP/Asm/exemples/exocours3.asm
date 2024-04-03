SECTION .data
message : db 'HEL#LO WORLD', 10
len : equ $-message

SECTION .text
    GLOBAL _start


_start:
    mov r15,0
    _loop:

        mov r14b, byte [message+r15]
        cmp r14,'A'
        jl end
        cmp r14,'Z'
        jg end
    
        add r14, 32
        mov [message+r15], r14b

        end:
            inc r15
            cmp r15,len-1
            jl _loop

    mov rax,1
    mov rdi,1
    mov rsi,message
    mov rdx,len
    syscall 

_quit:
    mov rax, 60
    mov rdi, 0
    syscall



