#include <stdio.h>

void filledSquare(int height, char border, char fill){
  int i, j;
  if(height < 2)
    return;
  for(i = 0; i < height; i++){
    printf("%c", border);
  }
  printf("\n");
  for(i = 1; i < height - 1; i++){
    printf("%c", border);
    for(j = 2; j < height; j++){
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
  filledSquare(4, '+', '*');
  filledSquare(6, '=', 'e');
  filledSquare(2, '$', 'z');
  filledSquare(1, '+', '*');
}
