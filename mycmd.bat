@echo off
set PATH="C:\Program Files\qemu";C:\nasm-3.01;%PATH%

echo qemu-system-x86_64.exe boot.bin
echo nasm -f bin boot.asm -o boot.bin

cmd
