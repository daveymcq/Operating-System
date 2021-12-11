[bits 16]

null_descriptor:

	dd 0x0
	dd 0x0
	
code:		
		
	dw 0xffff
	dw 0x0000	
	db 0x00				
	db 0b10011010		
	db 0b11001111	
	db 0x00

data:				

	dw 0xffff
	dw 0x0000			
	db 0x00		
	db 0b10010010		
	db 0b11001111	
	db 0x00
	
GDT:

  dw GDT - null_descriptor - 0x01
  dd null_descriptor

CODE_SEGMENT equ code - null_descriptor
DATA_SEGMENT equ data - null_descriptor