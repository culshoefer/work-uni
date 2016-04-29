#include <stdio.h>
#include <stdlib.h>

long long fibonacci(int n){
  long long curr = 1;
  long long n_1 = 1;
  long long n_2 = 0;
  while(n--){
    n_2 = n_1;
    n_1 = curr;
    curr = n_2 + n_1;
  }
  return curr;
}

int main(void){
  int i;
  for(i = 0; i < 30; i++){
    printf("%d: %lld\n", i, fibonacci(i));
  }
  return 0;
}
