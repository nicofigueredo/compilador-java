import Analizadores.AnalizadorLexico;
import Analizadores.AnalizadorSintactico;

import java.io.FileNotFoundException;
import java.io.FileReader;

public class Main {
    public static void main(String[] args) {
        String fileName = "prueba.txt";
        try {
            @SuppressWarnings("deprecation") AnalizadorSintactico sintactico = new AnalizadorSintactico(new AnalizadorLexico(new FileReader(fileName)));
            sintactico.parse();
            System.out.println("Corrió " + fileName);
        } catch (FileNotFoundException e) {
            System.err.println("El archivo " + fileName + " no existe");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Hubo un error");
            e.printStackTrace();
        }
    }
}
