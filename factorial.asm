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