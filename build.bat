@echo off

if exist "bin" (
  del /f /s /q "bin" 1>NUL	
  rmdir /s /q "bin"
)

mkdir "bin"


nasm -f elf64 "src/main.asm" -o "bin/boot.o"
%gcc% "src/kernel/main.c" -ffreestanding -mno-red-zone -m64 -c -o "bin/main.o"
%ld% "bin/boot.o" "bin/main.o" -Ttext 0x7c00 -melf_x86_64 -o "bin/boot"
pushd "bin"
del /f /q "boot.o" "main.o" 1>NUL
objcopy -O binary "boot" "boot"
qemu-system-x86_64 -drive file=boot,format=raw,index=0,media=disk
popd


