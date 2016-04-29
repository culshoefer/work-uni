#include <stdio.h>
#include <stdlib.h>

void printInts(int a[], int length){
  if(length){
    printf("%d, ", *a);
    printInts(++a, --length);
  } else {
    printf("\n");
  }
}

int main(void){
  int a[] = {5, 3, 6, 1};
  printInts(a, 4);
}
