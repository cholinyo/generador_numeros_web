import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(GeneradorWebApp());
}

class GeneradorWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: GeneradorNumerosAleatoriosWeb(),
    );
  }
}

class GeneradorNumerosAleatoriosWeb extends StatefulWidget {
  @override
  _GeneradorNumerosAleatoriosWebState createState() =>
      _GeneradorNumerosAleatoriosWebState();
}

class _GeneradorNumerosAleatoriosWebState
    extends State<GeneradorNumerosAleatoriosWeb> {
  final _inicioController = TextEditingController();
  final _finController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _semillaController = TextEditingController();
  String _resultado = '';

  void _generarNumeros() {
    try {
      int inicio = int.parse(_inicioController.text);
      int fin = int.parse(_finController.text);
      int cantidad = int.parse(_cantidadController.text);
      int? semilla = _semillaController.text.isNotEmpty
          ? int.parse(_semillaController.text)
          : null;

      if (cantidad > (fin - inicio + 1)) {
        setState(() {
          _resultado = 'Error: La cantidad no puede ser mayor que el intervalo.';
        });
        return;
      }

      Random random = semilla != null ? Random(semilla) : Random();
      Set<int> numeros = {};

      while (numeros.length < cantidad) {
        numeros.add(random.nextInt(fin - inicio + 1) + inicio);
      }

      setState(() {
        _resultado = numeros.join(', ');
      });
    } catch (e) {
      setState(() {
        _resultado = 'Por favor, introduce valores válidos.';
      });
    }
  }

  void _generarSemillaAleatoria() {
    setState(() {
      _semillaController.text = Random().nextInt(100000).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Números Aleatorios Web'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _inicioController,
              decoration: InputDecoration(
                labelText: 'Límite inferior (Inicio)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _finController,
              decoration: InputDecoration(
                labelText: 'Límite superior (Fin)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _cantidadController,
              decoration: InputDecoration(
                labelText: 'Cantidad de números',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _semillaController,
                    decoration: InputDecoration(
                      labelText: 'Semilla (opcional)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _generarSemillaAleatoria,
                  child: Text('Generar Semilla'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _generarNumeros,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text('Generar Números'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _resultado,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
