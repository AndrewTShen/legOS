PREFIX ?= riscv64-unknown-elf-
DEBUG ?= 1

QEMU := qemu-system-riscv64
# Use second QEMU for debugging purposes, rebuild in the qemu/build directory
# edit in the qemu/target/riscv directory
# QEMU := $(HOME)/Documents/primes2019/qemu/build/riscv64-softmmu/qemu-system-riscv64
QEMUFLAGS := -M virt -nographic -bios none

CC := $(PREFIX)gcc
GDB := $(PREFIX)gdb
OBJDUMP := $(PREFIX)objdump
OBJCOPY := $(PREFIX)objcopy
OBJDUMPFLAGS := --disassemble-all --source --section-headers --demangle

CFLAGS := -ffreestanding -nostdlib -O0 -mcmodel=medany
ifeq ($(DEBUG),1)
	CFLAGS += -g
endif

V = 0
ACTUAL_CC := $(CC)

CC_0 = @printf ' |%-10s| $@ \n' 'CC'; $(ACTUAL_CC)
CC_1 = $(ACTUAL_CC)
CC = $(CC_$(V))

ACTUAL_OBJDUMP := $(OBJDUMP)
OBJDUMP_0 = @printf ' |%-10s| $@ \n' 'OBJDUMP'; $(ACTUAL_OBJDUMP)
OBJDUMP_1 = $(ACTUAL_OBJDUMP)
OBJDUMP = $(OBJDUMP_$(V))

ACTUAL_OBJCOPY := $(OBJCOPY)
OBJCOPY_0 = @printf ' |%-10s| $@ \n' 'OBJCOPY'; $(ACTUAL_OBJCOPY)
OBJCOPY_1 = $(ACTUAL_OBJCOPY)
OBJCOPY = $(OBJCOPY_$(V))

KERNEL_OBJS := \
	startup.o \
	traphandler.o \
	kernelvec.o \
	kernel.o \
	UART.o \
	math.o \
	string.o \
	scanf.o \
	printf.o \
	user.bin.o \

USER_OBJS := \
	printf.o \
	string.o \
	math.o \
	UART.o \
	user.o \
	trampoline.o \

.PHONY: all
all: kernel.elf kernel.lst user.elf

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

kernel.elf: $(KERNEL_OBJS) kernel.ld
	$(CC) $(CFLAGS) -T kernel.ld $(KERNEL_OBJS) -o $@

user.elf: $(USER_OBJS) user.ld
	$(CC) $(CFLAGS) -T user.ld $(USER_OBJS) -o $@

%.bin.o: %.bin
	$(OBJCOPY) -I binary -B riscv -O elf64-littleriscv --rename-section .data=.rodata,contents,alloc,load,readonly,data $< $@ 

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.lst: %.elf
	$(OBJDUMP) $(OBJDUMPFLAGS) $< > $@

.PHONY: clean
clean:
	rm -f *.o *.lst *.elf

.PHONY: qemu
qemu: kernel.elf
	$(QEMU) $(QEMUFLAGS) -kernel kernel.elf

.PHONY: qemu-gdb
qemu-gdb: kernel.elf
	$(QEMU) $(QEMUFLAGS) -S -s -kernel kernel.elf

.PHONY: gdb
gdb: kernel.elf
	$(GDB) --data-directory=/usr/local/share/gdb kernel.elf
