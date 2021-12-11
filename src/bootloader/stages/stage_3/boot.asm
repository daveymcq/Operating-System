[bits 32]

section .bss

  align 0x1000

  PML4:
    resb 0x1000
  PDP:
    resb 0x1000
  PD:
    resb 0x1000
    resb 0x40
  STACK:

section .data
section .rodata
section .text

  [extern _start]

  call Detect64BitCPU
  test eax, eax 
  jnz load_third_stage
  hlt

  ; void load_third_stage(void)
    
  load_third_stage:
    push ebp
    mov ebp, esp
    sub esp, 0x10

    ; Setup paging

    mov eax, PDP
    or eax, 0b11
    mov [PML4], eax

    mov eax, PD
    or eax, 0b11
    mov [PDP], eax

    ; Map pages one to one with system memory

    .map_tables:
      mov eax, 0x200000
      mul ecx
      or eax, 0b10000011
      mov [PD + ecx * 0x8], eax
      inc ecx
      cmp ecx, 0x200 
    jne .map_tables

    mov eax, PML4
    mov cr3, eax

    ; Enable PAE

    mov eax, cr4
    mov ebx, 0x1
    shl ebx, 0x5
    or eax, ebx
    mov cr4, eax

    ; Set long mode bit

    mov ecx, 0xC0000080 
    rdmsr
    mov ebx, 0x1
    shl ebx, 0x8
    mov eax, ebx
    wrmsr

    ; Enable paging

    mov eax, cr0
    mov ebx, 0x1
    shl ebx, 31
    or eax, ebx
    mov cr0, eax

    mov esp, STACK

    [bits 64]

    ; call kernel

    call _start

    [bits 32]
      
    mov esp, ebp
    pop ebp
  ret