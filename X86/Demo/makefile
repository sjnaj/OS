UNAME_S := $(zsh uname -s)
CC=gcc
LD=gcc
CFLAGS=-O1 -S
SFLAGS=-fno-omit-frame-pointer
LDFLAGS=

ifeq ($(UNAME_S), Darwin)
    MEMCHECK=valgrind --tool=memcheck --leak-check=full --track-origins=yes --dsymutil=yes --suppressions=osx_vector.supp
endif

ifeq ($(UNAME_S), Linux)
    MEMCHECK=valgrind --tool=memcheck --leak-check=full --track-origins=yes
endif

FILE=demo
# usage: make FILE=xxx
all:clean $(FILE)_32 $(FILE)_64  $(FILE)_64_intel 


$(FILE)_32_intel:
	$(CC) $(CFLAGS) $(FILE).c -m32 -masm=intel $(SFLAGS) -o $(FILE)_32_intel.s
	
$(FILE)_32:
	$(CC) $(CFLAGS) $(FILE).c -m32 $(SFLAGS) -o $(FILE)_32.s



$(FILE)_64:
	$(CC) $(CFLAGS) $(FILE).c $(SFLAGS) -o $(FILE)_64.s
	
$(FILE)_64_intel:
	$(CC) $(CFLAGS) $(FILE).c -masm=intel $(SFLAGS) -o $(FILE)_64_intel.s

.c.o:
	$(CC) -c  $(CFLAGS) $<

clean:
	-rm -rf core *.o *.s *~ "#"*"#" Makefile.bak $(FILE)  *.dSYM


