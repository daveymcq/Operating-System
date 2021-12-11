[bits 16]

section .bss
section .data
section .rodata
section .text

  bytes_read: dw 0x0000
  error_message: db 'A disk read error has occurred. BYTES READ = ', 0x00

  ; int16 read(int16 drive, int16 starting_sector, int16 sectors_to_read)

  read:
    push bp
    mov bp, sp
    sub sp, 0x10
    pusha
    
    mov ah, 0x02
    lea bx, [0x7c00 + 0x200]
    mov al, [bp + 0x04]
    mov cl, [bp + 0x06]
    mov dl, [bp + 0x08]
    xor ch, ch
    xor dh, dh
    
    int 0x13
    
    jnc read_exit

    push error_message
    push PRINT_STRING

    call print

    add sp, 0x04
    mov [bytes_read], al

    push bytes_read
    push PRINT_HEX

    call print

    add sp, 0x04
    
    read_exit:

    popa
    mov ax, [bytes_read]
    mov sp, bp
    pop bp
  ret