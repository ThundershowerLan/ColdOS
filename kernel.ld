ENTRY(_start)

SECTIONS
{
    . = 0x80200000;

    .text : {
        *(.text)
    }

    .data : {
        *(.data)
    }

    .rodata : {
        *(.rodata)
    }

    .bss : {
	_bss_start = .;
        *(.bss)
	_bss_stop = .;
    }
}
