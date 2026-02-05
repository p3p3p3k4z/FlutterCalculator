import 'package:math_expressions/math_expressions.dart';

class CalculadoraLogic {
  static const List<String> operadores = ['+', '-', '*', '/'];

  static String calcular(String expresion) {
    try {
      String ultimo = expresion.substring(expresion.length - 1);
      if (operadores.contains(ultimo)) {
        return "Error"; 
      }

      Parser p = Parser();
      Expression exp = p.parse(expresion);
      ContextModel cm = ContextModel();
      
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite || eval.isNaN) {
        return "Error";
      }

      // quitamos el punto cero si es un numero entero
      if (eval % 1 == 0) {
        return eval.toInt().toString();
      }
      return eval.toString();

    } catch (e) {
      return "Error";
    }
  }

  static String procesarTecla(String actual, String tecla) {

    if (tecla == 'C') return '';

    if (tecla == '=') return calcular(actual);

    // validaciones de sintaxis para evitar errores al escribir
    if (actual.isEmpty) {
      // al inicio solo permitimos numeros parentesis o signo menos
      if (tecla == '-' || tecla == '(' || double.tryParse(tecla) != null) {
        return tecla;
      }
      return ''; 
    }

    String ultimoCaracter = actual.substring(actual.length - 1);
    bool esOperadorNuevo = operadores.contains(tecla);
    bool ultimoEsOperador = operadores.contains(ultimoCaracter);

    // si escribes un operador y ya habia uno lo reemplazamos
    if (esOperadorNuevo && ultimoEsOperador) {
      return actual.substring(0, actual.length - 1) + tecla;
    }
    
    // no permitir operador justo despues de abrir parentesis
    if (esOperadorNuevo && ultimoCaracter == '(') {
      return actual; 
    }

    return actual + tecla;
  }
}