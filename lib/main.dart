import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark()
        .copyWith(scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)),
    debugShowCheckedModeBanner: false,
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  double _peso = 0;
  double _altura = 0;
  String _info = "Informe seus dados.";
  List<String> historico = [];

  void _resetFields() {
    setState(() {
      _info = "Informe seus dados.";
      _peso = 0;
      _altura = 0;
    });
  }

  void _calcular() {
    setState(() {
      double imc = (_peso / (_altura * _altura));
      String resultado = "";

      if (imc < 18.6) {
        resultado = 'Abaixo do Peso ($imc)';
      } else if (imc >= 18.6 && imc < 24.9) {
        resultado = 'Peso Ideal (${imc.toStringAsFixed(1)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        resultado = 'Levemente Acima do Peso (${imc.toStringAsFixed(1)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        resultado = 'Obesidade Grau I (${imc.toStringAsFixed(1)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        resultado = 'Obesidade Grau II (${imc.toStringAsFixed(1)})';
      } else if (imc >= 40) {
        resultado = 'Obesidade Grau III (${imc.toStringAsFixed(1)})';
      }

      _info = resultado;
      historico.add(resultado);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora IMC"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    onChanged: (value) {
                      setState(() {
                        _peso = double.parse(value);
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Altura (m)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    onChanged: (value) {
                      setState(() {
                        _altura = double.parse(value);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      if (_peso > 0 && _altura > 0) {
                        _calcular();
                      }
                    },
                    child: const Text('Calcular',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Histórico",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: historico.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(historico[index]),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        text: 'Desenvolvido por Suami Rocha 🤍',
                        style: const TextStyle(color: Colors.deepPurple),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString('https://suamirocha.com.br/');
                          })
                  ])))
                ])));
  }
}
