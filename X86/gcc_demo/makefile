UNAME_S := $(shell uname -s)
CC=gcc
LD=gcc
CFLAGS=-O2 -g 
#-fno-omit-frame-pointer :Omit the frame pointer in functions that don’t need one

#详细信息：https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

# -fno-asynchronous-unwind-tables避免.cfi指令（调用栈信息），
#加上 -fno-exceptions（取消异常处理）确保省略-g(添加调试信息)
#详细信息：https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html
SFLAGS=-O2  -S  -fno-omit-frame-pointer  -fno-asynchronous-unwind-tables -fno-exceptions
LDFLAGS=

ifeq ($(UNAME_S), Darwin)
    MEMCHECK=valgrind --tool=memcheck --leak-check=full --track-origins=yes --dsymutil=yes --suppressions=osx_vector.supp
endif
ifeq ($(UNAME_S), Linux)
    MEMCHECK=valgrind --tool=memcheck --leak-check=full --track-origins=yes
endif
# $(info $(UNAME_S))

FILE=hello
# usage: make FILE=xxx
all: $(FILE)_32 $(FILE)_64  $(FILE)_64_intel


$(FILE)_32_intel:
	$(CC) $(SFLAGS) -mpreferred-stack-boundary=2 -fno-pic $(FILE).c -m32 -masm=intel  -o $(FILE)_32_intel.s
#-fno-pic
# Generate position-independent code (PIC) suitable for use in a shared library, if supported for the target machine. 
# Such code accesses all constant addresses through a global offset table (GOT). The dynamic loader resolves the GOT entries when the program starts (the dynamic loader is not part of GCC;
# it is part of the operating system). If the GOT size for the linked executable exceeds a machine-specific maximum size, you get an error message from the linker indicating that -fpic does not work; 
# in that case, recompile with -fPIC instead. 
$(FILE)_32:
	$(CC) $(SFLAGS) -mpreferred-stack-boundary=2 -fno-pic  $(FILE).c -m32  -o $(FILE)_32.s
$(FILE)_32_r:
	$(CC) -c -g $(FILE)_32.s -m32  -o $(FILE)_32.o
	$(CC) -m32 $(FILE)_32.o -o $(FILE)_32
$(FILE)_64:
	$(CC) $(SFLAGS) $(FILE).c  -o $(FILE).s
$(FILE)_64_r:
	$(CC) -c -g $(FILE).s   -o $(FILE).o
	$(CC) $(FILE).o -o $(FILE)
$(FILE)_64_intel:
	$(CC) $(SFLAGS) $(FILE).c -masm=intel  -o $(FILE)_intel.s


$(FILE)_check:
	$(MEMCHECK) ./$(FILE)
$(FILE)_check_32:
	$(MEMCHECK) ./$(FILE)_32

.c.o:
	$(CC) -c  $(CFLAGS) $<

clean:
	-rm -rf core *.o *.s *~ "#"*"#" Makefile.bak  $(FILE) $(FILE)_32   *.dSYM


