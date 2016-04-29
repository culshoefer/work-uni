#include <stdio.h>
#include <stdlib.h>

double * copy(double * array, int size){
  double * cp = malloc(sizeof(double) * size);
  int i;
  for(i = 0; i < size; i++){
    *(cp+i) = *(array++);
  }
  return cp;
}

int main(void){
  double * a = malloc(sizeof(double) * 5);
  int j;
  for(j = 0; j < 5; j++){
    *(a+j) = (double)(j+1);
  }
  double * newDouble = copy(a, 5);
  int i;
  for(i = 0; i < 5; i++){
    printf("%f\n", *(newDouble+i));
  }
  return 0;


}
