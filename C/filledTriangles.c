#include <stdio.h>
#include <stdlib.h>

void filledTriangle(unsigned int s){
  unsigned int i, j;
  for(i = 0; i < s; i++){
    for(j = 0; j <= i; j++){
      printf("*");
    }
    printf("\n");
  }
}

int main(void){
  unsigned int i;
  for(i = 0; i<5; i++){
    filledTriangle(i);
    printf("\n\n");
  }
  return 0;
}
