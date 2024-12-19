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


### Check if console input is a digit or not, can be adjusted to check if character or not
```asm

; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
; int 21h command console
; mov ah, 01h for reading from console  DOS INTERRUPT
; mov ah, 08h for reading from console  DOS INTERRUPT without echo

; mov ah, 02h for printing from console DOS INTERRUPT
; mov bx, 1234    ; 04D2 hex     0-9 30-39    61-68 hex we have a-h

main:

mov cl, 4

read_loop:
mov ah, 01h ; dos interrupt for reading from console   with echo
int 21h
mov bl, al  ; we store each value 1 by 1 inside bl then we call the check_if_digit func
call check_if_digit
mov ah, 02h
mov dl, ' '
int 21h

loop read_loop

popa

ret


check_if_digit:       ;condition bigger 29h  below 3Ah can be done with jumps and comparisons jb
cmp al, 39h ; =9  ; compares registry value with the highest possible value, if below continue checking 
                  ;if higher than lowest limit else jump to not digit
ja is_not_digit
cmp al, 30h ; =0  ; compares registry value with the lowest possible value
                  ; if below or lower than the lowest limit 30h (0) then we jump to is_not_digit 
jb is_not_digit
call is_digit


ret


is_not_digit:
mov ah, 02h
mov dl, 'n' ; not digit
int 21h
ret


is_digit:
mov ah, 02h
mov dl, 'y' ; is digit
int 21h
ret
```

### Read 4 chars check if they are digits then compose the number and store its total value in hex (ex: 1 2 3 4, all digits, stored number is 1234 as hex 04D2h) and print it

```asm

; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
; int 21h command console
; mov ah, 01h for reading from console  DOS INTERRUPT
; mov ah, 08h for reading from console  DOS INTERRUPT without echo

; mov ah, 02h for printing from console DOS INTERRUPT
; mov bx, 1234    ; 04D2 hex     0-9 30-39    61-68 hex we have a-h

; we will use bl to store the true or false for all digit or not


main:

mov cx, 4
read_loop:
mov ah, 01h ; dos interrupt for reading from console   with echo
int 21h
call check_if_digit
mov ah, 02h
mov dl, ' '
int 21h
loop read_loop


check_all_digits:     
; if the flag which checks whether all chars are digits is false we call exit func otherwise we jump over it to hex conv
cmp bx, 0x0000h
jz conv_to_hex
call exit_func





exit_func:
popa
mov ah, 4ch  ; DOS service to terminate a program similar to exit
int 21h      ; DOS interrupt

ret


check_if_digit:       ;condition bigger 29h  below 3Ah can be done with jumps and comparisons jb
cmp al, 39h ; =9  ; compares registry value with the highest possible value, if below continue checking 
                  ;if higher than lowest limit else jump to not digit
ja is_not_digit
cmp al, 30h ; =0  ; compares registry value with the lowest possible value
                  ; if below or lower than the lowest limit 30h (0) then we jump to is_not_digit 
jb is_not_digit
call is_digit


ret


is_not_digit:
mov ah, 02h
mov dl, 'n' ; not digit
int 21h
mov bx, 0xffffh
ret

                      
; we will use SI and DI to store the digits  and bl to check whether or not what we have is all digits or not
                      
is_digit:

filling_si:
cmp si, 0000h ; we check if the registry is empty 

jz insert_and_shift_si

push si  ; push si into the stack to have a temp copy

and si, 0xF0F0h ; we all the latter 3 hex in order to only check if a digit is on the left side of the registry

cmp si, 3000h ; we check if the higher part of the reg is full but lower empty

pop si

jz insert_and_no_shift_si:

push si
and si, 0xF0F0h
cmp si, 3030h ; we check if the registry is empty
pop si
jz filling_di


insert_and_no_shift_si:
and ax, 0x00ffh
add si, ax
jmp print_yes

insert_and_shift_si:
and ax, 0x00ffh
add si, ax
shl si, 8
jmp print_yes


; WE REPEAT THE SAME STEPS FOR DI ONLY IF SI IS FULL
filling_di:
cmp di, 0000h ; we check if the registry is empty 

jz insert_and_shift_di

push di  ; push si into the stack to have a temp copy

and di, 0xF000h ; we all the latter 3 hex in order to only check if a digit is on the left side of the registry

cmp di, 3000h ; we check if the higher part of the reg is full but lower empty

pop di

jz insert_and_no_shift_di:

push di
and di, 0xF0F0h
cmp di, 3030h ; we check if the registry is empty
pop di
jz filling_di

insert_and_no_shift_di:
and ax, 0x00ffh
add di, ax
jmp print_yes

insert_and_shift_di:
and ax, 0x00ffh
add di, ax
shl di, 8
jmp print_yes



print_yes:
mov ah, 02h
mov dl, 'y' ; is digit
int 21h
ret




conv_to_hex:
call create_number ; after we create the number and store it into cx we have to begin printing its hex

; in order to print hex values we must check wether we actually have a digit or not and if we have a digit we print and do modulo 30 to get the digits (30-39 0-9 OR modulo 40 if it is above 41-46 hex)
; we will print hex by hex (1 at a time so 4 bits at a time) we check if 30 + val is bigger than 39 if not we print first digit else we print starting from 41 + val - 10 (41 is A, 41 + B - 10 = 41 + 11 - 10 = 42 = B)
; we extract the char from cx left to right 1 by 1
; in our case we have 1 hex at a time so 0-F, we check if the hex is <A if is we do 30 + val else 41 + val - 10
mov bx, cx                                                                                                 
mov cx, 4
print_loop:
push bx
and bx, 0xF000h
shr bx, 12 ; we move the right most value on the left to start the comparison

check_below_9:
cmp bx, 0x0009h

jb below_9_digit
; else we check for hex dig
mov dl, 'A'
add dl, bl
sub dl, 10
jmp refresh

below_9_digit:
mov dl, '0'
add dl, bl

refresh:
pop bx
shl bx, 4

mov ah, 2
int 21h
loop print_loop  ; printed in hex
mov dl, 'h'
int 21h
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
ret

create_number:      ; we will create the number in the bx registry with the help of cx as they now free to use
                    ; also we will divide the ascii values by 30 to get the real nr for ex: 30 % 30 = 0 | 31 % 30 = 1 etc
                    ; number is created like this right to left (di to si) 1 * x1 + 10 * x2 + 100 * x3 + 1000 * x4
                    ; store the digit and rem in ax or cx we will see
xor bx, bx          ; free up the registers we will use
xor ax, ax
xor cx, cx          ; CX will contain the total number
xor dx, dx

; extract si into cx
mov bx, si
add al, bh
mov dl, 30h
div dl
and al, 0x00h
xchg al, ah
mov dx, 1000
mul dx
add cx, ax 

xor ax, ax

add al, bl
mov dl, 30h
div dl
and al, 0x00h ; remove the whole part of the div and keep remainder, remainder is on ah and whole part al
xchg al, ah   ; move the rest on the right side of ax, since rest is held on ah
mov dx, 100
mul dx
add cx, ax

; repeat for di

mov bx, di
xor ax, ax
add al, bh
mov dl, 30h
div dl
and al, 0x00h
xchg al, ah
mov dx, 10
mul dx
add cx, ax 

xor ax, ax

add al, bl
mov dl, 30h
div dl
and al, 0x00h ; remove the whole part of the div and keep remainder, remainder is on ah and whole part al
xchg al, ah   ; move the rest on the right side of ax, since rest is held on ah
mov dx, 1
mul dx
add cx, ax
ret

; IT WORKS IT STORES INSIDE OF CX THE WANTED VALUE   
; IT WORKS IT STORES INSIDE OF CX THE WANTED VALUE
```





