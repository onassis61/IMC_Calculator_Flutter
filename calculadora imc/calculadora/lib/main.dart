import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //controllers que calculam o imc
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  String resultadoImc = '';
  //recalcula o imc sem necessicadade de resetar a aplicação.
  void _calcularIMC() {
  setState(() {
    if (controllerPeso.text.isNotEmpty && controllerAltura.text.isNotEmpty) {
      try {
        num peso = num.parse(controllerPeso.text);
        num altura = num.parse(controllerAltura.text);
        num imc = peso / (altura * altura);
        resultadoImc = imc.toStringAsFixed(2);
      } catch (e) {
        resultadoImc = 'Erro nos dados'; 
      }
    } else {
      resultadoImc = '';
    }
  });
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
        centerTitle: true,
      ),
      
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Calculadora de IMC',
              ),
              const SizedBox( height: 16),
              TextFormField(
                onChanged: (text) => _calcularIMC(),
                keyboardType: const TextInputType.numberWithOptions(),
                controller: controllerPeso,
                decoration: const InputDecoration(labelText: 'Peso:',
                  hintText: 'Digite o seu peso',border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))) )
              ),

             const SizedBox( height: 16),
              TextFormField(
                onChanged: (text) => _calcularIMC(),
                keyboardType: const TextInputType.numberWithOptions(),
                controller: controllerAltura,
                decoration: const InputDecoration(labelText: 'Altura:',
                  hintText: 'Digite a sua altura',
                border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))) )
              ),
              const SizedBox(height: 32,),
              Text(resultadoImc, style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              
              const SizedBox(height: 16,),
              Container(
                width: 200,
                child: ElevatedButton(onPressed: (){
                  //calculo do imc
                  num numAux = (num.parse(controllerPeso.text) / (num.parse(controllerAltura.text) * num.parse(controllerAltura.text)));
                  resultadoImc = numAux.toStringAsFixed(2);
                  debugPrint('cliquei aqui');
                },
                child: const Text('Calcular')),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (){
         setState(() {
           resultadoImc = '';
         }); 
        },
        child: const Text('Limpar Resultado'),
      ), 
    );
  }
}
