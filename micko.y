%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "defs.h"
  #include "symtab.h"
  #include "codegen.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  int out_lin = 0;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  int var_num = 0;
  int array_num = 0;
  int array_elements = 0;
  int fun_idx = -1;
  int fcall_idx = -1;
  int lab_num = -1;
  int while_num = 0;
  int for_num = 0;
  int arr_el_index = -1;
  int struct_num = 0;
  char struct_name[20];
  int while_index[100];
  int assign_index[100];
 

  int array_table[20][20];
  int first_empty_array = 0;

  FILE *output;
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token <i> _AROP
%token <i> _RELOP
%token _WHILE
%token _FOR
%token _INC
%token _DEC
%token _LSQUARE
%token _RSQUARE
%token _STRUCT
%token <s> _STRUCT_ID

%type <i> num_exp exp literal while_uslov inc_dec_exp for_promena
%type <i> function_call argument rel_exp if_part array_index

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : structs_functions
      {  
        if(lookup_symbol("main", FUN) == NO_INDEX)
          err("undefined reference to 'main'");
      }
  ;

function_list
  : function
  | function_list function
  ;

struct_list
  : struct
  | struct_list struct
  ;

structs_functions
  : function_list
  | struct_list function_list
  ;

function
  : _TYPE _ID
      {
        fun_idx = lookup_symbol($2, FUN);
        if(fun_idx == NO_INDEX)
          fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
        else 
          err("redefinition of function '%s'", $2);

        code("\n%s:", $2);
        code("\n\t\tPUSH\t%%14");
        code("\n\t\tMOV \t%%15,%%14");
      }
    _LPAREN parameter _RPAREN body
      {
        clear_symbols(fun_idx + 1);
        var_num = 0;
        
        code("\n@%s_exit:", $2);
        code("\n\t\tMOV \t%%14,%%15");
        code("\n\t\tPOP \t%%14");
        code("\n\t\tRET");
      }
  ;


struct
  : _STRUCT _ID
      {
          strcpy(struct_name, $2);
      }
    _LBRACKET struct_var_list _RBRACKET _SEMICOLON
      {
        int idx = lookup_symbol($2, VAR);
        if(idx == NO_INDEX){
          insert_symbol($2, VAR, STRUCT, ++struct_num, NO_ATR);
        }
        else{
          err("'%s' is already declared", $2);
        }
      }
  ;

struct_var_list
  :
  | struct_var_list struct_var
  ;

struct_var
  : _TYPE _ID _SEMICOLON
  ;



parameter
  : /* empty */
      { set_atr1(fun_idx, 0); }

  | _TYPE _ID
      {
        insert_symbol($2, PAR, $1, 1, NO_ATR);
        set_atr1(fun_idx, 1);
        set_atr2(fun_idx, $1);
      }
  ;

body
  : _LBRACKET variable_list
      {
        if(var_num)
          code("\n\t\tSUBS\t%%15,$%d,%%15", 4*var_num);
        code("\n@%s_body:", get_name(fun_idx));
      }
    statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : _TYPE _ID _SEMICOLON
      {
        if(lookup_symbol($2, VAR|PAR) == NO_INDEX)
           insert_symbol($2, VAR, $1, ++var_num, NO_ATR);
        else 
           err("redefinition of '%s'", $2);
      }
  | _TYPE _ID _LSQUARE literal _RSQUARE _SEMICOLON
      {
        int elements;
        if(lookup_symbol($2, VAR|PAR|ARR) == NO_INDEX){
            elements = atoi(get_name($4));
            insert_symbol($2, ARR, $1, ++var_num, elements);
            var_num += elements - 1;
        } 
        else 
           err("redefinition of '%s'", $2);

        if(elements <= 0){
          err("array must have positive number of elements");
        }
      }
  | _STRUCT _ID _ID _SEMICOLON
      {
        print_symtab();
        int idx = lookup_symbol($2, VAR|PAR);
        if(idx == NO_INDEX){
          err("'%s' is undeclared", $2);
        }

        insert_symbol($3, VAR, STRUCT, ++var_num, NO_ATR);
      }
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | while_statement
  | for_statement
  ;

for_statement
  : _FOR _LPAREN _ID _ASSIGN literal 
      {
        int idx = lookup_symbol($3, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $3);

        gen_mov($5, idx);
        
        code("\n@for_%d:", ++for_num);

        $<i>$ = for_num;

      }
   _SEMICOLON rel_exp 
      {
        code("\n\t\t%s\t@for_%d_exit", opp_jumps[$8], $<i>6);
        code("\n\t\tJMP\tfor_%d_continue", $<i>6);
        code("\n@for_%d_promena:", $<i>6);
      }
    _SEMICOLON for_promena
        {
            gen_inc_dec($11);
            code("\n\t\tJMP\t@for_%d", $<i>6);
            code("\nfor_%d_continue:", $<i>6);
        }
     _RPAREN _LBRACKET statement_list _RBRACKET
      {
        
        code("\n\t\tJMP\t@for_%d_promena", $<i>6);
        code("\n@for_%d_exit:", $<i>6);
      }
  ;

for_promena
  : _ID _ASSIGN num_exp
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $1);

        gen_mov($3, idx);
        $$ = -1;
      }
  | inc_dec_exp
      {
        $$ = $1;
      }
  ;


while_statement
  : _WHILE
        {
          code("\n@while_%d:", ++while_num);

          $<i>$ = while_num;
        }
    _LPAREN while_uslov 
        {
          if($4 < 0){
            code("\n\t\tJEQ\t@while_%d_exit", $<i>2);
          }
          else{
            code("\n\t\t%s\t@while_%d_exit", opp_jumps[$4], $<i>2);
          }

          gen_inc_dec(while_index[$<i>2]);
          
          code("\n@while_%d_continue:", $<i>2);
        }
     _RPAREN _LBRACKET statement_list _RBRACKET 
        {
          code("\n\t\tJMP\t@while_%d", $<i>2);
          code("\n@while_%d_exit:", $<i>2);
        }
  ;

while_uslov
  : exp
      {
        int idx = $1;
        int type = get_type(idx);
        if(type == INT){
          code("\n\t\tCMPS\t");
        }
        else{
          code("\n\t\tCMPU\t");
        }
        gen_sym_name(idx);
        code(", ");
        code("$0");
        
        while_index[while_num] = idx;
        $$ = -1;
      }
  | rel_exp
      {
        $$ = $1;
      }
  ;
  
  
compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($3))
            err("incompatible types in assignment");
        gen_mov($3, idx);

        
        gen_inc_dec($3);
      }

  | _ID _LSQUARE array_index _RSQUARE _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, ARR);
        
        if(idx == NO_INDEX)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($6))
            err("incompatible types in assignment");

        int reg = take_array_id(idx, $3);
        gen_mov($6, reg);
        free_if_reg(reg);
      }

  ;

array_index
  : literal
      {
        $$ = atoi(get_name($1));
      }
  | _ID
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $1);
        
        $$ = idx;
      }
  ;

num_exp
  : exp 

  | num_exp _AROP exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: arithmetic operation");

        int t1 = get_type($1);    
        code("\n\t\t%s\t", ar_instructions[$2 + (t1 - 1) * AROP_NUMBER]);
        gen_sym_name($1);
        code(",");
        gen_sym_name($3);
        code(",");
        free_if_reg($3);
        free_if_reg($1);
        $$ = take_reg();
        gen_sym_name($$);
        set_type($$, t1);

      }
  ;

exp
  : literal

  | _ID
      {
        $$ = lookup_symbol($1, VAR|PAR);
        if($$ == NO_INDEX)
          err("'%s' undeclared", $1);
      }

  | function_call
      {
        $$ = take_reg();
        gen_mov(FUN_REG, $$);
      }
  
  | _LPAREN num_exp _RPAREN
      { $$ = $2; }
  
  | inc_dec_exp
      {
        $$ = $1;
      }
  
  | _ID _LSQUARE literal _RSQUARE
      {
        int idx = lookup_symbol($1, ARR);
        if(idx == NO_INDEX){
          err("'%s' undeclared", $1);
        }

        int broj = atoi(get_name($3));
        if(get_atr2(idx) <= broj){
          err("Index is out of range");
          return 0;
        }

        int reg = take_array_id(idx, broj);
        $$ = reg;
        
      }

  | _ID _LSQUARE _ID _RSQUARE
      {
        int array = lookup_symbol($1, ARR);
        int index = lookup_symbol($3, VAR|PAR);
        if(array == NO_INDEX || index == NO_INDEX)
          err("undeclared variable");

        int reg = take_array_id(array, index);

        $$ = reg;
      }
  ;



inc_dec_exp
  : _ID _INC
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $1);

        set_atr2(idx, POST_INC);
        $$ = idx;
      }
    
  | _ID _DEC
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $1);

        set_atr2(idx, POST_DEC);
        $$ = idx;
      }

  | _INC _ID
      {
        int idx = lookup_symbol($2, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $2);

        if(get_type(idx) == INT){
            code("\n\t\tADDS\t");
          }
          else{
            code("\n\t\tADDU\t");
          }

          gen_sym_name(idx);
          code(", $1, ");
          int reg = take_reg();
          gen_sym_name(reg);
          gen_mov(reg, idx);

          free_if_reg(idx);
          set_atr2(idx, PRE);
        $$ = idx;
      }

  | _DEC _ID
      {
        int idx = lookup_symbol($2, VAR|PAR);
        if(idx == NO_INDEX)
          err("'%s' undeclared", $2);

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

          free_if_reg(idx);
        set_atr2(idx, PRE);
        $$ = idx;
      }
  ;


literal
  : _INT_NUMBER
      { $$ = insert_literal($1, INT); }

  | _UINT_NUMBER
      { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
      {
        fcall_idx = lookup_symbol($1, FUN);
        if(fcall_idx == NO_INDEX)
          err("'%s' is not a function", $1);
      }
    _LPAREN argument _RPAREN
      {
        if(get_atr1(fcall_idx) != $4)
          err("wrong number of arguments");
        code("\n\t\t\tCALL\t%s", get_name(fcall_idx));
        if($4 > 0)
          code("\n\t\t\tADDS\t%%15,$%d,%%15", $4 * 4);
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
      }
  ;

argument
  : /* empty */
    { $$ = 0; }

  | num_exp
    { 
      if(get_atr2(fcall_idx) != get_type($1))
        err("incompatible type for argument");
      free_if_reg($1);
      code("\n\t\t\tPUSH\t");
      gen_sym_name($1);
      $$ = 1;
    }
  ;

if_statement
  : if_part %prec ONLY_IF
      { code("\n@exit%d:", $1); }

  | if_part _ELSE statement
      { code("\n@exit%d:", $1); }
  ;

if_part
  : _IF _LPAREN
      {
        $<i>$ = ++lab_num;
        code("\n@if%d:", lab_num);
      }
    rel_exp
      {
        code("\n\t\t%s\t@false%d", opp_jumps[$4], $<i>3);
        code("\n@true%d:", $<i>3);
      }
    _RPAREN statement
      {
        code("\n\t\tJMP \t@exit%d", $<i>3);
        code("\n@false%d:", $<i>3);
        $$ = $<i>3;
      }
  ;

rel_exp
  : num_exp _RELOP num_exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: relational operator");
        $$ = $2 + ((get_type($1) - 1) * RELOP_NUMBER);
        gen_cmp($1, $3);
      }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
      {
        if(get_type(fun_idx) != get_type($2))
          err("incompatible types in return");
        gen_mov($2, FUN_REG);
        code("\n\t\tJMP \t@%s_exit", get_name(fun_idx));    
      }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();
  output = fopen("output.asm", "w+");

  synerr = yyparse();

  clear_symtab();
  fclose(output);
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count) {
    remove("output.asm");
    printf("\n%d error(s).\n", error_count);
  }

  if(synerr)
    return -1;  //syntax error
  else if(error_count)
    return error_count & 127; //semantic errors
  else if(warning_count)
    return (warning_count & 127) + 127; //warnings
  else
    return 0; //OK
}

