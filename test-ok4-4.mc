//OPIS: niz preko promenljive u petlji
//RETURN: 28
int main(){
  int x;
  int a[4];
  int b[4];
  int i;
  int k;
  x = 0;

  for(i = 0; i<4; i++){
      a[i] = i + 1;
      x = x + a[i];
  }

  k = 0;
  while(k < 4){
    b[k] = k + 2;
    k = k + 1;
  }

  for(i = 0; i<4; i++){
      x = x + 1 + b[i];
  }


  return x;
}

