
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h



mov al, 0h
call DIVZERO
      

program_exit:
mov ah, 4Ch
int 21h                   ; assumptions if the val in al is != 0 the program does nothing else it just returns current value, pretty much nothing happens
ret


DIVZERO:
cmp al, 0
jz zero
mov al, al
zero:

ret

