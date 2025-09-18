import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  //atributos
  final _db = FirebaseFirestore.instance;//controler para enviar tarefas para o bando de dados firestore
  final User? _user = FirebaseAuth.instance.currentUser;// pega o usuário logado
  final _tarefasField = TextEditingController(); // pegar o título da tarefa

  // método para adicionar tarefa 
  void _addTarefa() async{
    if(_tarefasField.text.trim().isEmpty && _user ==null) return;
    //adicionar a tarefa no banco de dados
    try {
      await _db.collection("usuarios")
      .doc(_user!.uid)
      .collection("tarefas")
      .add({
        "titulo": _tarefasField.text.trim(),
        "concluida": false,
        "dataCriacao": Timestamp.now()
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao adicionar tarefa: $e"))
      );      
    }
  }

  //método para atualizar status da tareda

  //metodo para deletar tarefa
  void _deleteTarefa(String id){}

  //build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut, 
            icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16), 
      child: Column(
        children: [
          TextField(
            controller: _tarefasField,
            decoration: InputDecoration(
              labelText: "Nova Tarefa",
              border: OutlineInputBorder(),
              suffix: IconButton(
                onPressed: _addTarefa, 
                icon: Icon(Icons.add))
            ),
          ),
          SizedBox(height: 20,),
          Expanded(child: StreamBuilder<QuerySnapshot>( //armazena o resultado da consulta e exibe na tela
            stream: _db.collection("usuarios")
            .doc(_user?.uid)
            .collection("tarefas")
            .orderBy("dataCriacao", descending: true)
            .snapshots(), 
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                return Center(child: Text("Nenhuma Tarefa Encontrada"));
              }
              final tarefas = snapshot.data!.docs;
              return ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index){
                  final tarefa = tarefas[index];
                  final tarefaData = tarefa.data() as Map<String, dynamic>;
                  bool concluida = tarefaData["concluida"] ?? false;
                  return ListTile(
                    title: Text(tarefaData["titulo"]),
                    leading: Checkbox(
                      value: concluida, 
                      onChanged: (value){
                        setState(() {
                          concluida = !concluida;
                          //atualiazar no banco de dados
                        });
                      }),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTarefa(tarefa.id),
                    ),
                  );

                });
              
            }),
          )

        ],
      ),),
    );
  }
}