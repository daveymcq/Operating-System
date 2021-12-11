[bits 16]

section .bss
section .data
section .rodata
section .text

  ; void load_second_stage(void)
    
  load_second_stage:
    push bp
    mov bp, sp
    sub sp, 0x10
    
    in al, 0x92
    or al, 0x02
    out 0x92, al
    
    cli
    lgdt [GDT]
    
    mov eax, cr0
    or eax, 0x01
    mov cr0, eax
    
    jmp CODE_SEGMENT:stage_three
    
    stage_three:
    
    [bits 32]
    
    mov ax, DATA_SEGMENT
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    call load_third_stage

    [bits 16]

    mov sp, bp
    pop bp
  ret