[org 0x7c00]

segment .bss
segment .data
segment .text 
  global boot_operating_system

call boot_operating_system

;;;;; includes ;;;;;;

%include "src/bootloader/boot.asm"