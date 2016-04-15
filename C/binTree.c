#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

struct typedef {
  int32_t key;
  node * parent;
  node * left;
  node * right;
} node;

int main(void){
  for(;;){
    char ch = malloc(char);
    scanf("%c", &ch);
    if(ch == 's')
      break;
    if(ch == 'p')
      postOrder(root);
    if(ch == 'r')
      preOder(root);
    if(ch == 'o')
      inOrder(root);
    if(ch == 'i')
      insertswitch(ch){
    case 's':
      break;

    }
      
  }


}


node * newInstance(int32_t val){
  node * new = malloc(node *);
  new.parent = NULL;
  new.left   = NULL;
  new.right  = NULL;
  new.key = val;
  return new;
}
    
void insertNode(node * root, int32_t toInsert){
  node * parentNode = NULL;
  node * currentNode = root;
  while(currentNode != NULL){ //find appropriate position
    parentNode = currentNode;
    if(currentNode.key < toInsert)
      currentNode = currentNode.right;
    else
      currentNode = currentNode.left;
  }
  Node * newNode = newInstance(toInsert);
  newNode.parent = parentNode; //install the node there
  if(parentNode == NULL){
    root = newNode;
  }else{
    if(toInsert < parentNode.key)
      parentNode.left = toInsert;
    else
      parentNode.right = toInsert;
  }
}

node * findNode(node * root, int32_t toFind){
  node * currentNode = root;
  while(currentNode.key != toFind && currentNode != NULL){
    if(toFind < currentNode.key)
      currentNode = currentNode.right;
    else
      currentNode = currentNode.left;
  }
  return currentNode;
}

node * getSuccessor(node * currentNode){
  if(currentNode.right != NULL) //find minimum in right subtree
    return getMinimum(currentNode.right);
  else{ //go up until parent is bigger
    while(currentNode != currentNode.parent.left && currentNode != NULL)
      currentNode = currentNode.parent;
    return currentNode;
  }
}

node * getPredecessor(node * currentNode){
  if(currentNode.left != NULL) //find maximum in left subtree
    return getMaximum(currentNode.left);
  else{ //go up until parent is smaller
    while(currentNode != currentNode.parent.right && currentNode != NULL)
      currentNode = currentNode.parent;
    return currentNode;
  }
}

node * getMinimum(node * currentNode){
  while(currentNode.left != NULL)
    currentNode = currentNode.left;
  return currentNode;
}

node * getMaximum(node * currentNode){
  while(currentNode.right != NULL)
    currentNode = currentNode.right;
  return currentNode;
}

void deleteNode(node * root, node * toDelete){
  node * toSplice = NULL;
  node * splicee = NULL;
  if(toDelete.left == NULL || toDelete.right == NULL) //one or less children: Another node does not have to be found to replace it
    toSplice = toDelete;
  else{//find replacement
    toSplice = getSuccessor(toDelete);
    if(toSplice == NULL)
      toSplice = getPredecessor(toDelete);
  }
  if(toSplice.left != NULL) //identify what to splice onto the parent node
    splicee = toSplice.left;
  else
    splicee = toSplice.right;
  if(splicee != NULL)//splice if the node exists
    splicee.parent = toSplice.parent;
  if (toSplice.parent == NULL)
    root = splicee;
  else {
    if(toSplice == toSplice.parent.left) //find out where to attach splicee
      toSplice.parent.left = splicee;
    else
      toSplice.parent.right = splicee;
  }
  if(toSplice != splicee){ //if it had two children originally, then the splicing occurs at another point than the toDelete node
    toDelete.key = toSplice = key;
  }
  free(toSplice);
}
