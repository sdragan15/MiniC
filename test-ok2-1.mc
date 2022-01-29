//OPIS: post increment
//RETURN: 5
int main(){
  int x;
  int y;
  int z;

  y = 0;
  x = 2;
  z = 0;

  y = x++;

  z = x;

  return z + y;
}

