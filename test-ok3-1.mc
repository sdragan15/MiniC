//OPIS: for osnovni koncept
//RETURN: 30
int main(){
  int x;
  int y;
  int z;
  y = 0;

  for(x = 1; x < 4; x++){
      y = y + x;
  }

  for(x = 0; x < 10; x = x + 8){
      y = y + x;
  }

  return y;
}

