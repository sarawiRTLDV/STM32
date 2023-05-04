ENTRY(Reset_Handler)


MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS
{
    .text : 				/* Define output file TEXT section */
    {
        *(.isr_vector) 			/* Vector table */
        *(.text)      			/* Program code *
	. = ALIGN(4);                   /* Make sure data that follows are aligned to 4 byte boundary */
	_etext = .;
	*(.rodata)		/* Read only, section set asside for constants */
    } >FLASH
	
	
	.data :				/* Define output file DATA section */
	{
		_sdata = .;	/* Get the memory address (VMA) for start of section .data */
		*(.data)		/* Initialized static and global variable values */
		. = ALIGN(4); 
		_edata = .;		/* Get the memory address (VMA) for end of section .data */
	}> SRAM AT> FLASH
	
	_data_load = LOADADDR(.data);	/* Get the load memory address (LMA) for section .data */
	
	
	.bss :				/* Define output file BSS section */
	{
		_sbss = .;		/* Get memory address of start of bss section */
		*(.bss)			/* Uninitialized static and global variables */
		*(COMMON)		/* Uninitialized variables are placed in COMMON section for object files */
		. = ALIGN(4);	
		_ebss = .;		/* Get memory address of end of bss section */
	}>SRAM
	
}  
 
