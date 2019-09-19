OBJECTS = loader.o kernel.o io.o framebuffer.o string.o serial.o output.o gdt.o interrupts.o idt.o interrupt_handler.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
		-nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c -Wno-unused-variable -Wno-unused-parameter
LDFLAGS = -m elf_i386 -T link.ld 
AS = nasm
ASFLAGS = -f elf

all: kernel.elf

kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) -o kernel.elf $(OBJECTS)

os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R                              \
		    -b boot/grub/stage2_eltorito    \
		    -no-emul-boot                   \
		    -boot-load-size 4               \
		    -A os                           \
		    -input-charset utf8             \
		    -quiet                          \
		    -boot-info-table                \
		    -o os.iso                       \
		    iso

run: os.iso	
	bochs -f bochsrc.txt -q




%.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf os.iso
