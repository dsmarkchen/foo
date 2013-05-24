CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/prime
BUILD_DIR=../../build
CPP_PRIME = $(BUILD_DIR)/prime
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_PRIME = $(BUILD_DIR)/prime.o 

$(BUILD_DIR)/prime.o: $(SRC_DIR)/prime.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_PRIME)

pre_compile: $(SRC_DIR)/prime.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex prime.tex
	cp prime.c prime.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_PRIME) : $(OBJS_CPP_PRIME) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_PRIME)"        "$(OBJS_CPP_PRIME)
	$(LD) -o $(CPP_PRIME) $(OBJS_CPP_PRIME) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_PRIME) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/prime.cpp  \
              $(SRC_DIR)/prime.pdf  \
              $(SRC_DIR)/prime.tex  \
              $(SRC_DIR)/prime.log \
              $(SRC_DIR)/prime.idx  \
              $(SRC_DIR)/prime.scn  \
              $(SRC_DIR)/prime.toc  \
              $(SRC_DIR)/prime.c


