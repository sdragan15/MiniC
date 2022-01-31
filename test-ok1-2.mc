//OPIS: ugnjezdeno while
//RETURN: 30
int main(){
  int x;
  int y;
  int z;
  y = 5;
  x = 6;
  z = 0;

  while(y--){
    while(x--){
      z = z + 1;
    }
    x = 6;
  }

  return z;
}

