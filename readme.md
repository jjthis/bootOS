

C:\Users\OFFICE\AppData\Local\bin\NASM\nasm.exe -f bin boot.asm -o boot.img

C:\msys64\mingw64\bin\qemu-system-i386 -fda boot.img  



; boot loader print h
;[org 0x7C00]                            ;load 0x7C00 memory because of nasm

;mov ah, 0x0E                            ;teletype print mode
;mov al, 'H'                             ;print h
;int 0x10                                ;print

;jmp $                                   ;infinite loof

;times 510 - ($ - $$) db 0               ;510 - current file byte
;dw 0xAA55                               ;boot signature
