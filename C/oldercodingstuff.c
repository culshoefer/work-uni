#include <stdio.h>

void block(int height, char upperleft, char bottomright){
  int i, j;
  if(height < 2)
    return;
  for(i = 0; i <= height; i++){
    for(j = i; j < height; j++){
      printf("%c", upperleft);
    }
    for(j = 1; j <= i; j++){
      printf("%c", bottomright);
    }
    printf("\n");
  }
}

void leaningSquare(int height, char border, char fill){
  if(height < 2)
    return;
  int i, j;
  for(i = 0; i < height; i++){
    printf("%c", border);
  }
  printf("\n");
  for(i = 1; i < height; i++){
    for(j = 0; j < i; j++){
      printf(" ");
    }
    printf("%c", border);
    for(j = 2; j < height; j++){
      printf("%c", fill);
    }
    printf("%c", border);
    printf("\n");
  }
}

void filledTriangle(int height, char border, char fill){
  if(height < 3)
    return;
  int row, col;
  printf("%c", border);
  printf("\n");
  for(row = 1; row < height-1; row++){
    printf("%c", border);
    for(col = 1; col < row; col++){
      printf("%c", fill);
    }
    printf("%c", border);
    printf("\n");
  }
  for(col = 0; col < height; col++)
    printf("%c", border);
  printf("\n");
}

void filledSquare(int height, int border, int fill){
  if(height < 3)
    return;
  int row, col;
  for(col = 0; col < height; col++){
    printf("%c", border);
  }
  printf("\n");
  for(row = 1; row < height - 1; row++){
    printf("%c", border);
    for(col = 1; col < height - 1; col++){
      printf("%c", fill);
    }
    printf("%c", border);
    printf("\n");
  }
  for(col = 0; col < height; col++){
    printf("%c", border);
  }
  printf("\n");
}

int main(void){
  block(5, '*', '+');
  printf("\n");
  block(6, '-', '%');
  printf("\n");
  block(2, '$', '#');
  printf("\n");
  block(1, '$', '#');
  printf("\n");
  leaningSquare(4, '*', '-');
  printf("\n");
  leaningSquare(6, '$', '^');
  printf("\n");
  leaningSquare(2, '%', '#');
  printf("\n");
  leaningSquare(1, 'a', 'b');
  printf("\n");
  filledTriangle(4, '*', '-');
  printf("\n");
  filledTriangle(6, '$', '^');
  printf("\n");
  filledTriangle(3, '#', '~');
  printf("\n");
  filledTriangle(2, 'a', 'b');
  printf("\n");
  filledSquare(4, '*', '-');
  printf("\n");
  filledSquare(6, '$', '^');
  printf("\n");
  filledSquare(3, '#', '~');
  printf("\n");
  filledSquare(2, 'a', 'b');
  printf("\n");
}
