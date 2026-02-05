import 'package:flutter/material.dart';

class BotonCustom extends StatelessWidget {
  final String texto;
  final Function(String) alPresionar;

  const BotonCustom({
    super.key, 
    required this.texto, 
    required this.alPresionar
  });

  @override
  Widget build(BuildContext context) {
    // los operadores de otro color
    bool esOperador = ['+', '-', '*', '/', '=', '(', ')'].contains(texto);
    bool esBorrar = texto == 'C';

    return ElevatedButton(
      onPressed: () => alPresionar(texto),
      style: ElevatedButton.styleFrom(
        backgroundColor: esOperador 
            ? const Color.fromARGB(255, 13, 32, 72) 
            : (esBorrar ? Colors.red[300] : const Color.fromARGB(255, 187, 209, 220)),
        foregroundColor: esOperador ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }
}