//OPIS: niz indeksiran preko promenljive
//RETURN: 13
int main(){
  int x;
  int a[4];
  int i;
  int k;

  i = 1;
  k = 2;  

  a[i] = 4;
  a[0] = 2;
  a[k] = 6;
  x = a[i] + a[0] + 1 + a[k];

  return x;
}

