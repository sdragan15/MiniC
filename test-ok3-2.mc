//OPIS: ugnjezdeni for
//RETURN: 12
int main(){
  int x;
  int y;
  int z;
  int k;
  k = 0;
  y = 0;

  for(x = 0; x < 4; x++){
     for(z = 0; z < 2; z++){
         y = y + 1;
        k = z++;            // Ovo se izvrsi pa se restartuje na NO_ATR. treba preko nizova da se uradi.
     }
  }

  for(x = 0; x < 4; x++){
     for(z = 0; z < 2; z++){
         y = y + 1;
     }
  }

  return y;
}

