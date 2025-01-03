org 100h

;.model small  ; define the memory model
;.stack 100h   ; definde the size of the stack (256 bytes)


;code_segment:
;mov ax, data_segment
;mov ds, ax         ; Set DS to point to the data segment
;mov si, 0          ; Initialize source index
;mov al, myArray[si]; Load the first element into AL (10h)
;inc si             ; Increment SI to point to the next element
;mov al, myArray[si]; Load the second element (20h)

                    
;defining and creating an array in memory or anything, it can be don eeach value in 1byte (DB) AKA DEFINE BYTE 
;or 2bytes (DW) AKA DEFINE WORD , EQU AKA EQUATE, assigns a constant value to a name var

;.data  ; define the data segment




my_array db 0x12h, 0xAAh, 0x13h, 0xABh, 0x14h, 0xACh, 0x15h, 0xADh, 0x16h, 0xAFh 
sum dw 0

;;;;.code  ; mark the begining of the code where instructions are written
; setup SI and loop
mov si, 0  ; the starting index is 0
; now we can start playing with the elements
mov cl, 5 ; len / 2
; we will store the sum in dx
xor dx, dx
xor ax, ax


; run loop

sum_loop:
mov al, [my_array + si]
add dx, ax
and dx, 0x00ffh
inc si
inc si
loop sum_loop
mov sum, dx

mov ah, 4Ch      ; DOS interrupt for termination
int 21h          ; Terminate program


