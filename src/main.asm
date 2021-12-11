[bits 16]

section .bss
section .data
section .rodata
section .text 

  mov sp, 0x7c00

  push bp
  mov bp, sp
  sub sp, 0x10
   
  call boot_operating_system
  
  mov sp, bp
  pop bp


;;;;; includes ;;;;;;

%include "src/bootloader/boot.asm"
