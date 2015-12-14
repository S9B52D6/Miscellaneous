#include <stdio.h>
int main(int argc, char** argv)
{
    if(argc <= 1)
    {
        FILE* fp = fopen("/sys/class/backlight/intel_backlight/brightness", "r");
        int val = 0;
        fscanf(fp, "%d", &val);
        printf("%d\n", val);
        fclose(fp);
    }
    else
    {
        FILE* fp = fopen("/sys/class/backlight/intel_backlight/brightness", "w+");
        fprintf(fp, "%s", argv[1]);
        fclose(fp);
    }
    return 0;
}
