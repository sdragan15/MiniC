//OPIS: while
//RETURN: 13
int main(){
  int x;
  int y;
  int z;
  int k;
  int p;
  y = 0;
  x = 2;
  z = 5;
  k = 2;
  p = 2;

  while(y < 5){
    y = y + 1;
  }

  while(x--){
    y = y++;
  }

  while(z--){
    y = y + 1;
  }

  while(--k){
    y = y + 1;
  }


  return y;
}

