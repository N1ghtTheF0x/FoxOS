AS = ./cc/bin/i686-elf-as
CC = ./cc/bin/i686-elf-gcc
CXX = ./cc/bin/i686-elf-g++

WARNINGS = -Wall -Wextra
CFLAGS = -std=gnu99 -ffreestanding -O2 $(WARNINGS)
CXXFLAGS = -ffreestanding -O2 $(WARNINGS) -fno-exceptions -fno-rtti

SOURCE_DIR = ./source
OBJECT_DIR = ./objects
HEADERS = $(shell find ${SOURCE_DIR} -type f -name "*.hpp")
CPP_SOURCES = $(shell find ${SOURCE_DIR} -type f -name "*.cpp")
ASM_SOURCES = $(shell find ${SOURCE_DIR} -type f -name "*.s")
CPP_OBJECTS = $(patsubst $(SOURCE_DIR)/%.cpp,$(OBJECT_DIR)/%.o,$(CPP_SOURCES))
ASM_OBJECTS = $(patsubst $(SOURCE_DIR)/%.s,$(OBJECT_DIR)/%.o,$(ASM_SOURCES))
SOURCES = $(CPP_SOURCES) $(ASM_SOURCES)
OBJECTS = $(CPP_OBJECTS) $(ASM_OBJECTS)
OUTPUT = os.bin

all: $(OUTPUT)

boot:
	$(AS) boot.s -o $(OBJECT_DIR)/boot.o	
kernel:
	$(CXX) -c source/kernel.cpp -o objects/kernel.o $(CXXFLAGS)
link: 
	$(CC) -T linker.ld -o os.bin -ffreestanding -O2 -nostdlib objects/boot.o objects/kernel.o -lgcc
test-direct:
	qemu-system-i386 -kernel os.bin
output:
	@echo $(OBJECTS)
# New
$(CPP_OBJECTS): $(CPP_SOURCES)
	@mkdir -p $(@D)
	$(CXX) -c $< -o $@ $(CXXFLAGS)
$(ASM_OBJECTS): $(ASM_SOURCES)
	@mkdir -p $(@D)
	$(AS) $< -o $@
clean:
	@rm -rf $(OBJECT_DIR) *.o
	@rm -f $(OUTPUT)
$(OUTPUT): $(OBJECTS)
	$(CC) -T linker.ld -o $@ -ffreestanding -O2 -nostdlib $(OBJECTS) -lgcc
test: $(OUTPUT)
	qemu-system-i386 -kernel $<

.PHONY: all clean