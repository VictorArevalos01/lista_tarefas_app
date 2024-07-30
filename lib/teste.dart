import 'package:flutter/material.dart';



class MyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: Center(
            child: ElevatedButton(
            onPressed: () {
        // Cria a SnackBar
        final snackBar = SnackBar(
        content: Text('Olá, SnackBar!'),
    action: SnackBarAction(
    label: 'Desfazer',
    onPressed: () {
    // Ação quando o botão Desfazer é pressionado
    },
    ),
    );

    // Exibe a SnackBar usando o ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Text('Mostrar SnackBar'), ),
        ),
    );
  }
}
