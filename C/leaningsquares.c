#include <stdio.h>

void leaningSquare(int n, char border, char fill){
  int i, j;
  if (n < 2)
    return;
  for (i = 0; i < n; i++){
    if (i == 0){
      for (j = 0; j < n; j++){
	printf("%c", border);
      }
      printf("\n");
    }
    for (j = 0; j <= i; j++){
      printf(" ");
    }
    if (i == n - 1) {
      for (j = 0; j < n; j++) {
	printf("%c", border);
      }
      printf("\n");
    } else {
      printf("%c", border);
      for (j = 1; j < n-1; j++){
	printf("%c", fill);
      }
      printf("%c", border);
      printf("\n");
    }
  }
}

int main(void){
  leaningSquare(4, '*', '-');
  leaningSquare(6, '$', '^');
  return 0;
}
