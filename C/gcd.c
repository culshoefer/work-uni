#include <stdio.h>

int gcd(int a, int b){
  if((a < 1) || (b < 1))
    return -1;
  while (a % b) {
    b += a;
    a = b - a;
    b = (b- a) % a;
  }
  return b;
}

int main(void){
  int i, j;
  for(i = 0; i < 100; i++){
    for(j = 0; j < 100; j++){
      printf("(%d, %d)=%d\n", i, j, gcd(i,j));
    }
  }
  return 0;
}
