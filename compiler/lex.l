%option noyywrap
%{
	#include "grammar.tab.h"
%}

COLONG [:]
DIGIT -?[0-9]
ALPHA [a-zA-Z]
CHARACTERS_BLOCK {QUOTES}({DOT}*{COLONG}*{ALPHA}*{WHITESPACE}*{DIGIT}*)+{QUOTES}
NAME {ALPHA}([0-9]*{ALPHA}*)+
WHITESPACE [ \r\t\v\f]
LINEFEED \n
SINGLECOMMENT {MENOR}{PLUS}({DOT}*{WHITESPACE}*)+{LINEFEED}+{PLUS}{MAYOR}
MULTILINECOMMENT {MENOR}{PLUS}({DOT}*{WHITESPACE}*{LINEFEED}*)+{PLUS}{MAYOR}
DOT .
SLASH[/]
WILDCARD [*]
QUOTES [\"]
MENOR [<]
MAYOR [>]
PLUS [+]
MINUS [-]

%%

"/"			{ return SLASH; }
"\\"			{ return DOB_SLASH_IN; }
"["			{ return CORCH_IZQ; }
"]"			{ return CORCH_DERECHO; }
"?"			{ return QUESTION_MARK; }
"|"			{ return ELSE;}
"="			{ return EQ; }
"<="			{ return LE; }
"<"			{ return LT; }
">"			{ return GT; }
">="			{ return GE; }
"!="			{ return NE; }
"itob"			{ return NTOL; }
"+:"			{ return INC; }
"-:"			{ return DEC; }
"load"			{ return LOAD; }
"simp"			{ return SIMP; }
"show"			{ return SHOW; }
"Int"			{ return INT; }
"Bln"			{ return BLN; }
"Str"			{ return STR; }
"Dec"			{ return DECIMAL; }
"tru"			{ return TRUE; }
"fls"			{ return FALSE; }
"answer:0;"		{ return ANSWER; }
{DIGIT}+		{ return INTEGER_VALUE; }
{DIGIT}+{DOT}{DIGIT}+	{ return DECIMAL_VALUE; }
{NAME}			{ return NAME;}
{CHARACTERS_BLOCK}	{ return CHARACTERS_BLOCK; }
{QUOTES}		{ return QUOTES; }
{SINGLECOMMENT}		{ return SINGLECOMMENT; }
{MULTILINECOMMENT}	{ return MULTILINECOMMENT; }
":"			{ return COLON; }
"::"			{ return DOBLE_COLON; }
";"			{ return SEMICOLON; }
"->"			{ return RIGHT_ARROW; }
"{"			{ return LEFT_CURLY_BRACE; }
"}"			{ return RIGHT_CURLY_BRACE; }
"("			{ return LEFT_PARENTHESIS; }
")"			{ return RIGHT_PARENTHESIS; }
"$"			{ return DOLLAR_SIGN; }
","			{ return COMA; }
"@"			{ return WHILE; }
"+"			{ return ADD; }
"-"			{ return LES; }
{WHITESPACE}
{LINEFEED}		++yylineno;

%%

#include <stdio.h>

