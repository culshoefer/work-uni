#include <stdio.h>
#include <stdlib.h>

int isPrime(int x)
{
  int i;
  if(x == 1)
    return 0;
  for (i = 2; i < x; i++)
  {
    if ((x % i) == 0)
      return 0;
  }
  return 1;
}

int main(void){
  printf("%d\n", isPrime(15));
  printf("%d\n", isPrime(13));
  printf("%d\n", isPrime(1));
  printf("%d\n", isPrime(2));
}
