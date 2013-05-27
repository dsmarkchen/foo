CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../adventus
BUILD_DIR=../build
CC_ADVENTUS = $(BUILD_DIR)/adventus
CPP_LIBS = -lpthread 
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o


OBJS_CC_ADVENTUS = $(BUILD_DIR)/adventus.o $(BUILD_DIR)/adventus_tests.o 

AFLAGS =-I..
ifeq ($(GCOV),gcov)
AFLAGS += -fprofile-arcs -ftest-coverage
endif


$(BUILD_DIR)/adventus.o: $(SRC_DIR)/adventus.c
	@echo "Compiling "$@
	@echo "    CC       "$<
	$(CC) -x c $(AFLAGS) -I.  -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '
$(BUILD_DIR)/adventus_tests.o: $(SRC_DIR)/adventus_tests.cpp
	@echo "Compiling "$@
	@echo "    CC       "$<
	$(CPP) -x c++ $(AFLAGS) -I. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CC_ADVENTUS)

pre_compile: $(SRC_DIR)/adventus.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	#cweave  $<
	#pdftex adventus.tex
	cp adventus_tests.c adventus_tests.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CC_ADVENTUS) : $(OBJS_CC_ADVENTUS) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CC_ADVENTUS)"        "$(OBJS_CC_ADVENTUS)
ifeq ($(GCOV),gcov)
	$(LD) -o $(CC_ADVENTUS) $(OBJS_CC_ADVENTUS) $(GTEST_OBJS)  $(CPP_LIBS) -lgcov
else
	$(LD) -o $(CC_ADVENTUS) $(OBJS_CC_ADVENTUS) $(GTEST_OBJS) $(CPP_LIBS)
endif



clean:
	$(RM) $(OBJS_CC_ADVENTUS) $(FILES_TEMP)
ifeq ($(GCOV),gcov)
	$(RM) -rf *.gcno *.gcda *.gcov 
endif


FILES_TEMP = $(SRC_DIR)/adventus.pdf  \
             $(SRC_DIR)/adventus.exe \
			 $(SRC_DIR)/adventus.tex  \
             $(SRC_DIR)/adventus.log \
             $(SRC_DIR)/adventus.idx  \
             $(SRC_DIR)/adventus.scn  \
             $(SRC_DIR)/adventus.toc  \
             $(SRC_DIR)/adventus_tests.c \
             $(SRC_DIR)/adventus.c


