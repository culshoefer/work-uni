#include <stdio.h>

unsigned int count(char * str, char needle){
  int i;
  unsigned int count = 0;
  for(i = 0; *(str + i); i++){
    if(*(str+i) == needle)
      count++;
  }
  return count;
}


int main(void){
  printf("%u\n", count("someathingaaaaa", 'a'));
  return 0;

}
