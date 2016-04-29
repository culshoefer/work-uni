#include <iostream>

using namespace std;

class Node{
public:
  Node * getSuccessor();
  Node * getPredecessor();
  Node * getMinimum();
  Node * getMaximum();
  Node(int32_t val);
private:
  int32_t m_key;
  Node * m_parent, m_left, m_right;
};

class Tree{
public:
  void insert(int32_t toInsert);
  void del(Node * toDelete);
  Node * find(int32_t toFind);
  int32_t getSize();
  Tree();
private:
  Node * m_root;
  int32_t m_numElem;
};

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

Tree::Tree(){
  this.m_numElem = m_numElem;
  this.m_root = m_root;
}

Node::Node(int32_t val){
  this.m_key = val;
  this.m_key = m_key;
  this.m_parent = m_parent;
  this.m_left = m_left;
  this.m_right = m_right;
}
    
Tree::insert(const int32_t toInsert){
  Node * parentNode = NULL;
  Node * currentNode = m_root;
  while(currentNode != NULL){ //find appropriate position
    parentNode = currentNode;
    if(currentNode.m_key < toInsert)
      currentNode = currentNode.m_right;
    else
      currentNode = currentNode.m_left;
  }
  Node * newNode = Node(toInsert);
  newNode.m_parent = parentNode; //install the node there
  if(parentNode == NULL){
    m_root = newNode;
  }else{
    if(toInsert < parentNode.m_key)
      parentNode.m_left = toInsert;
    else
      parentNode.m_right = toInsert;
  }
}

Node * Tree::find(const int32_t toFind){
  Node * currentNode = m_root;
  while(currentNode.m_key != toFind && currentNode != NULL){
    if(toFind < currentNode.m_key)
      currentNode = currentNode.m_right;
    else
      currentNode = currentNode.m_left;
  }
  return currentNode;
}

Node * Node::getSuccessor(){
  if(this.right != NULL) //find minimum in right subtree
    return this.getMinimum(this.right);
  else{ //go up until parent is bigger
    Node * current = this;
    while(current != current.m_parent.m_left && current != NULL)
      current = current.m_parent;
    return current;
  }
}

Node * Node::getPredecessor(){
  if(this.left != NULL) //find maximum in left subtree
    return this.getMaximum(this.left);
  else{ //go up until parent is smaller
    Node * current = this;
    while(current != current.m_parent.m_right && current != NULL)
      current = current.m_parent;
    return current;
  }
}

Node * Node::getMinimum(){
  Node * current = this;
  while(current.m_left != NULL)
    current = current.m_left;
  return current;
}

Node * Node::getMaximum(){
  Node * current = this;
  while(current.m_right != NULL)
    current = current.m_right;
  return current;
}

void Tree::del(Node * toDelete){
  Node * toSplice = NULL;
  Node * splicee = NULL;
  if(toDelete.m_left == NULL || toDelete.m_right == NULL) //one or less children: Another node does not have to be found to replace it
    toSplice = toDelete;
  else{//find replacement
    toSplice = toDelete.getSuccessor();
    if(toSplice == NULL)
      toSplice = toDelete.getPredecessor();
  }
  if(toSplice.m_left != NULL) //identify what to splice onto the parent node
    splicee = toSplice.m_left;
  else
    splicee = toSplice.m_right;
  if(splicee != NULL)//splice if the node exists
    splicee.m_parent = toSplice.m_parent;
  if (toSplice.m_parent == NULL)
    root = splicee;
  else {
    if(toSplice == toSplice.m_parent.m_left) //find out where to attach splicee
      toSplice.m_parent.m_left = splicee;
    else
      toSplice.m_parent.m_right = splicee;
  }
  if(toSplice != splicee){ //if it had two children originally, then the splicing occurs at another point than the toDelete node
    toDelete.m_key = toSplice.m_key;
  }
  free(toSplice);
}
