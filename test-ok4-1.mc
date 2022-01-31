//OPIS: sabiranje i dodela nizova
//RETURN: 22
int main(){
  int x;
  int a[3];
  int b[10];

  a[0] = 1;
  a[1] = 4;
  x = a[0] + a[1];

  a[2] = 5;
  a[0] = 2;

  x = x + a[0] + a[2];

  b[4] = 10;
  x = x + b[4];

  return x;
}

