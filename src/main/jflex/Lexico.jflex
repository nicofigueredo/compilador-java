import java_cup.runtime.*;

%%      /* Directivas */

%class AnalizadorLexico
%cupsym Simbolos
%cup
%column
%line
%ignorecase
%unicode

        /* Codigo del usuario en java */

%{
    StringBuffer string = new StringBuffer();
    private Symbol symbol(int type) {
      return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
      return new Symbol(type, yyline, yycolumn, value);
    }
%}

        /* Expresiones regulares */

DIGITO = [0-9]
LETRA = [a-zA-Z]

CARACTERES_ESPECIALES = [\@\$\_\~\\\,\%]
CARACTERES_NO_PERMITIDOS = [#\^\*\(\)\-\+\=\|\/\?\>\<\!\;\.\:\'\"\[\]\{\}]
CADENA = ({CARACTERES_ESPECIALES}|{CARACTERES_NO_PERMITIDOS}|{DIGITO}|{LETRA}|" "|"\t")

CONST_INT = {DIGITO}+
CONST_FLOAT =  {DIGITO}+"."{DIGITO}*
CONST_STR = "\""{CADENA}*"\""

ID = {LETRA}({LETRA}|{DIGITO}|_)*

COMENTARIO = "***/"{CADENA}*"/***"

%%      /* Reglas lexicas */

<YYINITIAL> "IF"	    { return symbol(Simbolos.IF); }
<YYINITIAL> "ELSE"	    { return symbol(Simbolos.ELSE); }
<YYINITIAL> "WHILE"	    { return symbol(Simbolos.WHILE); }
<YYINITIAL> "DEFVAR"    { return symbol(Simbolos.DEFVAR); }
<YYINITIAL> "ENDDEF"    { return symbol(Simbolos.ENDDEF); }
<YYINITIAL> "DISPLAY"   { return symbol(Simbolos.DISPLAY); }
<YYINITIAL> "GET"       { return symbol(Simbolos.GET); }

<YYINITIAL> "Integer"   { return symbol(Simbolos.TIPO_INTEGER); }
<YYINITIAL> "Float"     { return symbol(Simbolos.TIPO_FLOAT); }

<YYINITIAL> "="	        { return symbol(Simbolos.OP_ASIG); }
<YYINITIAL> "+="        { return symbol(Simbolos.OP_ASIG_SUM); }
<YYINITIAL> "-="        { return symbol(Simbolos.OP_ASIG_RES); }
<YYINITIAL> "*="        { return symbol(Simbolos.OP_ASIG_MUL); }
<YYINITIAL> "/="        { return symbol(Simbolos.OP_ASIG_DIV); }
<YYINITIAL> "+"			{ return symbol(Simbolos.OP_SUMA); }
<YYINITIAL> "-"			{ return symbol(Simbolos.OP_RESTA); }
<YYINITIAL> "*"			{ return symbol(Simbolos.OP_MUL); }
<YYINITIAL> "/"			{ return symbol(Simbolos.OP_DIV); }

<YYINITIAL> "<"         { return symbol(Simbolos.OP_MENOR); }
<YYINITIAL> "<="        { return symbol(Simbolos.OP_MENOR_IGUAL); }
<YYINITIAL> ">"         { return symbol(Simbolos.OP_MAYOR); }
<YYINITIAL> ">="        { return symbol(Simbolos.OP_MAYOR_IGUAL); }
<YYINITIAL> "=="        { return symbol(Simbolos.OP_IGUAL); }
<YYINITIAL> "!="        { return symbol(Simbolos.OP_DISTINTO); }

<YYINITIAL> "("			{ return symbol(Simbolos.P_A); }
<YYINITIAL> ")"			{ return symbol(Simbolos.P_C); }
<YYINITIAL> "{"	        { return symbol(Simbolos.LL_A); }
<YYINITIAL> "}"	        { return symbol(Simbolos.LL_C); }
<YYINITIAL> ","         { return symbol(Simbolos.COMA); }
<YYINITIAL> ";"			{ return symbol(Simbolos.PUNTO_COMA); }
<YYINITIAL> ":"         { return symbol(Simbolos.DOS_PUNTOS); }

<YYINITIAL> "AND"       { return symbol(Simbolos.OP_AND); }
<YYINITIAL> "OR"        { return symbol(Simbolos.OP_OR); }
<YYINITIAL> "NOT"       { return symbol(Simbolos.OP_NOT); }


<YYINITIAL> {ID}        { return symbol(Simbolos.ID); }

<YYINITIAL> {CONST_INT} {
            Integer constInt = Integer.parseInt(yytext());
            if(constInt >= 0 && constInt <= 65535) return symbol(Simbolos.CONST_INT);
            else throw new Error("La constante <" + yytext() + "> esta fuera del limite de los enteros");
      }

<YYINITIAL> {CONST_FLOAT} {
            Double constFloat = Double.parseDouble(yytext());
            if( constFloat >= 0 && constFloat <= 2147483647) return symbol(Simbolos.CONST_FLOAT);
            else throw new Error("La constante <" + yytext() + "> esta fuera del limite de los flotantes");
      }

<YYINITIAL> {CONST_STR} {
            String constStr = yytext();
            if(constStr.length() <= 32) return symbol(Simbolos.CONST_STR);
            else throw new Error("La constante <" + yytext() + "> esta fuera del limite de los string");
      }


<YYINITIAL> {COMENTARIO}  {/* Ignora comentario */}

[\ \t\r\n\f]              {/* Ignora espacios en blanco */}


[^]    { throw new Error("Error: Caracter invalido " + yytext() + " " + yyline + ":" + yycolumn ); }