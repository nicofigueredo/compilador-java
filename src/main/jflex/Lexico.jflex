package Analizadores;
import java_cup.runtime.*;

%%      /* Directivas */
%public
%class AnalizadorLexico
%cupsym Simbolos
%cup
%column
%line
%ignorecase
%unicode

        /* Codigo del usuario en java */

%{
    private Symbol symbol(int type) {
        //System.out.println("[LEX] TOKEN < " + Simbolos.terminalNames[type] + " > : " + yytext());
        return new Symbol(type, yyline, yycolumn, yytext());
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

<YYINITIAL> "="	        { return symbol(Simbolos.op_asig); }

<YYINITIAL> "+"			{ return symbol(Simbolos.op_suma); }
<YYINITIAL> "-"			{ return symbol(Simbolos.op_resta); }
<YYINITIAL> "*"			{ return symbol(Simbolos.op_mul); }
<YYINITIAL> "/"			{ return symbol(Simbolos.op_div); }


<YYINITIAL> {ID}        { return symbol(Simbolos.id); }

<YYINITIAL> {CONST_INT} {
            Integer constInt = Integer.parseInt(yytext());
            if(constInt >= 0 && constInt <= 65535) return symbol(Simbolos.const_int);
            else throw new Error("La constante <" + yytext() + "> esta fuera del limite de los enteros");
      }

<YYINITIAL> {CONST_FLOAT} {
            Double constFloat = Double.parseDouble(yytext());
            if( constFloat >= 0 && constFloat <= 2147483647) return symbol(Simbolos.const_float);
            else throw new Error("La constante <" + yytext() + "> esta fuera del limite de los flotantes");
      }

<YYINITIAL> {CONST_STR} {
            String constStr = yytext();
            if(constStr.length() <= 32) return symbol(Simbolos.const_str);
            else throw new Error("La constante <" + yytext() + "> esta fuera del limite de los string");
      }


<YYINITIAL> {COMENTARIO}  {/* Ignora comentario */}

[\ \t\r\n\f]              {/* Ignora espacios en blanco */}


[^]    { throw new Error("Error: Caracter invalido " + yytext() + " " + yyline + ":" + yycolumn ); }