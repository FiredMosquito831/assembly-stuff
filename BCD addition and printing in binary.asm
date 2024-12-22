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