import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //foto de perfil
              Center(
                child: CircleAvatar(
                radius: 50,
                ),
              ),
              SizedBox(height: 20),

              //estrelas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                    Icons.star,
                    

                    color: Colors.yellow,
                  ),
                ],
              ),
              SizedBox(height: 10),

              //nome
              Text(
                'Luisa Torrezan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),

              //localização
              Text(
                'Londres, Inglaterra',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 20,),
            ]
          ),
        ),
      ),
    );
  }
}
