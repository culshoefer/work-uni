#include <ctype.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>

#define BOARDSIZE 16

void printBoard(bool a[BOARDSIZE]);
void printPath(unsigned short cNode, unsigned short first);
int readNextInt(FILE *fp);
unsigned short boolToShort(bool currentAr[BOARDSIZE]);
void enqueue(unsigned short number);
unsigned short dequeue();
void getNextBoard(char hit, bool current[BOARDSIZE], bool (*new)[BOARDSIZE]);
void copyBoard(bool from[BOARDSIZE], bool to[BOARDSIZE]);
void initializeArray(int nextInt, bool currentAr[BOARDSIZE], FILE * fp);
unsigned short bfs(unsigned short firstBoard);


typedef struct queueElement{
  unsigned short num;
  struct queueElement * next;
}queueElement;

unsigned int numBoardsConsidered = 0;

queueElement **qBack = NULL;
queueElement **qFront = NULL;
bool seen[65536]; //flag if come across, used for BFS
unsigned short parent[65536]; //holds the parent element from each node, used for printing the path
char hitPosition[65536]; // holds the position the "Hammer" was applied (0-15)
bool board[65536][BOARDSIZE]; //represents one board (4x4)

int main(void){
  FILE *fp = fopen("input.txt","r");
  if(fp == NULL){
    printf("No file found.\n");
    for(;;);
  }
  qBack = (queueElement **)malloc(sizeof(queueElement **));
  qFront = (queueElement **)malloc(sizeof(queueElement **));
  (*qBack) = NULL;
  (*qFront)= NULL;
  int nextInt;
  bool currentAr[BOARDSIZE];
  unsigned short firstBoard;

  int i;
  for (i = 0; i < BOARDSIZE; i++) *(currentAr + i) = false;
  nextInt = readNextInt(fp);
  initializeArray(nextInt, currentAr, fp);
  firstBoard=boolToShort(currentAr);
  parent[firstBoard] = firstBoard;
  hitPosition[firstBoard] = 0;

  for (i = 0; i < BOARDSIZE;i++)
    board[firstBoard][i] = currentAr[i];
  unsigned short emptyBoard = bfs(firstBoard);
  printf("done bfs, empty board is board number: %d, first board: %d\n", emptyBoard, firstBoard);
  printPath(emptyBoard, firstBoard);
  fclose(fp);
  return 0;
}

void enqueue(unsigned short number){
  queueElement * new = NULL;
  new = (queueElement *)malloc(sizeof(queueElement *));
  new -> num = number;
  new -> next = NULL;

  if ((*qBack) == NULL){ //Zero elements
    (*qBack) = new;
    (*qFront)= new;
  } else { //More than zero elements
    (*qBack) -> next = new;
    (*qBack) = new;
  }
}


unsigned short dequeue(){
  queueElement * ptr = (*qFront);
  if ((*qFront) == NULL){ //Queue underflow
    return 0;
  }
  unsigned short retval = (*qFront) -> num;
  if((*qFront) -> next == NULL){ //One element
    free(ptr);
    (*qFront) = (*qBack) = NULL;
  }
  else{ //More than one element
    (*qFront) = (*qFront) -> next;
    free(ptr);
  }
  return retval;
}

void initializeArray(int nextInt, bool currentAr[BOARDSIZE], FILE * fp){
  while (nextInt){
    printf("%d\t", nextInt);
    currentAr[nextInt-1] = true;
    nextInt = readNextInt(fp);
  }
}

unsigned short bfs(unsigned short firstBoard){
  bool found = false;
  unsigned short cNode = firstBoard;
  enqueue(firstBoard);
  while (!found){
    cNode = dequeue(); //current node
    numBoardsConsidered++;
    printf("%d\n", numBoardsConsidered);
    seen[cNode] = true;
    found = true;
    int i;
    for (i = 0; i < BOARDSIZE; i++){ //try all possible hitting positons (get adjacent nodes)
      bool  newBoard[BOARDSIZE];
      if (board[cNode][i]){
	found = false;
	getNextBoard(i, board[cNode], &newBoard);
	unsigned short nBNum = boolToShort(newBoard);
	if (!seen[nBNum]){
	  parent[nBNum] = cNode;
	  hitPosition[nBNum] = i;
	  copyBoard(newBoard, board[nBNum]);
	  enqueue(nBNum);
	}
      }
    }
  }
  return cNode;
}

int readNextInt(FILE *fp){
  int in = fgetc(fp);
  int out = 0;
  if(!isdigit(in)){
    while(in != -1 && !isdigit(in))
      in = fgetc(fp);
  }
  while(in != -1 && isdigit(in)){
    out = 10 * out + (in-48);
    in = fgetc(fp);
  }
  return out;
}


void getNextBoard(char hit, bool current[BOARDSIZE], bool (*new)[BOARDSIZE]){
  int i;
  //printf("HITING AT %d\n", hit);
  for(i = 0; i < BOARDSIZE; i++)
    (*new)[i] = current[i];
  (*new)[(int)hit] = !((*new)[(int)hit]);
  if(hit >= 4)
    (*new)[hit - 4]= !((*new)[hit - 4]);
  if(hit <= 11)
    (*new)[hit + 4]= !((*new)[hit + 4]);
  if(hit % 4 != 0)
    (*new)[hit - 1]= !((*new)[hit - 1]);
  if(hit % 4 != 3)
    (*new)[hit + 1]= !((*new)[hit + 1]);

  //printBoard(*new);
}

unsigned short boolToShort(bool a[BOARDSIZE]){
  unsigned short retval=0;
  int i;
  for(i = 15; i >= 0; i--){
    if(a[i])
      retval++;
    retval *= 2;
  }
  return retval;
}


void copyBoard(bool from[BOARDSIZE], bool to[BOARDSIZE]){
  int i;
  for(i = 0; i < BOARDSIZE; i++)
    to[i] = from[i];
}

void printPath(unsigned short cNode, unsigned short first){
  while(cNode != first){
    printf("%d\tboard %d\n", hitPosition[cNode] + 1, cNode);
    cNode = parent[cNode];
  }
  printf("\n");
}

void printBoard(bool a[BOARDSIZE]){
  int i;
  printf("\n");
  for (i = 0; i < BOARDSIZE; i++){
    if(a[i] == 1)
      printf("%d\t", i);
  }
  printf("\n");
  for (i = 0; i < BOARDSIZE; i++){
    if (a[i] == 1)
      printf("1");
    else
      printf("0");
    if (i%4 == 3)
      printf("\n");
  }
  printf("\n");
}
