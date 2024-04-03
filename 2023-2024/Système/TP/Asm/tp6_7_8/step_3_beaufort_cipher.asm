SECTION .data
message: db "HELLO WORLD!",10 ; input message with newline
len_msg: equ $-message ; length of input message
key: db "DIANA" ; key encoding the shift of the symmetry
len_key: equ $-key ; length of input message


SECTION    .text
  GLOBAL    _start

_start:
    xor r15,r15
    xor r12,r12

    _loop:
        cmp [message+r15], byte 'A'
        jl _end

        cmp [message+r15], byte 'Z'
        jg _end

        xor rdx,rdx                         ; reset dl qui va contenir le reste
        mov rax, r12                 ; on met dans rax
        mov rcx, len_key                       ; on met le diviseur dans rcx
        div rcx                           ; on divise par rcx

        xor r14,r14
        add r14,26
        add r14b, byte [key+rdx]
        sub r14b, byte [message+r15]

        xor rdx,rdx                         ; reset dl qui va contenir le reste
        mov rax, r14                 ; rax
        mov rcx, 26                       ; on met le diviseur dans rcx
        div rcx                           ; on divise par rcx

        mov r13b, dl
        add r13b, 'A' 

        mov byte [message+r15],r13b

        inc r12

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
