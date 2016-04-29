#include <stdio.h>
#include <stdlib.h>

struct Node {
  int val;
  char * characterArray;
  struct Node * next;
}Node;

struct Node * linkedListEnd = NULL;
struct Node * first = NULL;

void nodeAppend(struct Node * toAdd){
  printf("adding %d\n", toAdd->val);
  if(linkedListEnd){
    linkedListEnd->next = toAdd;
    linkedListEnd = toAdd;
  }else{
    linkedListEnd = toAdd;
    first = toAdd;
  }
}

int main(void){
  struct Node * node1 = malloc(sizeof(struct Node));
  node1->val = 1;
  nodeAppend(node1);
  struct Node * node2 = malloc(sizeof(struct Node));
  node2->val = 2;
  nodeAppend(node2);
  struct Node * node3 = malloc(sizeof(struct Node));
  node3->val = 3;
  nodeAppend(node3);
  struct Node * current = first;
  while(current){
    printf("%d\n", current->val);
    current = current->next;
  }
  return 0;
}
