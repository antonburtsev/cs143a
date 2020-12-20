#include <stdio.h>

int foo(int a) {
	a++;
	return a;
}

int main(int ac, char **av)
{
    return foo(1);
}
