#include <stdio.h>
#include <unistd.h>
#define REGS_FOREACH(_) _(X) _(Y)
#define OUTS_FOREACH(_) _(A) _(B) _(C) _(D) _(E) _(F) _(G)
#define RUN_LOGIC                \
    X1 = !X && Y;                \
    Y1 = !X && !Y;               \
    A = (!X && !Y) || (X && !Y); \
    B = 1;                       \
    C = (!X && !Y) || (!X && Y); \
    D = (!X && !Y) || (X && !Y); \
    E = (!X && !Y) || (X && !Y); \
    F = (!X && !Y);              \
    G = (X && !Y);
#define DEFINE(X) static int X, X##1; //##拼接为变量名
#define UPDATE(X) X = X##1;
#define PRINT(X) printf(#X " = %d;", X); //#变为字符类型
int main()
{
    REGS_FOREACH(DEFINE);
    OUTS_FOREACH(DEFINE);
    while (1)
    { // clock
        RUN_LOGIC;
        OUTS_FOREACH(PRINT);
        REGS_FOREACH(UPDATE);
        putchar('\n');
        fflush(stdout);
        sleep(1);
    }
}
