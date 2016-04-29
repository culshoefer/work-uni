#include <stdio.h>

void filledTriangle (int height, char fill, char border){
  int i, j;
  printf("%c", border);
  printf("\n");
  for(i = 1; i < height-1; i++){
    printf("%c", border);
    for(j = 0; j < i - 1; j++){
      printf("%c", fill);
    }
    printf("%c", border);
    printf("\n");
  }
  for(i = 0; i < height; i++){
    printf("%c", border);
  }
  printf("\n");
}

int main(void){
  filledTriangle(4, '+', '*');
  filledTriangle(6, '-', '@');
  filledTriangle(2, '%', 'p');
  filledTriangle(3, '$', '#');
  filledTriangle(1, 'a', 'p');
  return 0;
}
