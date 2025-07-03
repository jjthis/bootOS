all: os-image

os-image: boot.o kernel.o
	C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-ld -T link.ld -o kernel.elf kernel.o
	C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-objcopy -O binary kernel.elf kernel.bin
	copy /b boot.bin + kernel.bin os-image.bin

boot.o: boot.asm
	C:\msys64\usr\bin\nasm.exe -f bin boot.asm -o boot.bin

kernel.o: kernel.c
	C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-gcc -m32 -ffreestanding -c kernel.c -o kernel.o

run: os-image
	C:\msys64\mingw64\bin\qemu-system-i386 -fda os-image.bin

clean:
	rm -f *.o *.bin *.elf