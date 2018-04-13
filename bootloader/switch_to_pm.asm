[bits 16]

switch_to_pm:
	cli	; disable interruptes

	lgdt [gdt_descriptor]
	
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax	; set bit in CR0 register

	jmp CODE_SEG:init_pm	; long jump into protected mode

[bits 32]

init_pm:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call BEGIN_PM

