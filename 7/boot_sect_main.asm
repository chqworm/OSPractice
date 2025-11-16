[org 0x7c00]     ; nasm 伪指令，后面的内存地址都以0x0000：7c00处为起始0地址；
mov bp, 0x8000   ; bp是栈基址指针寄存器，不随 push/pop 自动改变set the stack safely away from us
mov sp, bp       ; 栈指针寄存器,指向栈顶,操作 push/pop 时自动改变,栈向下增长,物理栈地址 = SS*16 + SP

mov bx, 0x9000   ; 基址寄存器，可指向数据段内任意地址,es:bx = 0x0000:0x9000 = 0x09000 ES = 段寄存器，BX = 偏移 
				; disk_load 将数据存入该地址 
mov dh, 2 ; read 2 sectors
; the bios sets 'dl' for our boot disk number
; if you have trouble, use the '-fda' flag: 'qemu -fda file.bin'
call disk_load
mov dx, [0x9000] ; retrieve the first loaded word, 0xdada
call print_hex
call print_nl
mov dx, [0x9000 + 512] ; first word from second loaded sector, 0xface
call print_hex
jmp $

%include "../5/boot_sect_print.asm"
%include "../5/boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

; Magic number
times 510 - ($-$$) db 0
dw 0xaa55

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes