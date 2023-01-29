# Build
toolchain=aarch64-none-elf
AS=$(toolchain)-as
CC=$(toolchain)-gcc
LD=$(toolchain)-ld
CPU := cortex-a53

GCC_FLAGS := -mcpu=$(CPU) -mstrict-align -ffreestanding -g3 -O3 -Wall  -Wno-unused-function
LD_FLAGS=-nostdlib
LIB_INCLUDE=lib/include

LINKER_FILE=core/linker.ld

BUILD_DIR=build

# Output
IMAGE_NAME=ash

# Files to compile
SRC=\
	core/boot.o \
	core/main.o

SRC+=\
	lib/abort.o \
	lib/itoa.o \
	lib/printf.o \
	lib/string.o


OBJECTS=$(addprefix $(BUILD_DIR)/, $(SRC))

all: image

simulate: image
	qemu-system-aarch64 -machine virt -cpu $(CPU) -kernel $(BUILD_DIR)/$(IMAGE_NAME).bin \
                    	-display none \
                    	-serial stdio

image: build_dir $(OBJECTS)
	$(LD) $(LD_FLAGS) -T $(LINKER_FILE) $(OBJECTS) -o $(BUILD_DIR)/$(IMAGE_NAME).elf
	$(TOOLCHAIN)-objcopy -I elf64-little -O binary $(BUILD_DIR)/$(IMAGE_NAME).elf $(BUILD_DIR)/$(IMAGE_NAME).bin
	@echo "Compilation done!"

# Assembly sources
$(BUILD_DIR)/%.o: %.s
	$(AS) $< -o $@
# C sources
$(BUILD_DIR)/%.o: %.c
	$(CC) $(GCC_FLAGS) -I $(LIB_INCLUDE) -c $< -o $@

build_dir:
	mkdir -p build/core
	mkdir -p build/lib

clean:
	rm -rf build
