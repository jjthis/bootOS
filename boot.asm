[bits 16]
[org 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; BIOS print
    mov si, message
    call print_string

    jmp $

    ; Load kernel (sectors 2~) to 0x1000
    mov bx, 0x1000       ; ES:BX = load address
    mov dh, 1            ; Sectors to read
    mov dl, 0x00         ; Floppy disk
    call read_kernel

    ; Enter Protected Mode
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODE_SEG:start32

print_string:
    mov ah, 0x0E
.print_loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print_loop
.done:
    ret

; BIOS INT 13h disk read (1 sector → ES:BX)
read_kernel:
    mov ah, 0x02        ; function 2: read sector
    mov al, dh          ; # of sectors
    mov ch, 0           ; cylinder
    mov cl, 2           ; sector (start from sector 2)
    mov dh, 0           ; head
    mov dl, 0           ; drive 0
    int 0x13
    jc disk_error
    ret

disk_error:
    mov si, disk_fail
    call print_string
    jmp $

message db "start make os with kernel", 0
disk_fail db "Disk load failed!", 0

; GDT
gdt_start:
    dq 0
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ 0x08
DATA_SEG equ 0x10

[bits 32]
start32:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x90000

    jmp 0x1000  ; jump to kernel_main (entry of kernel.bin)

times 510 - ($ - $$) db 0
dw 0xAA55
