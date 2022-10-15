.type factorial,@function
factorial:
    pushl %ebp
    movl %esp,%ebp
    movl 8(%ebp),%eax
    cmpl $1,%eax

    je end_factorial
    decl %eax
    pushl %eax
    call factorial
    movl 8(%ebp),%ebx
    imul %ebx,%eax

end_factorial:
    leave
    ret