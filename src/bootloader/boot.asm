[bits 16]

section .bss
section .data
section .rodata
section .text

  ; void boot_operating_system(void)
    
  boot_operating_system:
    push bp
    mov bp, sp
    sub sp, 0x10

    call load_first_stage
    
    mov sp, bp
    pop bp
  ret


;;;;; includes ;;;;;;

%include "src/bootloader/functions/asm/bios_interrupts/10h/print.asm"
%include "src/bootloader/functions/asm/bios_interrupts/13h/read.asm"

%include "src/bootloader/functions/asm/CPUID.asm"

%include "src/bootloader/stages/stage_1/boot.asm"
%include "src/bootloader/stages/stage_2/boot.asm"
%include "src/bootloader/stages/stage_3/boot.asm"
%include "src/bootloader/stages/gdt.asm"