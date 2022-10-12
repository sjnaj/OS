UNAME_S := $(shell uname -s)
CC=gcc
LD=gcc
CFLAGS=-O2 -g 
#-fno-omit-frame-pointer :Omit the frame pointer in functions that don’t need one

#详细信息：https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

# -fno-asynchronous-unwind-tables避免.cfi指令（调用栈信息），
#加上 -fno-exceptions（取消异常处理）确保省略-g(添加调试信息)
#详细信息：https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html
SFLAGS=-O1 -S  -fno-omit-frame-pointer -fno-pic  -fno-asynchronous-unwind-tables -fno-exceptions
LDFLAGS=

ifeq ($(UNAME_S), Darwin)
    MEMCHECK=valgrind --tool=memcheck --leak-check=full --track-origins=yes --dsymutil=yes --suppressions=osx_vector.supp
endif
ifeq ($(UNAME_S), Linux)
    MEMCHECK=valgrind --tool=memcheck --leak-check=full --track-origins=yes
endif
# $(info $(UNAME_S))

FILE=demo
# usage: make FILE=xxx
all: $(FILE)_32 $(FILE)_64  $(FILE)_64_intel ${FILE}


$(FILE)_32_intel:
	$(CC) $(SFLAGS) $(FILE).c -m32 -masm=intel  -o $(FILE)_32_intel.s
	
$(FILE)_32:
	$(CC) $(SFLAGS) $(FILE).c -m32  -o $(FILE)_32.s

$(FILE)_64:
	$(CC) $(SFLAGS) $(FILE).c  -o $(FILE)_64.s
	
$(FILE)_64_intel:
	$(CC) $(SFLAGS) $(FILE).c -masm=intel  -o $(FILE)_64_intel.s
hello_check:
	$(MEMCHECK) ./hello


.c.o:
	$(CC) -c  $(CFLAGS) $<

clean:
	-rm -rf core *.o *.s *~ "#"*"#" Makefile.bak  $(FILE)  *.dSYM


