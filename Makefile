# DIRECTORIES
SYSROOT_DIR := ./sysroot

# SUB PROJECTS
BOOTLOADER_DIR := ./bootloader
KERNEL_DIR := ./kernel

# TARGET
TARGET := ./os.img

# PROGRAMS
EMULATOR := qemu-system-x86_64 
EMULATOR_FLAGS := -bios OVMF.fd -hdd $(TARGET)
EMULATOR_DEBUG_FLAGS := -S -gdb tcp::1234

DEBUGGER := gdb
DEBUGGER_FLAGS := -s $(SYSROOT_DIR)/kernel.elf -ex "target remote localhost:1234"

# BASE RULES
all: $(TARGET)
	@echo "[ LOS ] Build complete!"

run: all
	@$(EMULATOR) $(EMULATOR_FLAGS)

debug: all
	@$(EMULATOR) $(EMULATOR_FLAGS) $(EMULATOR_DEBUG_FLAGS) &
	@$(DEBUGGER) $(DEBUGGER_FLAGS)
	
clean:
	@rm -rf $(SYSROOT_DIR)
	@rm -f $(TARGET)
	@make -C $(BOOTLOADER_DIR) -s clean
	@make -C $(KERNEL_DIR) -s clean

# TARGET
$(TARGET): $(SYSROOT_DIR) bootloader kernel
	@dd if=/dev/zero of=$(TARGET) bs=1k count=65536 status=none
	@mformat -i $(TARGET) -F ::
	@mcopy -i $(TARGET) -s $(SYSROOT_DIR)/* ::/

# SUB PROJECTS
bootloader:
	@make -C $(BOOTLOADER_DIR) -s install
	
kernel:
	@make -C $(KERNEL_DIR) -s install

# OTHER RULES
$(SYSROOT_DIR):
	@mkdir -p $@/bin

.PHONY: bootloader kernel