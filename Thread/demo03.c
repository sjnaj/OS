#include "thread.h"
// thread-local variables，通过%fs段寄存器来寻址 
__thread char *base, *cur;
__thread int id;


//防止优化，便于查看汇编代码
__attribute__((noinline))  void set_cur(void *ptr) { cur = ptr; }
__attribute__((noinline)) char *get_cur() { return cur; }

void stackoverflow(int n)
{
    set_cur(&n);
    if (n % 1024 == 0)//栈帧增长1024次打印一次，实测每次递归增长8个指令长度(8*8=64bytes)
    {
        int sz = base - get_cur();//字节数，因为类型为char*
        printf("Stack size if T%d >= %dKB\n", id, sz / 1024);
    }
    stackoverflow(n + 1);
}
void Tprobe(int tid)
{
    id = tid;
    base = (void *)&tid;//初始栈帧位置
    stackoverflow(0);
}
int main()
{
    setbuf(stdout, NULL);
    for (int i = 0; i < 4; i++)
    {
        create(Tprobe);
    }
}
