int rfact(int x)
{
    int res;
    if (x <= 1)
    {
        return 1;
    }
    else
    {
        res= rfact(x - 1);
    }
    return res*x;
}