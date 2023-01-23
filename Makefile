# Build
AS=aarch64-none-elf-as
CC=aarch64-none-elf-gcc
LD=aarch64-none-elf-ld

GCC_FLAGS=-ffreestanding
LD_FLAGS=-nostdlib

LINKER_FILE=src/linker.ld

BUILD_DIR=build

# Output
IMAGE_NAME=ash.elf

# Files to compile
objects = $(addprefix $(BUILD_DIR)/, boot.o main.o)

all: image

simulate: image
	qemu-system-aarch64 -machine virt -cpu cortex-a57 -kernel $(BUILD_DIR)/$(IMAGE_NAME) \
                    	-display none \
                    	-serial stdio

image: build_dir $(objects)
	@echo "Linking object files $^"
	$(LD) $(LD_FLAGS) -T $(LINKER_FILE) $(objects) -o $(BUILD_DIR)/$(IMAGE_NAME)
	@echo "Compilation done!"

$(BUILD_DIR)/%.o: src/%.s
	@echo "Compiling $< to $@"
	$(AS) $< -o $@

$(BUILD_DIR)/%.o: src/%.c
	@echo "Compiling $< to $@"
	$(CC) $(GCC_FLAGS) -c $< -o $@

build_dir:
	mkdir -p build

clean:
	rm -rf build
