CC           = arm-none-eabi-gcc
GDB          = arm-none-eabi-gdb
QEMU         = qemu-system-arm
QEMU_MACH    = mps2-an385
LED_ADDR     = 0x40028000

BUILD_DIR    = build
TARGET       = $(BUILD_DIR)/rtos.elf

CFLAGS       = -mcpu=cortex-m3 -mthumb -ffreestanding -O0 -g -Wall -I.
LDFLAGS      = -T linker.ld -nostartfiles -nostdlib
SRCS         = startup.c main.c

all: $(TARGET)

$(TARGET): $(SRCS) linker.ld
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRCS) -o $(TARGET)

run: $(TARGET)
	$(QEMU) -M $(QEMU_MACH) -nographic -kernel $(TARGET)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all run clean