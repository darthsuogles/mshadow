# set LD_LIBRARY_PATH
export CC = gcc
export CXX = g++
export NVCC = nvcc
include config.mk
include ../make/mshadow.mk

BLAS_ROOT = $(shell brew --prefix openblas)
INC_FLAGS = -I../ -I$(BLAS_ROOT)/include
LIB_FLAGS = -L$(BLAS_ROOT)/lib

export CFLAGS = -std=c++14 -Wall -O3 $(INC_FLAGS) $(MSHADOW_CFLAGS)
export LDFLAGS= -lm $(LIB_FLAGS) $(MSHADOW_LDFLAGS)
export NVCCFLAGS = -O3 --use_fast_math -ccbin $(CXX) $(MSHADOW_NVCCFLAGS)

# specify tensor path
BIN = basic defop
OBJ =
CUOBJ =
CUBIN =
.PHONY: clean all

all: $(BIN) $(OBJ) $(CUBIN) $(CUOBJ)

basic: basic.cpp
defop: defop.cpp
basic_stream: basic_stream.cu

$(BIN) :
	$(CXX) $(CFLAGS) -o $@ $(filter %.cpp %.o %.c, $^)  $(LDFLAGS)

$(OBJ) :
	$(CXX) -c $(CFLAGS) -o $@ $(firstword $(filter %.cpp %.c, $^) )

$(CUOBJ) :
	$(NVCC) -c -o $@ $(NVCCFLAGS) -Xcompiler "$(CFLAGS)" $(filter %.cu, $^)

$(CUBIN) :
	$(NVCC) -o $@ $(NVCCFLAGS) -Xcompiler "$(CFLAGS)" -Xlinker "$(LDFLAGS)" $(filter %.cu %.cpp %.o, $^)

clean:
	$(RM) $(OBJ) $(BIN) $(CUBIN) $(CUOBJ) *~
