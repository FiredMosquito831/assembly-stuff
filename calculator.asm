name "calculator"
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



main:
    mov al, 10
    call print_func
    mov bl, 20
    call addition
    
    push ax
    push bx

ret


addition:
  add al, bl 
   
ret

substraction:
  sub al, bl
ret

multi:
    mul bl ; implicitely multiplies AX with BL and stores its result in AX

ret

division:
    div bl
ret             



print_func:
    mov cl, 8
    print_loop:
       mov ah, 2
       push ax
       mov dl, '0'
       test al, 10000000b    ; this tests to see if the MSB is 0, if it is 0 ZF remains 0
       jz skip       ; jump to skip if the zero flag is 0
       mov dl, '1'
       skip:
       int 21h
       pop ax
       shl al, 1
       push ax    
    loop print_loop
    push ax
    mov dl, ' '
    int 21h      
    pop ax
    ret
   