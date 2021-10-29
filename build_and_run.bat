@echo off

if exist "bin\boot" (
  del "bin\boot"
  rmdir "bin"
)

mkdir "bin"
nasm -f bin "src\main.asm" -o "bin\boot"
qemu-system-x86_64 -drive file=bin\boot,format=raw,index=0,media=disk
