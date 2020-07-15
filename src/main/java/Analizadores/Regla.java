package Analizadores;

public enum Regla {

    REGLA_S       (0  , "S → PROG"),
    REGLA_PROG    (1  , "PROG → SENT"),
    REGLA_PROG2    (2  , "PROG → PROG SENT"),
    REGLA_SENT    (3  , "SENT → ASIG"),
    REGLA_ASIG    (4  , "id op_asig → EXPRESION"),
    REGLA_EXPRESION    (5  , "EXPRESION → TERMINO"),
    REGLA_EXPRESION2    (6  , "EXPRESION → EXPRESION op_suma TERMINO"),
    REGLA_EXPRESION3    (7  , "EXPRESION → EXPRESION op_resta TERMINO"),
    REGLA_TERMINO    (8  , "TERMINO → FACTOR"),
    REGLA_TERMINO2   (9  , "TERMINO → op_mul FACTOR"),
    REGLA_TERMINO3    (10  , "TERMINO → op_div FACTOR"),
    REGLA_FACTOR    (11  , "FACTOR → id"),
    REGLA_FACTOR2    (12  , "FACTOR → const_int"),
    REGLA_FACTOR3    (13  , "FACTOR → const_float");


    private final Integer numero;
    private final String regla;

    Regla(Integer numero, String regla) {
        this.numero = numero;
        this.regla = regla;
    }

    @Override
    public String toString() {
        return "[STX] RECONOCE REGLA " + this.numero + ". " + this.regla;
    }
}
