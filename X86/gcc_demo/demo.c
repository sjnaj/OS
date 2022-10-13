int cread(int *xp)
{
    return xp ? *xp : 0;
}
int fact_while(int x)
{
    int result = 1;
    while (x > 1)
    {
        result *= x;
        x -= 1;
    }
    return result;
}