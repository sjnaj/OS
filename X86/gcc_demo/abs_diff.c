int abs_diff(int a, int b)
{
    int result;
    if (b > a)
    {
        result = b - a;
    }
    else
    {
        result = a - b;
    }
    return result;
}
