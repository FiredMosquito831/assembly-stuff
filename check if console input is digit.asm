
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
