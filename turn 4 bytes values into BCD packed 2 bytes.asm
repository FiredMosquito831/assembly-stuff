
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
mov bh, 4
mov bl, 3
mov ah, 2
mov al, 1

mov cl, bh
loop_bh:
inc dx

loop loop_bh

shl dx, 4

mov cl, bl
loop_bl:
inc dx
loop loop_bl

shl dx, 4 
 
mov cl, ah
loop_ah:
inc dx
loop loop_ah

shl dx, 4

mov cl, al
loop_al:
inc dx

loop loop_al


ret




