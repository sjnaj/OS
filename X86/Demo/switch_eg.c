void switch_eg(long x, long n, long *dest)
{
    long val = x;
    switch (n)
    {
    case 100:
        val *= 3;
        break;
    case 102:
        val += 10;
    case 103:
        val += 11;
    case 104:
    case 106:
        val *= val;
        break;
    default:
        val = 0;
    }

    switch (n)
    {
    case 100:
        /* code */
        val++;
        break;
    case 500:
        val--;
        break;
    case 1000:
        val++;
    case 2000:
    case 3000:
        val++;
        break;
    default:
        break;
    }

    *dest = val;
}