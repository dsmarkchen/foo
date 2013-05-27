CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../prime
BUILD_DIR=../prime
CC_PRIME = $(BUILD_DIR)/prime
CPP_LIBS = -lpthread 


OBJS_CC_PRIME = $(BUILD_DIR)/prime.o $(BUILD_DIR)/prime_tests.o 


$(BUILD_DIR)/prime.o: $(SRC_DIR)/prime.c
	@echo "Compiling "$@
	@echo "    CC       "$<
	$(CC) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '
$(BUILD_DIR)/prime_tests.o: $(SRC_DIR)/prime_tests.c
	@echo "Compiling "$@
	@echo "    CC       "$<
	$(CC) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CC_PRIME)

pre_compile: $(SRC_DIR)/prime.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex prime.tex
	@echo 'Finished weaving: $<'
	@echo ' '


$(CC_PRIME) : $(OBJS_CC_PRIME) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CC_PRIME)"        "$(OBJS_CC_PRIME)
	$(LD) -o $(CC_PRIME) $(OBJS_CC_PRIME) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CC_PRIME) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/prime.pdf  \
             $(SRC_DIR)/prime.exe \
			 $(SRC_DIR)/prime.tex  \
             $(SRC_DIR)/prime.log \
             $(SRC_DIR)/prime.idx  \
             $(SRC_DIR)/prime.scn  \
             $(SRC_DIR)/prime.toc  \
             $(SRC_DIR)/prime_tests.c \
             $(SRC_DIR)/prime.c


