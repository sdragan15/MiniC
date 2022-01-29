//OPIS: ugnjezdeno while
//RETURN: 12
int main(){
  int x;
  int y;
  int z;
  y = 0;
  x = 0;
  z = 0;

  while(y<10){
    while(x<2){
      x = x + 1;
    }
    y = y + 1;
  }
  z = y + x;

  return z;
}

