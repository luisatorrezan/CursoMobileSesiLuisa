import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget{
  //atributos
  final bool temaEscuro;
  final String nomeUsuario;
  final Function(bool, String) onSalvar;

  //construtor
  ConfigPage({
    required this.temaEscuro, required this.nomeUsuario, required this.onSalvar
  });

  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage>{
  //atributos
  //late -> inicialmente null -> vai receber um valor depois
  late bool _temaEscuro;
  //campos de formulários
  late TextEditingController _nomeController;

  @override
  void initState() {
    super.initState();
    //atribui o valor string/json
    _temaEscuro = widget.temaEscuro;
    _nomeController = TextEditingController(text: widget.nomeUsuario);
  }

  //método para salvar as configurações do usuário
  void salvarConfiguracoes() async{
    Map<String,dynamic> config = {
      "temaEscuro": _temaEscuro,
      "nome": _nomeController.text.trim()
    };
    //chama o shared preferences 
    //converte o map => string/json
    //salva o valor no sharedpreferences para a chave "config"
    final prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(config);
    prefs.setString("config", jsonString);

    //chama a atualização
    widget.onSalvar(_temaEscuro,_nomeController.text.trim());
  }

  //construção dos widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preferências do Usuário"),),
      body: Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: _temaEscuro, 
              onChanged: (bool value){
                setState(() {
                  _temaEscuro = value;
                });
              }),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome do Usuário"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async{
                salvarConfiguracoes();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Preferências Salvas")));
              },
              child: Text("Salvar Preferências")),
            SizedBox(height: 40,),
            Divider(),
            Text("Resumo Atual:",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text("Tema: ${_temaEscuro ? "Escuro" : "claro"}"),
            Text("Usuário: ${_nomeController.text}")
          ],
        ),
      ),
    );
  }
}