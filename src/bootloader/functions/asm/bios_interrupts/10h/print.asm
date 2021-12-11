[bits 16]

section .bss
section .data
section .rodata
section .text

  PRINT_STRING equ 0x0000
  PRINT_HEX equ 0x0001

  LOOKUP_TABLE: db '0123456789abcdef'
  RESULT: db '0x0000', 0x00

  ; int16 print(int16 data_format, void *data)

  print:
    push bp
    mov bp, sp
    sub sp, 0x10
    
    cld
    
    push bx
    xor cx, cx
    mov ax, [bp + 0x04]
    
    cmp ax, PRINT_HEX
    je print_hexadecimal
    
    cmp ax, PRINT_STRING
    je print_string
    
    print_string:
      mov ah, 0x0e
      mov bx, [bp + 0x06]
      
      .while_not_zero:
        mov al, [bx]
        test al, al
        je exit_print
        int 0x10
        inc bx
        inc cx
        jmp .while_not_zero
      
      jmp exit_print
      
    print_hexadecimal:
      
      mov bx, [bp + 0x06]
      mov bx, [bx]
      shr bx, 0x0C
      and bx, 0x000f
      mov bl, [bx + LOOKUP_TABLE]
      mov [RESULT + 0x02], bl
      inc cx
      
      mov bx, [bp + 0x06]
      
      mov bx, [bx]
      shr bx, 0x08
      and bx, 0x000f
      mov bl, [bx + LOOKUP_TABLE]
      mov [RESULT + 0x03], bl
      inc cx
      
      mov bx, [bp + 0x06]
      
      mov bx, [bx]
      shr bx, 0x04
      and bx, 0x000f
      mov bl, [bx + LOOKUP_TABLE]
      mov [RESULT + 0x04], bl
      inc cx
      
      mov bx, [bp + 0x06]
      
      mov bx, [bx]
      and bx, 0x000f
      mov bl, [bx + LOOKUP_TABLE]
      mov [RESULT + 0x05], bl
      inc cx
      
      push RESULT
      push PRINT_STRING
      call print
      add sp, 0x04
      
      jmp exit_print
      
    exit_print:
    
    pop bx
    mov ax, cx
    mov sp, bp
    pop bp
  ret





