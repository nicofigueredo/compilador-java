SET JFLEX_JAR=".\lib\jflex\jflex-full-1.8.2.jar"
SET JCUP_JAR=".\lib\cup\java-cup-11b.jar"

SET LEXICO=".\src\main\jflex\Lexico.jflex"
SET SINTAXIS=".\src\main\cup\Sintaxis.cup"

SET ANALIZADORES_OUT=".\src\main\java\Analizadores"

java -jar %JFLEX_JAR% -d %ANALIZADORES_OUT% %LEXICO%
::pause

java -jar %JCUP_JAR% -destdir %ANALIZADORES_OUT% -package "Analizadores" -parser AnalizadorSintactico -symbols Simbolos %SINTAXIS%
::pause