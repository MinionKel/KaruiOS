; A boot sector that boots a C kernel in 32-bit protected mdoe
[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ; kernel load address

	mov [BOOT_DRIVE], dl

	mov bp, 0x9000	; set the stack
	mov sp, bp

	mov bx, MSG_REAL_MODE	; print message in real mode
	call print_string
	call print_nl

	call load_kernel		; load the kernel

	call switch_to_pm		; switch to protected mode

	jmp $ ; will never come to here

%include "print/print_string.asm"
%include "disk/disk_load.asm"
%include "pm/print_string_pm.asm"
%include "pm/gdt.asm"
%include "pm/switch_to_pm.asm"

[bits 16]

load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print_string
	call print_nl

	mov bx, KERNEL_OFFSET
	mov dh, 16				; load 16 sectors
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

[bits 32]

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	call KERNEL_OFFSET
	jmp $

; global variables
BOOT_DRIVE		db 0
MSG_REAL_MODE	db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE	db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL	db "Loading kernel into memory.", 0

times 510-($-$$) db 0
dw 0xaa55

