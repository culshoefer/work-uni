#include <stdio.h>
#include <stdlib.h>

int * greater(int n[], int length, int value){
  int * maxLengthAr = malloc(sizeof(int));
  int i, realLength = 0;
  
  for(i = 0; i < length; i++){
    if(*(n+i) > value){
      maxLengthAr = realloc(maxLengthAr, ++realLength);
      *(maxLengthAr+realLength-1) = *(n+i);
    }
  }
  printf("%d\n", realLength);
  return maxLengthAr;
}

int main(void){
  int * vals = malloc(sizeof(int) * 5);
  vals[0] = 1;
  vals[1] = 3;
  vals[2] = 6;
  int i;
  int * ret = greater(vals, 5, 2);
  for(i = 0; i < 4; i++){
    printf("%d is greater than 2\n", ret[i]);
  }
  return 0;
}
