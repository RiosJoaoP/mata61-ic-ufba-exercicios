/* 
 * Example 1-4. Calculator scanner fb1-4.l, from Levine book, p. 7-8.
 * Scanner recognizes tokens for the calculator and prints them out.
 *  - yylval is the variable that stores the token value, an integer;
*/
%option noyywrap nodefault yylineno

%{
#include "calc.tab.h"

void yyerror(char *s);

%}

DIGIT [0-9]+(\.[0-9]{1,2})?         
%%

"+"      { return ADD; }
"-"      { return SUB; }
"*"	   { return MUL; }
"/"	   { return DIV; }
"|"	   { return ABS; }
{DIGIT}  { return NUMBER; }

[ \t]   { /* ignore whitespace */ }

\n                      { return EOL; } 
.   	                  { return ERROR; }
%%

int main(int argc, char **argv)
{
   int tok;

   while ((tok = yylex())) {
      printf("%d", tok);
      if (tok == NUMBER) printf(" = %s\n", yytext);
      else if (tok == ERROR) { 
         printf("Mistery character %c\n", *yytext);
         break;
      }
      else printf("\n");
      if (tok == EOL) break; 
   }
}


