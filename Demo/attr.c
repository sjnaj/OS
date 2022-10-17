#include<stdio.h>
__attribute((constructor))void hello(){
    printf("Hello\n");
}
__attribute((destructor))void goodbye(){
    printf("GoodBye\n");
}

int main(){
    
}