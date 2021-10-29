segment .bss
segment .data
segment .text

; void load_third_stage(void)
  
load_third_stage:
  push ebp
  mov ebp, esp
  sub esp, 0x0
  
  mov byte [0xb8000], 'X'
  
  mov esp, ebp
  pop ebp
ret