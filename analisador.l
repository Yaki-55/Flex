/* Programa que lee un archivo que contiene expresiones aritmeticas basicas y logicas*/
/*muestra en pantalla los identificadores, enteros, reales, parentesis, asignacion, oper. aritmeticos y logicos y los delimitadores*/
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
FILE *in,*sal;
int dt=0,error=0,linea=2,col=0;
typedef struct nodo_num Nodo_num;
typedef struct lista_num Lista_num;
struct nodo_num{
    int data;
    Nodo_num *next;
};
struct lista_num{
    Nodo_num *head;
};

Lista_num* create_lista_num();
Nodo_num* create_nodo_num(int item);
void insert_head(Nodo_num **head_ref, int item);
void insert_end (Nodo_num **head_ref, int item);
void display(Lista_num *lista_num);
Lista_num *lista_num;
%}
/* definiciones regulares*/
salto \n
comentario "//".*\n
num [0-9]
delim [ |\t]+
op_rel "<"|">"|"=="|"<="|">="|"!="
op_art "+"|"-"|"/"|"*"
op_log "&&"|"||"
asig "=" 
entero [0-9]*
real [0-9]+"."[0-9]+|[0-9]+".""E"[-|+]?[0-9]+
id [a-z|A-Z][a-z|A-Z|_|0-9]*
cadena \".+\"
caracter '.'
errores .
%%
int|char|float|double {fprintf(sal,"Tipo\t");fprintf(sal,yytext);fprintf(sal,"\t%d\n",linea);insert_end(&lista_num->head,linea);}
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
/*funciones pila*/
Lista_num* create_lista_num(){
    Lista_num *lista_num = (Lista_num *) malloc (sizeof(Lista_num));
    lista_num->head = NULL;
    return lista_num;
}
Nodo_num* create_nodo_num(int item){
    Nodo_num *new_nodo_num = (Nodo_num*) malloc (sizeof(Nodo_num));
    new_nodo_num->data = item;
    new_nodo_num->next = NULL;
    return new_nodo_num;
}
void insert_head(Nodo_num **head_ref, int item){
    Nodo_num *new_nodo_num = create_nodo_num(item);
    new_nodo_num->next = (*head_ref);
    (*head_ref) = new_nodo_num;
}
void insert_end (Nodo_num **head_ref, int item){
    if (*head_ref == NULL)
    {
        insert_head(head_ref, item);
        return;//////////con este return se interrumpe el if//////
    } 
    Nodo_num *new_nodo_num = create_nodo_num(item);
    Nodo_num *last = *head_ref;
    while (last->next != NULL)
       last = last->next;
    last->next = new_nodo_num;
}
void display(Lista_num *lista_num){
    Nodo_num *nodo_num = lista_num->head;
    while(nodo_num!=NULL){
        printf("%d\n", nodo_num->data);
        nodo_num = nodo_num->next;
    }
}
void main(void){
    
    lista_num=create_lista_num();
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
    display(lista_num);
}