extern void _start(void)
{
    unsigned int i;

    for(i = 0; i < 1024; i++)
    {
        unsigned int *screen = ((unsigned int *)0xb8000 + i);
        *screen = (unsigned int)0x99999999;
    }

    while(1);
}

