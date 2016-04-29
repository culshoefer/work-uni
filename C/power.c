#include <stdio.h>
#include <stdbool.h>

int power(double a, int b)
{
  double result;
  int i;
  result = 1.0;
  for(i = 1; i <= b; ++i)
    {
      result = result * a;
    }
  return
  result;
}

unsigned int length(char * str){
  unsigned int len = 0;
  while(*(str++))
    len++;
  return len;
}

bool sameStrings(char * a, char * b){
  int i;
  for(i = 0; i < length(a) && *(b); i++){
    if(*(a + i) != *(b + i))
      return false;
  }
  return true;
}

int main(void){
  printf("%d\n", length("test"));
  if(sameStrings("test", "tes"))
    printf("same\n");
  if(sameStrings("test", "test"))
    printf("same2\n");
  return 0;
}
