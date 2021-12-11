[bits 32]

section .bss
section .data
section .rodata
section .text

  ; void Detect64BitCPU(void)

  global Detect64BitCPU

  Detect64BitCPU:
    push ebp
    mov ebp, esp
    sub esp, 0x10
    pushfd
    pop eax
    mov ecx, eax
    xor eax, 1 << 21
    push eax
    popfd
    pushfd
    pop eax
    push ecx
    popfd
    cmp eax, ecx
    je CPUNotSupported
   
    mov eax, 0x80000000    
    cpuid                 
    cmp eax, 0x80000001    
    jb CPUNotSupported       
    
    mov eax, 0x80000001   
    cpuid                  
    test edx, 1 << 29      
    jz CPUNotSupported 
    mov eax, 1
    jmp CPUSupported

    CPUNotSupported:
    xor eax, eax

    CPUSupported:
    mov esp, ebp
    pop ebp

  ret
