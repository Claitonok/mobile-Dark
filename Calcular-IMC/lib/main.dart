// ignore_for_file: library_private_types_in_public_api
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
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturalinaController = TextEditingController();

  // Variável para o controle do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variável para receber o texto a ser apresentado ao usuário
  String _resultado = '';

  // Método para limpar todos os valores da tela (inputs e resultado)
  void _reset() {
    setState(() {
      _formKey = GlobalKey<FormState>();
      pesoController.text = ''; // limpando pela atribuição
      alturalinaController.clear(); // limpando pelo método
      _resultado = '';
    });
  }

  void _calcularImc() {
    // parse é a conversão de tipos de dados
    double peso = double.parse(pesoController.text.replaceAll(',', '.'));
    double altura =
        double.parse(alturalinaController.text.replaceAll(',', '.'));
    double IMC = peso / (altura * altura);

    setState(() {
      if (IMC < 18.5) {
        _resultado = 'Abaixo do peso';
      } else if (IMC <= 18.5 && IMC <= 24.9) {
        _resultado = 'Peso normal';
      } else if (IMC <= 25.0 && IMC <= 29.9) {
        _resultado = 'Sobrepeso';
      } else if (IMC <= 30.0 && IMC <= 34.9) {
        _resultado = 'Obesidade grau 1';
      } else if (IMC <= 35.0 && IMC <= 39.9) {
        _resultado = 'Obesidade grau 2';
      } else if (IMC <= 35.0 && IMC <= 39.9) {
        _resultado = 'Obesidade grau 3';
      }
      // deixando mais profissional (operador ternário)
      // (condição lógica) ? true:false;
      //_resultado =
      //  (proporcao < 0.7 ? 'Abasteça com Álcool' : 'Abasteça com Gasolina');
    });
  }

  // Monta a interface com o usuário
  Widget build(BuildContext context) {
    return Scaffold(
      // criar a barra superior da aplicação
      appBar: AppBar(
        title: const Text(
          'Calculando IMC',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
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
                Icons.account_balance_wallet_outlined,
                size: 70,
              ),

              // Construcao do campos do formulario
              // Alcool
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Coloque seu Peso',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),

              //Gasolina
              TextFormField(
                controller: alturalinaController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Coloque sua altura',
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
                        _calcularImc();
                      }
                    },
                    fillColor: Colors.lightBlue[900],
                    child: const Text(
                      'Calcular',
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
