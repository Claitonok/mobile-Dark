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
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  // Variável para o controle do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variável para receber o texto a ser apresentado ao usuário
  String _resultado = '';

  // Método para limpar todos os valores da tela (inputs e resultado)
  void _reset() {
    setState(() {
      _formKey = GlobalKey<FormState>();
      alcoolController.text = ''; // limpando pela atribuição
      gasolinaController.clear(); // limpando pelo método
      _resultado = '';
    });
  }

  void _calcularCombustivel() {
    // parse é a conversão de tipos de dados
    double alcool = double.parse(alcoolController.text.replaceAll(',', '.'));
    double gasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = alcool / gasolina;

    setState(() {
      // if (proporcao < 0.7) {
      //   _resultado = 'Abasteça com Álcool';
      // } else {
      //   _resultado = 'Abasteça com Gasolina';
      // }

      // deixando mais profissional (operador ternário)
      // (condição lógica) ? true:false;
      _resultado =
          (proporcao < 0.7 ? 'Abasteça com Álcool' : 'Abasteça com Gasolina');
    });
  }

  // Monta a interface com o usuário
  Widget build(BuildContext context) {
    return Scaffold(
      // criar a barra superior da aplicação
      appBar: AppBar(
        title: const Text(
          'Gasolina ou Álcool?',
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
                Icons.local_gas_station,
                size: 70,
              ),

              // Construcao do campos do formulario
              // Alcool
              TextFormField(
                controller: alcoolController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Valor do litro do alcool',
                  labelStyle:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 15),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é Obrigatorio' : null,
              ),

              //Gasolina
              TextFormField(
                controller: gasolinaController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Valor do litro da gasolina',
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
                        _calcularCombustivel();
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
