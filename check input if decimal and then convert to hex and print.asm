
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
call create_number

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