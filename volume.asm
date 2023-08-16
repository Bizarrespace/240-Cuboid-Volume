; Author information
; Author name: Long Vu 
; Author email: Longvu2000@csu.fullerton.edu
; Section number: 5

;===== Begin code area ================================================================================================

extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern atof

global volume

segment .data

ln1 db "Here at Cuboid Inc. we know your volume", 10, 0
ln2 db "The time is now %ld tics ", 10, 0
enterLength db "Please enter length: ", 0
enterWidth db "Please enter width: ", 0
enterHeight db "Please enter height: ", 0
totalVolume db "Thank you. Your volumne is %lf cubic units.", 10, 0
ln5 db "The time is now %ld tics", 10, 0
ln6 db "The run time was %ld tics", 10, 0

doubleFormat db "%lf",10, 0

segment .bss
length resb 32
width resb 32
height resb 32


segment .text
volume:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf       ;backup rflags

    push qword 0 ;Make sure that stack is aligned

;Print out the first line
    push qword 0
    mov rax, 0
    mov rdi, ln1
    call printf
    pop rax

;=================== Getting tics and printing it out before calculations =============================

;get tics and store in r14
;     xor rax, rax
;     xor rdx, rdx
;     xor r14, r14

;     cpuid
;     rdtsc
;     shl rdx, 32
;     add rax, rdx
;     mov r14, rax

; ;Print out the tics
;     push qword 0
;     mov rax, 0
;     mov rdi, ln2
;     mov rsi, r14
;     call printf
;     pop rax

    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov rdi, ln2
    mov rsi, rax
    mov rax, 0
    call printf

;================ Ask users to enter length, width, and height as float numbers =======================

;================ Length ========================
;Prompt for entering length
    push qword 0
    mov rax, 0
    mov rdi, enterLength
    call printf
    pop rax

;Fgets to get length
    push qword 0
    mov rax, 0
    mov rdi, length
    mov rsi, 32
    mov rdx, [stdin]
    call fgets
    pop rax

;strip trailing white-space
    mov      rdi, length
    call     strlen
    mov      r14, rax
    mov      r15, 0
    mov      [length + r14 - 1], r15

;put length into xmm15
    mov rdi, length
    call atof
    movsd xmm15, xmm0


;============= width ===============================
;Prompt for entering width
    push qword 0
    mov rax, 0
    mov rdi, enterWidth
    call printf
    pop rax

;Fgets to get width
    push qword 0
    mov rax, 0
    mov rdi, width
    mov rsi, 32
    mov rdx, [stdin]
    call fgets
    pop rax

;strip trailing white-space
    mov      rdi, width
    call     strlen
    mov      r14, rax
    mov      r15, 0
    mov      [length + r14 - 1], r15

;put width into xmm14
    mov rdi, width
    call atof
    movsd xmm14, xmm0


;============== Height ============================
;Prompt for entering Height
    push qword 0
    mov rax, 0
    mov rdi, enterHeight
    call printf
    pop rax

;Fgets to get Height
    push qword 0
    mov rax, 0
    mov rdi, height
    mov rsi, 32
    mov rdx, [stdin]
    call fgets
    pop rax

;strip trailing white-space
    mov      rdi, height
    call     strlen
    mov      r14, rax
    mov      r15, 0
    mov      [height + r14 - 1], r15

;put Height into xmm13
    mov rdi, height
    call atof
    movsd xmm13, xmm0

;==================== Calculate volume ================================

;xmm15 = Lenght, xmm14 = Width, xmm13 = Height
; volume = L*W*H

mulsd xmm15, xmm14
mulsd xmm15, xmm13

;xmm15 = volume

;print out total volume
    push qword 0
    mov rax, 1
    mov rdi, totalVolume
    movsd xmm0, xmm15
    call printf
    pop rax
;======================== Get tics at the end ==================================

;get tics and store in r15 
    xor rax, rax ;Makes sure that the registers that we going to use are all 0s
    xor rdx, rdx
    xor r15, r15

    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r15, rax


;print tics
    push qword 0
    mov rax, 0
    mov rdi, ln5
    mov rsi, r15
    call printf
    pop rax
    ; cpuid
    ; rdtsc
    ; shl rdx, 32
    ; add rax, rdx
    ; mov rdi, ln5
    ; mov rsi, rax
    ; mov rax, 0
    ; call printf

;================ Get the total time for the computation ==================
    sub r15, r14

    cvtsi2sd xmm10, r15 
    push qword 0
    mov rax, 1
    mov rdi, ln6
    movsd xmm0, xmm10
    call printf
    pop rax


;move volume to xmm0 so that driver.cpp can see it
    movsd xmm0, xmm15

    pop rax ;Restore stack
    ;restores stack to original state
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret ;  return
