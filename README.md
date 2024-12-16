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


### Work in progress CALCULATOR


```asm
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
   ```

### Factorial of a number

```asm
name "factorial"
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


; we will use the ax register to store all multiplication and factorial



factorial:
mov al, 1
;mov bl, 2
mov cl, 5

repa:
mul cl

loop repa

xor dl, dl
mov bl, al  ; we use bx to store the val is al, since al is used in I/O operation and its registry gets changed during printing
mov cx, 8
print:
mov dl, '0'
test bl, 10000000b
jz skip 
mov dl, '1'
skip:
mov ah, 2 ; dos interrupt
int 21h
shl bl, 1
loop print

ret
```



### BCD addition unpacked on 2 bytes
```asm
name "sum of 2 two-digit numbres in BCD"

;unpacked 1 digit per 8 bits
;packed 1 digit per 4 bits
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


;how to mask a nibble in a registry:
;move al, 24h
; And al, 0fh   makes 2 into 0
; and al, f0h makes 4 into 0
; we can use cmp to see if we are out if the decimal range to adjust accordingly
org 100h


; note to self 1 registry AX, contains 1 value, split on 8 biti each, so AL has 1 part and AH 1 part
                                            
; add your code here

main:
mov bx, 18    ; all stored in hex
mov dx, 20                                              
add bl, dl     ; we add the lower registers, also if there is a overflow and the carry flag switches we add the higher registers with the carry in mind
adc bh, dh     ; we store the addition in the bx registry, also we add with carry in case we had an overflowq
mov cl, 16

; NOTE TO KEEP IN MIND ALL THE ADDITIONS ARE STORED IN BX WHICH MEANS THE RESULT IS IN BX, AX and DX are used for printing, CX for counter

print_func:
mov ah, 02h   ;DOS console interrupt
mov dl, '0'   ;we assume that always the first bit will be 0
push bx ; we push bx to the stack because we first print BH then BL, we need to manipulate BX while printing 
test bx, 1000000000000000b  ; we will check the most signicant bit, if it is 0 the zero flag stays else 1
jz skip:        ; if the zero flag is 0 it will jump over to the skip func 
mov dl, '1'
skip:
int 21h  ; DOS printing command from DL
shl bx, 1 ; we move all the elements of bx to the left after each iteraton to check all bits one by one from left to right, we print starting from the left to the right, we stop once we print all 16 bits

loop print_func
```




