[bits 16]

section .bss
section .data
section .rodata
section .text

  ; void load_first_stage(void)

  load_first_stage:
    push bp
    mov bp, sp
    sub sp, 0x10
    
    push dx
    push 0x0002
    push 0x20

    call read

    add sp, 0x06
    
    times 0x1fe - ($ - $$) db 0x00
    dw 0xaa55
    
    call load_second_stage
    
    mov sp, bp
    pop bp
  ret


