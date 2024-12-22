name "read string 2 numbers -64 to 64 and calc their sum print in bin and hex"

org 100h

; add your code here
              
              
              
; mov ah, 0Ah DOS INTERRUPT FOR READING STRINGS

; we will define a memory segment in which to store the read string, we will define 2 words(1 word = 16 bits) using dw
; we use words (2bytes) instead of 1 byte, because 64 is a 1 byte val, but we need space for the sign too


first_num db 10     ; Max input size (including the null byte) for the first number
len1 db 0           ; Store the actual length of the first input
num1 dw 0
                  ; after this reading will be done by loading address into buffer I.E lea dx, first_num  then calling interrupt
number1:
mov ah, 0Ah ; DOS INTERRUPT FOR READING STRINGS
lea dx, first_num       ; load effective address into dx
int 21h                 ; after reading the first_num[0] is max length, first_num[1] is actual input len, first_num[2] is the first char of actual input

calc_len1:
lea dx, len1
mov al, [first_num + 1]
mov [len1], al

call add_space


second_num db 10    ; Max input size (including the null byte) for the second number
len2 db 0           ; Store the actual length of the second input
num2 dw 0    
number2:
mov ah, 0Ah ; DOS INTERRUPT FOR READING STRINGS
lea dx, second_num
int 21h              

calc_len2:
lea dx, len2
mov al, [second_num + 1]
mov [len2], al                     

; mov ah, 02h ; interrupt for printing
              

call clear_all_registers

compose_number1:
; the start index is equal to length1
mov si, 2

check_neg1:
mov cl, [first_num + 2]
cmp cl, '-'
jne not_negate1
mov bp, 0xffffh
inc si
mov cl, [len1]
dec cl
mov [len1], cl 
not_negate1:
xor bx, bx
mov cl, [len1]


create_loop_1:
push cx
mov ax, 1    
; loop used to create the power of the number per digit high to low, I E 100 10 1
create_pow_for_nr1:
cmp cx, 1
je skip1
mov dl, 10
mul dl
cmp cx, 0     ; in order to prevent inf loop we check if cx is 0, if it is 0 we set it to one si prevent inf loop, 0000 - 1 = FFFF, we need 0001 - 1 = 0000 to end loop properly
jne skip1
mov cx, 1
skip1:
loop create_pow_for_nr1:
xor dx,dx
mov dx, ax ; move the current power of 10 inside of dx to mult with the digit

extract_digit_from_memory1:
mov al, [first_num+si]
push dx
mov dx, 30h
div dl ; we do module 30 to obtain in the remainder the actual value, not the ascii code (30 - 39 we get 0 - 9)
pop dx
and al, 0x00h ; remainder is in ah, whole part in al
shr ax, 8
mul dx
add bx, ax    ; we hold the total value in bx

 
pop cx
inc si 
loop create_loop_1

cmp bp, 0xffffh
jne not_neg11
neg bx
not_neg11:
xor bp, bp
; check if the number is neg by checking if the first input char is equal to '-'

; we compose the second number from the string
; push bx  ; store the first number in the stack
mov num1, bx
call clear_all_registers  ; clear the registers again
xor bp, bp 


compose_number2:
; the start index is equal to length2
mov si, 2

check_neg2:
mov cl, [second_num + 2]
cmp cl, '-'
jne not_negate2
mov bp, 0xffffh
inc si
mov cl, [len2]
dec cl
mov [len2], cl 
not_negate2:
xor bx, bx
mov cl, [len2]


create_loop_2:
push cx
mov ax, 1    
; loop used to create the power of the number per digit high to low, I E 100 10 1
create_pow_for_nr2:
cmp cx, 1
je skip2
mov dl, 10
mul dl
cmp cx, 0     ; in order to prevent inf loop we check if cx is 0, if it is 0 we set it to one si prevent inf loop, 0000 - 1 = FFFF, we need 0001 - 1 = 0000 to end loop properly
jne skip2
mov cx, 1
skip2:
loop create_pow_for_nr2:
xor dx,dx
mov dx, ax ; move the current power of 10 inside of dx to mult with the digit

extract_digit_from_memory2:
mov al, [second_num+si]
push dx
mov dx, 30h
div dl ; we do module 30 to obtain in the remainder the actual value, not the ascii code (30 - 39 we get 0 - 9)
pop dx
and al, 0x00h ; remainder is in ah, whole part in al
shr ax, 8
mul dx
add bx, ax    ; we hold the total value in bx

 
pop cx
inc si 
loop create_loop_2

cmp bp, 0xffffh
jne not_neg12
neg bx
not_neg12:
xor bp, bp
; check if the number is neg by checking if the first input char is equal to '-'

; we compose the second number from the string
; push bx  ; store the first number in the stack
mov num2, bx
call clear_all_registers  ; clear the registers again
xor bp, bp

addition:
mov bx, num1
mov cx, num2
add bx, cx

push bx

call add_space

mov cx, 16
print_binary:
test bx, 1000000000000000b ; we check the most significant bit
mov dl, '0'
jz skip_print_bin
mov dl, '1'    

skip_print_bin:
mov ah, 02h
int 21h
shl bx, 1
loop print_binary

call add_space
pop bx

print_hex:


mov cx, 4
print_loop_hex:
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
loop print_loop_hex  ; printed in hex
mov dl, 'h'
int 21h
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx

call exit




add_space:
; add break between nums
mov ah, 02h ; dos interrupt for printing to console
mov dl, ' ' ; prints what is inside of dl
int 21h      

ret

clear_all_registers:

xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx

ret

exit:
mov ah, 4ch
int 21h