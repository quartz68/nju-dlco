TOPNAME = mux42

VERILATOR = verilator
VERILATOR_CFLAGS += --build --cc -Wall -O3 --trace

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)
INC_PATH = ../src/

# Project source
VSRCS = $(shell find $(abspath ../src) -name "*.v")
CSRCS = $(shell find $(abspath .) -name "*.c" -or -name "*.cpp")

# Rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += -DTOP_NAME="\"V$(TOPNAME)\""
LDFLAGS += -lSDL2 -lSDL2_image

$(shell mkdir -p $(BUILD_DIR))

default: sim

all: sim

sim: $(VSRCS) $(CSRCS)

	@rm -rf $(OBJ_DIR)

	$(VERILATOR) $(VERILATOR_CFLAGS) \
		$(INCFLAGS) \
		-j 0 --Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN)) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS))

	@$(BIN)
	
clean:
	rm -rf $(BUILD_DIR)