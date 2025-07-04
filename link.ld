ENTRY(kernel_main)

SECTIONS {
    . = 0x400000 + SIZEOF_HEADERS;

	.text 0x8000: {
        *(.text)
    }
    
    .data : {
        *(.data)
    }
    
    .bss : {
        *(.bss)
    }
}