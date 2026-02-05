import 'package:flutter/material.dart';
import 'botones.dart';
import 'logica.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String display = '';

  // listas de botones separadas para vertical y horizontal
  final List<String> _botonesV = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
    '',
  ];

  final List<String> _botonesH = [
    '7',
    '8',
    '9',
    '/',
    'C',
    '4',
    '5',
    '6',
    '*',
    '(',
    '1',
    '2',
    '3',
    '-',
    ')',
    '0',
    '.',
    '=',
    '+',
    '',
  ];

  void presionarBoton(String valor) {
    if (valor == '') return;

    setState(() {
      display = CalculadoraLogic.procesarTecla(
        display,
        valor,
      ); //procesar el texto
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Calculadora")),

      // detector de orientacion para cambiar el diseño dinamicamente
      body: OrientationBuilder(
        builder: (context, orientation) {
          bool esHorizontal = orientation == Orientation.landscape;

          return Column(
            children: [
              // seccion de la pantalla de resultado
              Expanded(
                flex: esHorizontal ? 1 : 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  // permite scroll horizontal si el numero es muy largo
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      display.isEmpty ? '0' : display,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // seccion del teclado
              Expanded(
                flex: esHorizontal ? 2 : 6,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: esHorizontal
                        ? _botonesH.length
                        : _botonesV.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: esHorizontal ? 5 : 4,
                      mainAxisSpacing: esHorizontal ? 5 : 15,
                      crossAxisSpacing: esHorizontal ? 5 : 15,
                      childAspectRatio: esHorizontal ? 4 : 1.0,
                    ),
                    itemBuilder: (context, index) {
                      String texto = esHorizontal
                          ? _botonesH[index]
                          : _botonesV[index];

                      // si el texto es vacio mostramos un widget invisible
                      if (texto == '') return const SizedBox();

                      // usamos nuestro widget personalizado importado
                      return BotonCustom(
                        texto: texto,
                        alPresionar: presionarBoton,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

