//formulário para adicionar novo pet

import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pets_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';

class AddPetScreen extends StatefulWidget{
  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen>{
  final _formKey = GlobalKey<FormState>(); //chave para o formulário
  final _petsController = PetsController();

  var _nome = "";
  final _raca = "";
  final _nomeDono = "";
  final _telefoneDono = "";

  Future<void> _salvarPet() async{
    if(_formKey.currentState!.validate()){
       _formKey.currentState!.save();
        final newPet = Pet(
        nome: _nome, 
        raca: _raca, 
        nomeDono: _nomeDono,
        telefoneDono: _telefoneDono);
    
      //mando para o banco
      await _petsController.addPet(newPet);
      Navigator.pop(context); //retorna para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Novo Pet"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nomde do Pet"),
                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _nome = value!,
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: "Nomde do Pet"),
                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _nome = value!,
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: "Nomde do Pet"),
                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _nome = value!,
              ),
              
              TextFormField(
                decoration: InputDecoration(labelText: "Nomde do Pet"),
                validator: (value) => value!.isEmpty ? "Campo não Preenchido!!!" : null,
                onSaved: (value) => _nome = value!,
              ),
            ],
          )),
        ),
    );
  }
}