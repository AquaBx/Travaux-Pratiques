SECTION .data
message: db "CA BOUM ICI!", 10 ; input message with newline
len_msg: equ $-message ; length of input message

SECTION    .text
  GLOBAL    _start

_start:
    xor r15,r15

    _loop:
        cmp [message+r15], byte 'A'
        jl _end

        cmp [message+r15], byte 'Z'
        jg _end

        mov r14,'Z'
        sub r14b, byte [message+r15]
        add r14,'A'

        mov byte [message+r15],r14b

        _end:

        inc r15
        cmp r15,len_msg-1
        jl _loop
    
    mov       rax, 1                  ; system call for write
    mov       rdi, 1                  ; file handle 1 is stdout
    mov       rsi, message            ; address of string to output
    mov       rdx, len_msg            ; address of string to output
    syscall   

    ;; EXITING PROGRAM
    mov       rax, 60                 ; system call for exit
    mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
    syscall                           ; invoke operating system to exit
