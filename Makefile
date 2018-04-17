# lists of sources
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel.*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

# default make target
all: os-image

run: all
	qemu-system-i386 os-image

os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

# build the kernel binary
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary -m elf_i386

%.o : %.c ${HEADERS}
	gcc -m32 -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -I './boot/' -o $@

clean:
	rm -rf *.bin *.o os-image
	rm -rf kernel/*.o boot/*.bin drivers/*.o