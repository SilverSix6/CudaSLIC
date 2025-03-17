# Path to CUDA toolkit (adjust if necessary)
CUDA_PATH ?= /usr/local/cuda
NVCC       := $(CUDA_PATH)/bin/nvcc

# Directories
SRC_DIR    := src
INCLUDE_DIR:= include

# Compiler flags
# -O3 for optimization, -std=c++11 for C++11 standard, -I to include headers, -fPIC for position independent code
NVCCFLAGS  := -O3 -std=c++11 -I$(INCLUDE_DIR) -Xcompiler -fPIC

# Sources: all .cu and .cpp files in the src/ directory
SRCS := $(wildcard $(SRC_DIR)/*.cu) $(wildcard $(SRC_DIR)/*.cpp)
# Create object files from source file names (.cu/.cpp -> .o)
OBJS := $(SRCS:.cu=.o)
OBJS := $(OBJS:.cpp=.o)

# Target shared library name
TARGET := libcudaSLIC.so

# Default target
all: $(TARGET)

# Link object files into a shared library
$(TARGET): $(OBJS)
	$(NVCC) $(NVCCFLAGS) -shared -o $@ $^

# Compile CUDA source files (.cu)
$(SRC_DIR)/%.o: $(SRC_DIR)/%.cu
	$(NVCC) $(NVCCFLAGS) -c -o $@ $<

# Compile C++ source files (.cpp)
$(SRC_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(NVCC) $(NVCCFLAGS) -c -o $@ $<

# Clean up build files
clean:
	rm -f $(SRC_DIR)/*.o $(TARGET)

.PHONY: all clean
