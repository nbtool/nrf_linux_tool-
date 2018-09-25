

#KIND := NO_BLE
KIND := BLE

ifeq ($(KIND),NO_BLE)
	# C flags common to all targets
	CFLAGS += -DNRF51
	CFLAGS += -DNRF51422
	CFLAGS += -DSWI_DISABLE0
	CFLAGS += -DBOARD_PCA10028
	CFLAGS += -DBSP_DEFINES_ONLY
	CFLAGS += -mcpu=cortex-m0
	CFLAGS += -mthumb -mabi=aapcs
	CFLAGS +=  -Wall -Werror -O3 -g3
	CFLAGS += -mfloat-abi=soft
	# keep every function in separate section, this allows linker to discard unused ones
	CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
	CFLAGS += -fno-builtin --short-enums 

	# C++ flags common to all targets
	CXXFLAGS += \

	# Assembler flags common to all targets
	ASMFLAGS += -x assembler-with-cpp
	ASMFLAGS += -DNRF51
	ASMFLAGS += -DNRF51422
	ASMFLAGS += -DSWI_DISABLE0
	ASMFLAGS += -DBOARD_PCA10028
	ASMFLAGS += -DBSP_DEFINES_ONLY

	# Linker flags
	LDFLAGS += -mthumb -mabi=aapcs -L $(TEMPLATE_PATH) -T$(LINKER_SCRIPT)
	LDFLAGS += -mcpu=cortex-m0
	# let linker to dump unused sections
	LDFLAGS += -Wl,--gc-sections
	# use newlib in nano version
	LDFLAGS += --specs=nano.specs -lc -lnosys
endif

ifeq ($(KIND),BLE)
	# C flags common to all targets
	CFLAGS += -DBOARD_PCA10028
	CFLAGS += -DSOFTDEVICE_PRESENT
	CFLAGS += -DSWI_DISABLE0
	CFLAGS += -D__HEAP_SIZE=0
	CFLAGS += -DNRF51
	CFLAGS += -DS130
	CFLAGS += -DBLE_STACK_SUPPORT_REQD
	CFLAGS += -DNRF51422
	CFLAGS += -DNRF_SD_BLE_API_VERSION=2
	CFLAGS += -mcpu=cortex-m0
	CFLAGS += -mthumb -mabi=aapcs
	CFLAGS +=  -Wall -Werror -O3 -g3
	CFLAGS += -mfloat-abi=soft
	# keep every function in separate section, this allows linker to discard unused ones
	CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
	CFLAGS += -fno-builtin --short-enums 

	# C++ flags common to all targets
	CXXFLAGS += \

	# Assembler flags common to all targets
	ASMFLAGS += -x assembler-with-cpp
	ASMFLAGS += -DBOARD_PCA10028
	ASMFLAGS += -DSOFTDEVICE_PRESENT
	ASMFLAGS += -DSWI_DISABLE0
	ASMFLAGS += -D__HEAP_SIZE=0
	ASMFLAGS += -DNRF51
	ASMFLAGS += -DS130
	ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
	ASMFLAGS += -DNRF51422
	ASMFLAGS += -DNRF_SD_BLE_API_VERSION=2

	# Linker flags
	LDFLAGS += -mthumb -mabi=aapcs -L $(TEMPLATE_PATH) -T$(LINKER_SCRIPT)
	LDFLAGS += -mcpu=cortex-m0
	# let linker to dump unused sections
	LDFLAGS += -Wl,--gc-sections
	# use newlib in nano version
	LDFLAGS += --specs=nano.specs -lc -lnosys
endif





# JLINK
NRF_JLINK_PROG = ../../../tool/nRF5x-Command-Line-Tools_9_7_3/nrfjprog/nrfjprog 
