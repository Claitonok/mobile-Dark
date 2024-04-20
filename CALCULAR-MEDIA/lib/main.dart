// ignore_for_file: library_private_types_in_public_api
//import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  // função principal da aplicação
  runApp(const MaterialApp(
    home: Home(), // arquivo inicial da aplicação (rota)
    debugShowCheckedModeBanner: false,
  ));
}

// Configuração do ambiente
// stf -> Stateful
// stl -> Stateless
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// Controlar os estados da aplicação e,
// Construção da interface com o usuário
class _HomeState extends State<Home> {
  // herança
  @override // sobrescrita de método (usar algo existente)

  // Construindo a lógica da aplicação
  // Declaração dos objetos de entrada de dados (inputs)
  TextEditingController cursoController = TextEditingController();

  TextEditingController nota1Controller = TextEditingController();
  TextEditingController nota2Controller = TextEditingController();
  TextEditingController nota3Controller = TextEditingController();
  TextEditingController nota4Controller = TextEditingController();

  // Variável para o controle do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variável para receber o texto a ser apresentado ao usuário
  String _resultado = '';
  // Método para limpar todos os valores da tela (inputs e resultado)
  void _reset() {
    setState(() {
      _formKey = GlobalKey<FormState>();
      cursoController.text = ''; // limpando pela atribuição
      nota1Controller.clear(); // limpando pelo método
      nota2Controller.clear();
      nota3Controller.clear();
      nota4Controller.clear();

      _resultado = '';
    });
  }

  void _calcularMedia() {
    // parse é a conversão de tipos de dados
    String curso = cursoController.text;
    double nota1 = double.parse(nota1Controller.text.replaceAll(',', '.'));
    double nota2 = double.parse(nota2Controller.text.replaceAll(',', '.'));
    double nota3 = double.parse(nota3Controller.text.replaceAll(',', '.'));
    double nota4 = double.parse(nota4Controller.text.replaceAll(',', '.'));

    double curso1 = (nota1 + 3) / (nota2 + 4) / (nota3 + 5) / (nota4 + 2);
    double curso2 = (nota1 + 2) / (nota2 + 2) / (nota3 + 3) / (nota4 + 4);
    double curso3 = (nota1 + 4) / (nota2 + 4) / (nota3 + 5) / (nota4 + 3);
    double curso4 = (nota1 + 5) / (nota2 + 4) / (nota3 + 3) / (nota4 + 1);

    setState(() {
      switch (curso) {
        case 'a':
          if (curso1 >= 6) {
            _resultado = 'APROVADO';
          } else {
            _resultado = 'REPROVADO';
          }
          break;
        case 'b':
          if (curso2 >= 6) {
            _resultado = 'APROVADO';
          } else {
            _resultado = 'REPROVADO';
          }
          break;
        case 'c':
          if (curso3 >= 6) {
            _resultado = 'APROVADO';
          } else {
            _resultado = 'REPROVADO';
          }
          break;
        case 'd':
          if (curso4 >= 6) {
            _resultado = 'APROVADO';
          } else {
            _resultado = 'REPROVADO';
          }
          break;
        default:
          _resultado = 'PROGRAMA FINALIZADO';
      }
    });
  }

  // Monta a interface com o usuário
  Widget build(BuildContext context) {
    return Scaffold(
      // criar a barra superior da aplicação
      appBar: AppBar(
        title: const Text(
          'MEDIA PONDERADA',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff000000),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _reset();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      //criar o corpo da aplicação (campo do formulario)
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Form(
          key: _formKey, //indendifica o formulario(referencia)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // conjunto Widgets
              const Icon(
                Icons.media_bluetooth_off_outlined,
                size: 70,
              ),

              // Construcao do campos do formulario
              // Tipo do curso A,B,C,D
              TextFormField(
                controller: cursoController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'SELECIONE O CURSO A,B,C,D',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),

              //nota 1
              TextFormField(
                controller: nota1Controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'NOTA 01',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),

              //nota 2
              TextFormField(
                controller: nota2Controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'NOTA 02',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),

              //nota 3
              TextFormField(
                controller: nota3Controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'NOTA 03',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),
              //nota 4
              TextFormField(
                controller: nota4Controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'NOTA 04',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: SizedBox(
                  height: 50,
                  // botao  de calcular
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcularMedia();
                      }
                    },
                    fillColor: Color(0xff000000),
                    child: const Text(
                      'Calcular media',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Text(
                _resultado,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
