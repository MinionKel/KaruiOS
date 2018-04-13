[org 0x7c00]

	mov bp, 0x9000	; set the stack
	mov sp, bp

	mov bx, MSG_REAL_MODE	; print message in real mode
	call print_string

	call switch_to_pm		; switch to protected mode

	jmp $ ; will never come to here

%include "print_string.asm"
%include "print_string_pm.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"

[bits 32]

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm

	jmp $

MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0

times 510-($-$$) db 0
dw 0xaa55

