org 100h

; Reserve memory directly in code

buffer_1 db 128  ; Space for input string (max 127 characters + null terminator)
length_1 db ?     ; Space to store the length of the input string
prompt db 'Enter a string (max 127 characters): $'
start:
    ; Prompt the user
    mov ah, 09h         ; DOS interrupt: Display string
    lea dx, prompt      ; Load address of prompt message
    int 21h             ; Call DOS interrupt

; reading nr 1
read_1:
    mov ah, 0Ah
    lea dx, buffer_1
    int 21h
; The first byte in buffer is the maximum length
    ; The second byte is the actual length of input (excluding Enter key)
    ; The input string starts from the third byte
    ; mov al, [buffer+1]  ; Load the actual length of input
    ; mov [length], al    ; Store it in the 'length' variable

mov al, [buffer_1 + 1]
mov [length_1], al

; accessing and reading data char by char pos by pos buffer[0] max len buffer[1] actual len, buffer[2] start of input
mov si, 2 ; starting index for actual input
mov cl, [length_1]
print_loop:    
mov ah, 02h ; DOS INT FOR PRINTING
xor dx, dx
mov dl, [buffer_1 + si]  ; move from RAM into REGISTRY
int 21h
inc si       ; increment stack index in our case the array index in memory


loop print_loop