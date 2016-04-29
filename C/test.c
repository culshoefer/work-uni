#include <stdio.h>
#include <stdlib.h>

int main(void){
  char * test = "test";
  int i;
  for(i=0; *(test+i); i++){
    printf("%c\n", *(test+i));
  }
  return 0;

}
