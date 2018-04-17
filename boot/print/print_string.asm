print_string:
	pusha
print_string_body:
	mov al, [bx]	; assume string in stored in [bx]
	cmp al, 0		; string is 0-ended
	je done
	mov ah, 0x0e	; BIOS teletype output function
	int 0x10		; real mode interrupt handler
	add bx, 1		; increament bx
	jmp print_string_body
done:
	popa
	ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa
    ret
