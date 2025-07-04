NASM = nasm.exe
CC = C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-gcc
LD = C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-ld
OBJCOPY = C:\Users\OFFICE\Desktop\works\i686-elf-tools-windows\bin\i686-elf-objcopy
PYTHON = python

all: run

# 부트로더는 raw binary로 생성 (elf 아님)
boot.bin: boot.asm
	$(NASM) -f bin boot.asm -o boot.bin
	$(PYTHON) boot.py

kernel.o: kernel.c
	$(CC) -m32 -ffreestanding -fno-pie -fno-stack-protector -c kernel.c -o kernel.o

kernel.elf: kernel.o link.ld
	$(LD) -T link.ld -m elf_i386 -o kernel.elf kernel.o

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

os-image.bin: boot.bin kernel.bin
	copy /b boot.bin + kernel.bin os-image.bin

run: os-image.bin
	qemu-system-x86_64 -fda os-image.bin

clean:
	del /F /Q *.bin *.elf *.o *.img
