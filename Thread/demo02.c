#include "thread.h"
int x=0;
void Hello(int id)
{
    printf("Thread id is %d\n", id);
    usleep(id * 100000);
    printf("Hello from thread #%c\n","123456789ABCD"[x++]);
}
int main(){
    for(size_t i=0;i<10;i++){
        create(Hello);
    }
}

