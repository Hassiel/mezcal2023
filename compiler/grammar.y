%code requires{
	#include <string>
}
%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include "SyntaxTree/Includes.hpp"
#include <memory>

std::unique_ptr<compiler::SyntaxTree> root;
using namespace compiler;
std::string result;
int yylex(void);
void yyerror(char const *);
extern char *yytext;
%}

%define api.value.type { std::string }

%token	NAME COLON RIGHT_ARROW LEFT_CURLY_BRACE RIGHT_CURLY_BRACE SEMICOLON LEFT_PARENTHESIS RIGHT_PARENTHESIS SINGLECOMMENT
	MULTILINECOMMENT SHOW QUOTES CHARACTERS_BLOCK INT INTEGER_VALUE DECIMAL_VALUE LOAD STDIN DOLLAR_SIGN INC DEC DECIMAL BLN SET TRUE FALSE NTOL QUESTION_MARK
	CORCH_IZQ CORCH_DERECHO EQ LE LT GT GE NE ELSE COMA STR DOBLE_COLON WHILE ANSWER ADD DOB_SLASH_IN LES SLASH SIMP

%start input

%%

input:

function function_list  {
	result = std::string("#include <cstdio>\n #include <iostream>\n using namespace std;\n") + $1 + $2; }
	;

function_list:

	function function_list	
	{ $$ = $1 + $2; }
	|
	%empty
	{ $$ = ""; }
	;

function:
	name DOBLE_COLON CORCH_IZQ CORCH_DERECHO RIGHT_ARROW CORCH_IZQ INT CORCH_DERECHO COLON LEFT_CURLY_BRACE statements ANSWER RIGHT_CURLY_BRACE
	{
		if($1 == "main"){
			$$ = "int main(int argc, char *argv[]){\n" + $11 + "\n}\n";
		}else{
	$$ = std::string("\n void ") + "_" + $1 + "()" + "{\n" + $11 + "\n}\n";
		}
	}
	|
	%empty		{ $$ = ""; }
	;

statements:
	statements statement {
		$$ = $1 + $2;
				}
        |
	%empty	{ $$ = ""; }
         ;

statement:
	bifurcation { $$ = $1; }
	|
	loop { $$ = $1; }
	|
	assignment SEMICOLON	{ $$ = $1; }
	|
	unitaryOperations SEMICOLON	{ $$ = $1; }
	|
	std_input SEMICOLON	{ $$ = $1; }
	|
	definition SEMICOLON	{ $$ = $1; }
	|
	std_output SEMICOLON	{ $$ = $1; }
	|
	MULTILINECOMMENT	{ $$ = ""; }
	|
	SINGLECOMMENT	{ $$ = ""; }
	|
	expression SEMICOLON { $$ = $1; }
	;

bifurcation:

	CORCH_IZQ logical_eval CORCH_DERECHO QUESTION_MARK statement 
	{ $$ = "if(" + $2 + "){\n" + $5 + "}\n"; }
	|
	CORCH_IZQ logical_eval CORCH_DERECHO QUESTION_MARK LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE 
	{ $$ = "if(" + $2 + "){\n" + $6 + "}\n"; }
	|
	ELSE LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE 
	{ $$ = "else{\n" + $3 + "\n}\n";}
	|
	CORCH_IZQ logical_eval CORCH_DERECHO ELSE QUESTION_MARK LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE 
	{ $$ = "else if(" + $2 + "){\n" + $7 + "}\n"; }
	;

loop:
	CORCH_IZQ name COLON DOLLAR_SIGN name DOB_SLASH_IN DOLLAR_SIGN name comp_operator integer_value DOB_SLASH_IN
	name COLON DOLLAR_SIGN name LES integer_value CORCH_DERECHO WHILE LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE
	{ $$ = "for(int " + $2 + "=" + $5 +  ";" 
	+ $8 + $9 + $10 + ";" + $12 + "=" + $15 + "-" + $17 + "){\n" + $21 + "}\n"; }
	|
	CORCH_IZQ logical_eval CORCH_DERECHO WHILE LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE
	{ $$ = "while(" + $2 + "){\n" + $6 +"}\n"; }
	|
	CORCH_IZQ name COLON integer_value DOB_SLASH_IN DOLLAR_SIGN name comp_operator integer_value DOB_SLASH_IN name COLON DOLLAR_SIGN
	name ADD integer_value CORCH_DERECHO WHILE LEFT_CURLY_BRACE
	statements RIGHT_CURLY_BRACE
	{$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $9 +";" + $11 + "=" + $14 + "+" + $16 + "){\n" + $20 + "}\n"; }
	|
	CORCH_IZQ name COLON integer_value DOB_SLASH_IN DOLLAR_SIGN name comp_operator integer_value 
	DOB_SLASH_IN name COLON DOLLAR_SIGN name LES integer_value CORCH_DERECHO WHILE LEFT_CURLY_BRACE
	statements RIGHT_CURLY_BRACE
	{$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $9 +";" + $11 + "=" + $14 + "-" + $16 + "){\n" + $20 + "}\n"; }
	|
	CORCH_IZQ name COLON integer_value DOB_SLASH_IN DOLLAR_SIGN name comp_operator 
	DOLLAR_SIGN name DOB_SLASH_IN name COLON DOLLAR_SIGN name ADD integer_value CORCH_DERECHO WHILE LEFT_CURLY_BRACE
	statements RIGHT_CURLY_BRACE
	{$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $10 +";" + $12 + "=" + $15 + "+" + $17 + "){\n" + $21 + "}\n"; }
	|
	CORCH_IZQ name COLON integer_value DOB_SLASH_IN DOLLAR_SIGN name comp_operator 
	DOLLAR_SIGN name DOB_SLASH_IN name COLON DOLLAR_SIGN name LES integer_value CORCH_DERECHO WHILE LEFT_CURLY_BRACE
	statements RIGHT_CURLY_BRACE
	{$$ = "for(int " + $2 + "=" + $4 +  ";" + $7 + $8 + $10 +";" + $12 + "=" + $15 + "-" + $17 + "){\n" + $21 + "}\n"; }
	|
	CORCH_IZQ name COLON DOLLAR_SIGN name DOB_SLASH_IN DOLLAR_SIGN name comp_operator 
	integer_value DOB_SLASH_IN name COLON DOLLAR_SIGN name ADD integer_value CORCH_DERECHO WHILE LEFT_CURLY_BRACE
	statements RIGHT_CURLY_BRACE
	{ $$ = "for(int " + $2 + "=" + $5 +  ";" + $8 + $9 + $10 + ";" + $12 + "=" + $15 + "+" + $17 + "){\n" + $21 + "}\n"; }
	;
logical_eval:

	DOLLAR_SIGN name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO comp_operator DOLLAR_SIGN name
	{ $$ = $2 + "[" + $5 + "]" + $7 + $9; }
	|
	DOLLAR_SIGN name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO comp_operator DOLLAR_SIGN name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO
	{ $$ = $2 + "[" + $5 + "]" + $7 + $9 + "[" + $12 + "]"; }
	|
	DOLLAR_SIGN name comp_operator integer_value { $$ = $2 + $3 + $4; }
	|
	integer_value comp_operator integer_value { $$ = $1 + $2 + $3; }
	|
	DOLLAR_SIGN name comp_operator DOLLAR_SIGN name { $$ = $2 + $3 + $5; }
	;

comp_operator:
	EQ	{ $$ = "=="; }
	|
	LE	{ $$ = "<="; }
	|
	LT	{ $$ = "<"; }
	|
	GT	{ $$ = ">"; }
	|
	GE	{ $$ = ">="; }
	|
	NE	{ $$ = "!="; }
	;

assignment:

	name COLON DOLLAR_SIGN name SLASH decimal_value { $$ = $1 + "=" + "(float)" + $4 + "/" + $6 + ";\n"; }
	|
	name COLON CORCH_IZQ integer_value COMA integer_value CORCH_DERECHO { $$ = $1 + "[" + $4 + "]" + "=" + $6 + ";\n"; }
	|
	name COLON CORCH_IZQ DOLLAR_SIGN name COMA DOLLAR_SIGN name CORCH_DERECHO { $$ = $1 + "[" + $5 + "]" + "=" + $8 + ";\n"; }
	|
	name COLON CORCH_IZQ integer_value COMA DOLLAR_SIGN name CORCH_DERECHO { $$ = $1 + "[" + $4 + "]" + "=" + $7 + ";\n"; }
	|
	name COLON CORCH_IZQ DOLLAR_SIGN name COMA integer_value CORCH_DERECHO { $$ = $1 + "[" + $5 + "]" + "=" + $7 + ";\n"; }
	|
	name COLON DOLLAR_SIGN name CORCH_IZQ integer_value CORCH_DERECHO { $$ = $1 + "=" + $4 + "[" + $6 + "]" + ";\n"; }
	|
	name COLON DOLLAR_SIGN name CORCH_IZQ DOLLAR_SIGN ids CORCH_DERECHO { $$ = $1 + "=" + $4 + "[" + $7 + "]" + ";\n"; }
	|
	name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO COLON DOLLAR_SIGN name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO
	{ $$ = $1 + "[" + $4 + "]" + "=" + $8 + "[" + $11 + "]" + ";\n"; }
	|
	name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO COLON DOLLAR_SIGN name
	{ $$ = $1 + "[" + $4 + "]" + "=" + $8 + ";\n"; }
	|
	name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO COLON integer_value
	{ $$ = $1 + "[" + $4 + "]" + "=" + $7 + ";\n"; }
	|
	name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO INC integer_value
	{ $$ = $1 + "[" + $4 + "]" + "+=" + $7 + ";\n"; }
	|
	name INC DOLLAR_SIGN name CORCH_IZQ DOLLAR_SIGN name CORCH_DERECHO
	{ $$ = $1 + "+=" + $4 + "[" + $7 + "]" + ";\n"; }
	|
	name COLON FALSE  { $$ = $1 + "=false; \n"; }
	|
	name COLON TRUE  { $$ = $1 + "=true; \n"; }
	|
	name COLON integer_value { $$ = $1 + "=" + $3 + ";\n";}
	|
	name COLON decimal_value { $$ = $1 + "=" + $3 + ";\n";}
	|
	name COLON characters_block {$$ = $1 + "=" + $3 + ";\n";}
	|
	name INC integer_value { $$ = $1 + "+=" + $3 + ";\n";}
	|
	name DEC integer_value { $$ = $1 + "-=" + $3 + ";\n";}
	|
	name COLON DOLLAR_SIGN name { $$ = $1 + "=" + $4 + ";\n";}
	|
	name COLON DOLLAR_SIGN name ADD integer_value { $$ = $1 + "=" + $4 + "+" + $6 + ";\n";}
	|
	name COLON DOLLAR_SIGN name LES integer_value { $$ = $1 + "=" + $4 + "-" + $6 + ";\n";}
	;

integer_value:
	INTEGER_VALUE { $$ = std::string(yytext); }
	;

decimal_value:
	DECIMAL_VALUE { $$ = std::string(yytext); }
	;

unitaryOperations:
	INC identifiers { $$ = $2 + "++;\n";}
	|
	DEC identifiers { $$ = $2 + "--;\n";}
	;

std_input:
	LOAD COLON name { $$ = "\t std::cin >> " + $3 + ";\n"; }
	;

definition:
	name COLON INT CORCH_IZQ integer_value CORCH_DERECHO {

		$$ = "int " + $1 + "[" + $5 + "];\n";

	}
	|
	name COLON INT CORCH_IZQ DOLLAR_SIGN ids CORCH_DERECHO {

	$$ = "int " + $1 + "[" + $6 + "];\n"; }
	|
	name DOBLE_COLON BLN { $$ = "\t bool " + $1 + ";\n"; }
	|
	name DOBLE_COLON INT { $$ = "\t int " + $1 + ";\n"; }
	|
	ids COMA ids COMA ids COLON INT { $$ = "\t int " + $1 + "," + $3 + "," + $5 + ";\n"; }
	|
	name DOBLE_COLON STR { $$ = "\t string " + $1 + ";\n";}
	|
	name DOBLE_COLON DECIMAL { $$ = "\t float " + $1 + ";\n";}
	;

identifiers:
	identifiers ids { $$ = $1 + $2; }
	|
	%empty	{ $$ = ""; }
	;

ids:
	name	{ $$ = $1; }
	;

std_output:
	SIMP COLON characters_block	{ $$ = "std::cout << " + $3 + ";"; }
	|
	SHOW COLON NTOL DOLLAR_SIGN name	{ $$ = "std::cout << ((" + $5 + "==1) ? \"true\" : \"false\") << std::endl;";}
	|
	SHOW COLON characters_block	{ $$ = "std::cout << " + $3 + " << std::endl;\n"; }
	|
	SHOW COLON DOLLAR_SIGN name	{ $$ = "std::cout << " + $4 + " << std::endl;"; }
	|
	SHOW COLON characters_block COMA DOLLAR_SIGN name { $$ = "std::cout << " + $3 + " << " + $6 + " << std::endl;"; }
	|
	SHOW COLON characters_block COMA DOLLAR_SIGN name COMA characters_block{ $$ = "std::cout << " + $3 + " << " + $6 + " << " + $8 + " << std::endl;"; }
	|
	SHOW COLON DOLLAR_SIGN ids COMA integer_value { $$ = "std::cout << " + $4 + "[" + $6 + "]  << std::endl;\n"; }
	|
	SHOW COLON DOLLAR_SIGN ids COMA DOLLAR_SIGN ids { $$ = "std::cout << " + $4 + "[" + $7 + "]  << std::endl;\n"; }
	;

expression:
	name LEFT_PARENTHESIS RIGHT_PARENTHESIS { $$ = std::string("\t _") + $1 + "();\n"; }
	;

characters_block:
	CHARACTERS_BLOCK { $$ = std::string(yytext); }
	;

name:
	NAME	{
			$$ = std::string(yytext);
		}
	;

%%

void yyerror (char const *x){
	printf ("Error %s \n", x);
	exit(1);
}

