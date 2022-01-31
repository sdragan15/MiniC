//OPIS: nizovi u drugim funkcijama
//RETURN: 18
int main(){
  int x;
  int a[3];
  int b[10];
  int i;

  x = 0;
  a[0] = 6;
  a[1] = 4;
  b[0] = 10;
  b[4] = 3;

  while(a[0]){
      x = x + 1;
      a[0] = a[0] - 1;
  }

  
  for(i = 1; i <= b[4]; i++){
      x = x + a[1];
  }

  return x;
}

