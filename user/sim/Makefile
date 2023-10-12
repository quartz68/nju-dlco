TOPNAME = encode_display
NXDC_FILES = constr/$(TOPNAME).nxdc

VERILATOR = verilator
# VERILATOR_CFLAGS += --build --cc -Wall -O3 --trace
# VERILATOR_CFLAGS += --build --cc -O3 --trace
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert --trace

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)
INC_PATH = ../src

# Project source
VSRCS = $(shell find $(abspath ../src) -name "*.v")
CSRCS = $(shell find $(abspath .) -name "$(TOPNAME)_sim.c" -or -name "$(TOPNAME)_sim.cpp")

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

CSRCS = $(shell find $(abspath .) -name "$(TOPNAME)_nvboard.c" -or -name "$(TOPNAME)_nvboard.cpp")

include $(NVBOARD_HOME)/scripts/nvboard.mk

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

CSRCS += $(SRC_AUTO_BIND)

INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += $(INCFLAGS)

nvboard: $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))
	@$(BIN)
	
clean:
	rm -rf $(BUILD_DIR)