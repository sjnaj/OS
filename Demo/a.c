extern int g;
void foo(int x){
    g++;
    asm volatile("nop": : "r"(x):"memory");
    __sync_synchronize();
    g++;
}
