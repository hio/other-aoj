#include <stdio.h>

int cubic(int num)
{
	return num * num * num;
}

int main()
{
	int num;
	if( scanf("%d", &num)!=1 )
	{
		return 1;
	}
	printf("%d\n", cubic(num));
	return 0;
}
