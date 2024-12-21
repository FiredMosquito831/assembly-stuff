
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here


; mov ah, 02h ; interrupt for printing



input_number_1:
mov ah, 01h  ; DOS interrupt for reading from console
int 21h
cmp al, '-'
jne pos_num1:

xor bx, bx
neg_num1:
int 21h
add bl, al
shl bx, 8

int 21h
add bl, al
neg bx

jmp add_space

pos_num1:
add bl, al
shl bx, 8
int 21h
add bl, al

add_space:
; add break between nums
mov ah, 02h ; dos interrupt for printing to console
mov dl, ' ' ; prints what is inside of dl
int 21h      


input_number_2:
mov ah, 01h  ; DOS interrupt for reading from console
int 21h
cmp al, '-'
jne pos_num2:

neg_num2:
xor cx, cx
int 21h
add cl, al
shl cx, 8

int 21h
add cl, al
neg cx

jmp addition:


pos_num2:
xor cx, cx
add cl, al
shl cx, 8
int 21h
add cl, al


addition:
add bx, cx ; we store the value inside of bx



