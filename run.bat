C:\mingw\w64devkit\bin\make.exe run

@REM C:\Users\OFFICE\AppData\Local\bin\NASM\nasm -f elf boot.asm -o boot.o


@REM C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-gcc -m32 -ffreestanding -c kernel.c -o kernel.o
@REM C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-ld -m elf_i386 -T link.ld -o os.elf boot.o kernel.o
@REM C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-objcopy -O binary os.elf os-image.bin

@REM @REM C:\msys64\usr\bin\dd if=boot.bin of=os-image.img bs=512 count=1 conv=notrunc
@REM @REM C:\msys64\usr\bin\dd if=kernel.bin of=os-image.img bs=512 seek=1 conv=notrunc


@REM C:\msys64\mingw64\bin\qemu-system-i386 -drive format=raw,file=os-image.bin