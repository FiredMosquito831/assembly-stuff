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
                                            ; the hex for 0 - 9 are from 30-39
; add your code here


mov bx, 10    ; all stored in hex
mov dx, 20                                              
add bl, dl
adc bh, dh     ; we store the addition in the bx registry, also we add with carry in case we had an overflowq
;mov dl, 30h   ; base starting for printing in decimal, if the hex overflows we remove 6 and then do +1 on the left nibble, in this case byte
                ; we use the counter registry for the loop counter
check_to_print_lower_byte:
                                        ;and bx, 00ffh    ; we clear the first byte and keep the right most byte
                                        ;mov dx, 0Ah
                                        ;cmp dl, bl      ; we see if dl aka the hex for 30 is 
                                                                                                    ;mov dl, 30h   ; base starting for printing in decimal
;method 1 working we will try using cmp to see if the value in bh or bl exceeds 39 (9), which is 3Ah(;)  
push bx  ; remember the value of bx in the stack
cmp bl, 3Ah    ; if it exceeds 39, if it is 3Ah or more it will flip the below flag, which i think would be a combination of the ZF + CF (zero flag and carry flag)
jb print_func_lower_byte      ;jump if below A
; if it is not below A we continue executing
sub bl, 0Ah ; we remove 10 to normalize now we have to increment somehow what is on the left
inc bh    ; increase the carry of what is on the left
ret

print_func: