/* Programa que lee un archivo que contiene expresiones aritmeticas basicas y logicas*/
/*muestra en pantalla los identificadores, enteros, reales, parentesis, asignacion, oper. aritmeticos y logicos y los delimitadores*/
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
FILE *in,*sal;
int dt=0,error=0,linea=2,col=0;

%}
/* definiciones regulares*/
salto \n
comentario "//".*\n
num [0]
delim [ |\t]+
op_rel "<"|">"|"=="|"<="|">="|"!="
op_art "+"|"-"|"/"|"*"
op_log "&&"|"||"
asig "=" 
entero [0-9]*
real [0-9]+"."[0-9]+|[0-9]+".""E"[-|+]?[0-9]+
id [a-z|A-Z][a-z|A-Z|0-9]*|["_"?]
cadena \".+\"
caracter '.'
errores .
%%
int|char|float|double {fprintf(sal,"Tipo\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
for|while|do|printf|scanf|if|else|break|switch|case|pow|sqrt|fprint|fscan|return|#include {fprintf(sal,"Reservada\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{op_rel} {fprintf(sal,"op_rel\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{op_art} {fprintf(sal,"op_art\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{op_log} {fprintf(sal,"op_log\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{asig} {fprintf(sal,"asig\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{comentario} {fprintf(sal,"comentario\t");fprintf(sal,"\t%d\n",linea);}
{real} {fprintf(sal,"real\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{entero} {fprintf(sal,"entero\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{id} {fprintf(sal,"id\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{cadena} {fprintf(sal,"cadena\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{caracter} {fprintf(sal,"caracter\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);}
{salto} {linea++;}
{errores} {error++;}
%%

void main(void)
{
   

   if ((in = fopen("texto.txt", "r"))  == NULL)
   {
      printf("Cannot open input file.\n");
      exit(1);

   }
   if ((sal = fopen("salida.txt", "w"))  == NULL)
   {
      printf("Cannot open input file.\n");
      exit(1);

   }
	 yyin=in;
	 yylex(); /* inicia analisis lexico*/
     printf("\n Errores: %d",error);
     printf("\n Num lineas: %d",linea+1);
   fclose(in);
    fclose(sal);
}

