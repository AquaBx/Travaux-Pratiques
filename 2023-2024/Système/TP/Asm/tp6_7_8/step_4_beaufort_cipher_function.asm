SECTION .data
message: db "HELLO WORLD!",10 ; input message with newline
len_msg: equ $-message ; length of input message

message2: db "SALUT",10 ; input message with newline
len_msg2: equ $-message2 ; length of input message

key: db "DIANA" ; key encoding the shift of the symmetry
len_key: equ $-key ; length of input message


SECTION    .text
  GLOBAL    _start

_encode: 
    _init:
        xor r9,r9
        xor r8,r8

    _begin:
        cmp [r15+r9], byte 'A'
        jl _end

        cmp [r15+r9], byte 'Z'
        jg _end

        xor rdx,rdx                       ; reset dl qui va contenir le reste
        mov rax, r8                       ; on met dans al parce que sinon dans rax tout casse
        mov rcx, r12                      ; on met le diviseur dans rcx
        div rcx                           ; on divise par rcx

        xor r10, r10
        add r10, 26
        add r10b, byte [r13+rdx]
        sub r10b, byte [r15+r9]

        xor rdx,rdx                       ; reset dl qui va contenir le reste
        mov rax, r10                      ; on met dans al parce que sinon dans rax tout casse
        mov rcx, 26                       ; on met le diviseur dans rcx
        div rcx                           ; on divise par rcx

        mov r11b, dl
        add r11b, 'A' 

        mov byte [r15+r9],r11b

        inc r8

    _end:
        inc r9

        cmp r9,r14-1
        jl _begin

    ret

_print:
    mov       rax, 1                  ; system call for write
    mov       rdi, 1                  ; file handle 1 is stdout
    mov       rsi, r15                ; address of string to output
    mov       rdx, r14                ; address of string to output
    syscall
    ret  

_start:

    mov r15, message ; addresse du message
    mov r14, len_msg ; taille du message
    mov r13, key     ; adresse de la clé
    mov r12, len_key ; taille de la clé

    call _encode
    call _print

    mov r15, message  ; addresse du message
    mov r14, len_msg  ; taille du message
    mov r13, key      ; adresse de la clé
    mov r12, len_key  ; taille de la clé

    call _encode
    call _print

    mov r15, message2  ; addresse du message
    mov r14, len_msg2  ; taille du message
    mov r13, key      ; adresse de la clé
    mov r12, len_key  ; taille de la clé

    call _encode
    call _print

    ;; EXITING PROGRAM
    mov       rax, 60                 ; system call for exit
    mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
    syscall                           ; invoke operating system to exit
