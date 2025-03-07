import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

void main(){ //método principal para rodar aplicação
    runApp(MyApp()); //construtor da classe principal
}

class MyApp extends StatelessWidget{ //classe principal
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( //MaterialApp - contém os widgets Androids
      home: Scaffold( //Scaffold - tela de visualização básica
        appBar: AppBar(title: Text("Exemplo App Dependência")),
        body: Center(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Olá, Mundo!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
              },
              child: Text("Clique Aqui!"),
            ),
          ),
        ),
      ),
    );
  }
}