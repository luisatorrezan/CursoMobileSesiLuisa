import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo Widget Exibição")),
        body: Center(
          child: Column(
            children: [
              Text("Um Texto Qualquer",
              style:TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              )
              ),
              Icon(Icons.star,
                size: 100,
                color: Colors.amber
              ) ,
              Image.network("https://logowik.com/content/uploads/images/flutter5786.jpg",
                width: 200,
                height: 200,
                fit: BoxFit.cover),
              Image.asset("assets/img/einsten.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover),             
            ],
          ),
        ),
      ),
    );
  }
}
