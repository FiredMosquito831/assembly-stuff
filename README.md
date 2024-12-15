# assembly-stuff
this repo is for me learning assembly and doing random stuff in assembly


### My first exercise is a code which prints in binary all the numbers in ascending order from 1 to the value of CL

```asm
name "print all numbers in binary until CL"
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
; AX (Accumulator Register): Used for arithmetic, I/O, and data movement.
; BX (Base Register): Often used as an address pointer for memory operations.
; CX (Count Register): Used for loop counters or string operations.
; DX (Data Register): Used for I/O operations or extended arithmetic.
;2. Segment Registers:
; CS (Code Segment): Holds the segment address of the program code.
; DS (Data Segment): Points to data used by the program.
; SS (Stack Segment): Points to the stack.
; ES, FS, GS: Additional segments for special purposes.
;3. Instruction-related Registers:
; IP (Instruction Pointer): Points to the next instruction.
; Flags Register (EFLAGS): Stores condition flags (e.g., Zero Flag, Carry Flag).
;4. Pointer and Index Registers:
; SP (Stack Pointer): Points to the top of the stack.
; BP (Base Pointer): Used for stack frame referencing.
; SI (Source Index): Used in string operations.
; DI (Destination Index): Used in string operations.

mov cl, 69 ; initial counter for the main loop which is loopa  
xor bh, bh  ; we use xor on bh to fill it with 0
loopa:
    mov dh, cl  ; store the current counter of CL into AL for refference for when we exit the inner loop
    add bh, 1
    mov bl, bh
    
mov cl, 8   ; setting the counter for print_loop, for printing 8bit number in chars
print_loop: 
    mov ah, 2   ; DOS INTERRUPT FOR PRINTING CHARACTER
    mov dl, '0' ; we assume that the bit is 0
    test bl, 10000000b ; testing the first bit of bl (highest bit), if it is dif from 0 ZF = 1  
    ; side note i accidentally checked for 7 bits instead of 8 which moved all the bits to the left by 1
    jz skip ; if the zero flag is 1 it skips to skip, in this case it skips setting dl to 1
    mov dl, '1'
skip:
    int 21h  ; PRINT CHARACTER INSDE OF DL
    shl bl, 1     ; SHIFT BL LEFT TO BRING the next bit to the highest position
    loop print_loop   ; looping the print loop 
    mov cl, dh                               
    sub dh, 1
    mov dl, ' '
    int 21h
    mov ah, 2
    int 21h  
    mov ah, 2                       
loop loopa        ; loop repeats everything below loopa until cx == 0

ret




```
