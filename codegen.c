#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "codegen.h"
#include "symtab.h"


extern FILE *output;
int free_reg_num = 0;
char invalid_value[] = "???";

// REGISTERS

void gen_inc_dec(int idx){
  if(get_atr2(idx) == POST_INC){
      if(get_type(idx) == INT){
        code("\n\t\tADDS\t$1, ");
      }
      else{
        code("\n\t\tADDU\t$1, ");
      }

      gen_sym_name(idx);
      code(", ");
      int reg = take_reg();
      gen_sym_name(reg);
      gen_mov(reg, idx);

      set_atr2(idx, NO_ATR);
      free_if_reg(idx);
    }
    else if(get_atr2(idx) == POST_DEC){
      if(get_type(idx) == INT){
        code("\n\t\tSUBS\t");
      }
      else{
        code("\n\t\tSUBU\t");
      }

      gen_sym_name(idx);
      code(", $1, ");
      int reg = take_reg();
      gen_sym_name(reg);
      gen_mov(reg, idx);

      set_atr2(idx, NO_ATR);
      free_if_reg(idx);
    }
}

int take_reg(void) {
  if(free_reg_num > LAST_WORKING_REG) {
    err("Compiler error! No free registers!");
    exit(EXIT_FAILURE);
  }
  return free_reg_num++;
}

void free_reg(void) {
   if(free_reg_num < 1) {
      err("Compiler error! No more registers to free!");
      exit(EXIT_FAILURE);
   }
   else{
     set_type(--free_reg_num, NO_TYPE);
     set_kind(free_reg_num, NO_KIND);
     set_atr2(free_reg_num, NO_ATR);
   }
      
}

// Ako je u pitanju indeks registra, oslobodi registar
void free_if_reg(int reg_index) {
  if(reg_index >= 0 && reg_index <= LAST_WORKING_REG)
    free_reg();
}

// vraca registar u kome se nalazi adresa od elementa iz niza
// array na indeksu index.
int take_array_id(int array, int index){
  if(get_kind(index) != VAR && get_kind(index) != PAR){
    int reg = take_reg();
    int num = 4 * index + get_atr1(array) * 4;
    code("\n\t\tSUBS\t%%14, $%d, ", num);
    gen_sym_name(reg);

    set_type(reg, get_type(array));
    set_atr2(reg, -1);

    return reg;
  }
  
  int reg = take_reg();
  code("\n\t\tMULS\t$4, ");
  gen_sym_name(index);
  code(", ");
  gen_sym_name(reg);

  code("\n\t\tADDS\t$%d, ", get_atr1(array)*4);
  gen_sym_name(reg);
  code(", ");
  gen_sym_name(reg);
  code("\n\t\tSUBS\t%%14, ");
  gen_sym_name(reg);
  code(", ");
  gen_sym_name(reg);

  set_type(reg, get_type(array));
  set_atr2(reg, -1);

  return reg;
   
}


// SYMBOL
void gen_sym_name(int index) {
  if(index > -1) {
    if(get_kind(index) == VAR || get_kind(index) == ARR) // -n*4(%14)
      code("-%d(%%14)", get_atr1(index) * 4);
    else 
      if(get_kind(index) == PAR) // m*4(%14)
        code("%d(%%14)", 4 + get_atr1(index) *4);
      else
        if(get_kind(index) == LIT)
          code("$%s", get_name(index));
        else //function, reg
        {
          if(get_atr2(index) == -1){
            code("(%s)", get_name(index));
          }
          else
          code("%s", get_name(index));
        }
          
  }
}

// OTHER

void gen_cmp(int op1_index, int op2_index) {
  if(get_type(op1_index) == INT)
    code("\n\t\tCMPS \t");
  else
    code("\n\t\tCMPU \t");
  gen_sym_name(op1_index);
  code(",");
  gen_sym_name(op2_index);
  free_if_reg(op2_index);
  free_if_reg(op1_index);
}

void gen_mov(int input_index, int output_index) {
  code("\n\t\tMOV \t");
  gen_sym_name(input_index);
  code(",");
  gen_sym_name(output_index);

  //ako se sme??ta u registar, treba preneti tip 
  if(output_index >= 0 && output_index <= LAST_WORKING_REG)
    set_type(output_index, get_type(input_index));
  free_if_reg(input_index);
}

