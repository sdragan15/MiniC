#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "array.h"

int arrays_table[SYMBOL_TABLE_LENGTH];
int first_array_empty = 0;

int insert_array(int n){
  int i;
  for(i=0; i<n; i++){
    arrays_table[first_array_empty][i] = 0;
  }
  first_array_empty++;
  return first_array_empty - 1;
}

int insert_element(int niz, int element, int k){
  if(niz < first_array_empty){
    arrays_table[niz][j] = element;
    return 1;
  }
  
  return 0;
}