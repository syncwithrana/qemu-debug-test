CC           = arm-none-eabi-gcc
GDB          = arm-none-eabi-gdb
QEMU         = qemu-system-arm
QEMU_MACH    = mps2-an385
LED_ADDR     = 0x40028000

BUILD_DIR    = build
TARGET       = $(BUILD_DIR)/rtos.elf

CFLAGS       = -mcpu=cortex-m3 -mthumb -ffreestanding -O0 -g -Wall -I. -Isrc
LDFLAGS      = -T linker.ld -nostartfiles -nostdlib
SRC_FILES    = $(shell find src -type f -name '*.c' 2>/dev/null)
SRCS         = startup.c main.c $(SRC_FILES)
OBJS         = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRCS))
DEPS         = $(OBJS:.o=.d)

all: $(TARGET)

$(TARGET): $(OBJS) linker.ld
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $@

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

-include $(DEPS)

run: $(TARGET)
	$(QEMU) -M $(QEMU_MACH) -nographic -kernel $(TARGET)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all run clean