TARGET_EXEC = mocha
CC = clang++
UNAME_S = $(shell uname -s)

SRC = $(wildcard src/*.cpp) $(wildcard src/**/*.cpp) $(wildcard src/**/**/*.cpp) $(wildcard src/**/**/**/*.cpp)
OBJ = $(SRC:.cpp=.o)
ASM = $(SRC:.cpp=.S)
BIN = bin

INC_DIR_SRC = -Isrc
INC_DIR_LIB =

DEBUGFLAGS = $(INC_DIR_SRC) $(INC_DIR_LIB) -Wall -g -lX11 -lGL -lpthread -lpng -lstdc++fs -std=c++17
RELEASEFLAGS = $(INC_DIR_SRC) $(INC_DIR_LIB) -O3 -lX11 -lGL -lpthread -lpng -lstdc++fs -std=c++17
ASMFLAGS = $(INC_DIR_SRC) $(INC_DIR_LIBS) -Wall
LDFLAGS = $(LIBS) -lm -lX11 -lGL -lpthread -lpng -lstdc++fs -std=c++17

.PHONY: all libs clean

all: clean dirs libs link

dirs:
	mkdir -p ./$(BIN)

link: $(OBJ)
	@echo 'Building target executable:' $(TARGET_EXEC)
	@echo 'Invoking: clang C++ Linker'
	$(CC) -o $(BIN)/$(TARGET_EXEC) $^ $(LDFLAGS)
	@echo 'Finished building target executable:' $(TARGET_EXEC)
	@echo ' '


asm: cleanassembly $(ASM)

%.o: %.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: clang C++ Compiler'
	$(CC) -std=c++2a -o $@ -c $< $(DEBUGFLAGS)
	@echo 'Finished building: $<'
	@echo ' '

%.S: %.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	@echo 'Building ASM'
	$(CC) -std=c++2a -S -O -o $@ -c $< $(ASMFLAGS)
	@echo 'Finished building: $<'
	@echo ' '

build: dirs link

run:
	@echo 'Running executable: '$(TARGET_EXEC)
	./$(BIN)/$(TARGET_EXEC);
	@echo 'Finished running executable: '$(TARGET_EXEC)
	@echo ' '

clean:
	clear
	rm -rf $(BIN) $(OBJ)

cleanassembly:
	rm -rf $(ASM)

