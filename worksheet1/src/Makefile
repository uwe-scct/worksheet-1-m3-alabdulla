AS = nasm
CC = gcc
CFLAGS = -m32 -g -Wall
ASFLAGS = -f elf -d ELF_TYPE

all: driver_cli

driver_cli: driver_cli.o asm_io.o task1.o task1.2.o task2_name.o task2_array.o task2_range.o
	$(CC) -m32 -no-pie -o driver_cli $^

driver_cli.o: driver_cli.c
	$(CC) $(CFLAGS) -c driver_cli.c -o driver_cli.o

asm_io.o: asm_io.asm asm_io.inc
	$(AS) $(ASFLAGS) asm_io.asm -o asm_io.o

%.o: %.asm asm_io.inc
	$(AS) $(ASFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o driver_cli task1 task1.2 task2_name task2_array task2_range
