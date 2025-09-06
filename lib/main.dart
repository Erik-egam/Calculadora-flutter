import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aqui mostramos la app
    return MaterialApp(
      title: 'Calculadora Demo',
      // Definimos el tema de la aplicacion
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Elegimos la vista que va a usar nuestra aplicacion
      home: const Calculadora(title: 'Calculadora'),
    );
  }
}
// Aqui desarrollamos la logica y los componentes de nuestra vista
class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});

  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {

  // Inicializamos las variables de nuestro contexto
  String resultadoPantalla = "0";
  int resultadoCalculo = 0;
  String operador = "";

  void _numeroPresionado(String numeroElegido) {
    setState(() {
      if (numeroElegido != "" && "1234567890".contains(numeroElegido)) {
        if (resultadoPantalla == "0" || resultadoPantalla == "Error") {
          resultadoPantalla = numeroElegido;
        } else {
          resultadoPantalla += numeroElegido;
        }
      }
    });
  }

  void _operadorPresionado(String operadorElegido) {
    setState(() {
      if (resultadoPantalla != "0") {
        resultadoCalculo = int.parse(resultadoPantalla);
        resultadoPantalla = "0";
        operador = operadorElegido;
      }
    });
  }

  void _igualPresionado() {
    setState(() {
      switch (operador) {
        case "+":
          resultadoPantalla = (int.parse(resultadoPantalla) + resultadoCalculo)
              .toString();
          resultadoCalculo = 0;
          operador = "";
          break;
        case "-":
          resultadoPantalla = (resultadoCalculo - int.parse(resultadoPantalla))
              .toString();
          resultadoCalculo = 0;
          operador = "";
          break;
        case "*":
          resultadoPantalla = (int.parse(resultadoPantalla) * resultadoCalculo)
              .toString();
          resultadoCalculo = 0;
          operador = "";
          break;
        case "/":
          if (resultadoPantalla != "0") {
            resultadoPantalla =
                (int.parse(resultadoPantalla) / resultadoCalculo).toString();
            resultadoCalculo = 0;
            operador = "";
          } else {
            resultadoPantalla = "Error";
          }
          break;
      }
    });
  }

  void _limpiarPresionado() {
    setState(() {
      resultadoCalculo = 0;
      resultadoPantalla = "0";
      operador = "";
    });
  }

  Widget _botonNumero(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.grey[800],
          ),
          onPressed: () => _numeroPresionado(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _botonOperador(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.grey[800],
          ),
          onPressed: () => _operadorPresionado(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _botonIgual(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.grey[800],
          ),
          onPressed: () => _igualPresionado(),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _botonLimpiar(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.grey[800],
          ),
          onPressed: () => _limpiarPresionado(),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Pantalla
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(24),
            child: Text(
              resultadoPantalla,
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
          ),
          const Divider(color: Colors.white),
          // Botones
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _botonNumero("7"),
                    _botonNumero("8"),
                    _botonNumero("9"),
                    _botonOperador("/", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _botonNumero("4"),
                    _botonNumero("5"),
                    _botonNumero("6"),
                    _botonOperador("*", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _botonNumero("1"),
                    _botonNumero("2"),
                    _botonNumero("3"),
                    _botonOperador("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _botonNumero("0"),
                    _botonLimpiar("C", color: Colors.red),
                    _botonIgual("=", color: Colors.green),
                    _botonOperador("+", color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
