//OPIS: apsolutna vrednost
//RETURN: 15

int f(){
    int x;
    x = -10;
    return abs(x);
}

int main(){
  int x;
  int y;
  int a[4];
  int i;
  int j;

  y = -1;

  x = abs(y);

  
  j = -2;
  for(i = 0; i < 4; i++){
      a[i] = j++;
      x = x + abs(a[i]);
  }


  return x + f();
}

