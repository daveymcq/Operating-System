[bits 16]

segment .bss
segment .data
segment .text

; void boot_operating_system(void)
  
boot_operating_system:
  push bp
  mov sp, 0x7c00
  mov bp, sp
  sub sp, 0x00
  
  call load_first_stage
  
  mov sp, bp
  pop bp
ret

;;;;; includes ;;;;;;

%include "src/bootloader/includes/ASM/bios_interrupts.asm"
%include "src/bootloader/includes/ASM/boot_stages.asm"