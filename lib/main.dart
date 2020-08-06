import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
      //_formKey.currentState.reset();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    String textTemp = "";

    if (imc < 18.6) {
      textTemp = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      textTemp = "Peso ideal (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      textTemp = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      textTemp = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      textTemp = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 40) {
      textTemp = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    }

    setState(() {
      _infoText = textTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.blue),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text("Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      color: Colors.blue,
                    ),
                  ),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25)),
              ],
            ),
          ),
        ));
  }
}
