import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_petshop/controllers/consultas_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/screens/pet_detalhe_screen.dart';

class AddConsultaScreen extends StatefulWidget{
  final int petId; //recebe o pet id da tela anterior

  const AddConsultaScreen({super.key, required this.petId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddConsultaScreenState();
  }
}

class _AddConsultaScreenState extends State<AddConsultaScreen>{
  final _formKey = GlobalKey<FormState>();
  final ConsultasController _controllerConsultas = ConsultasController();

  String tipoServico="";
  String observacao="";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  //método para seleção da adata
  //método para seleção de hora

  //método para salvar consulta
  Future<void> _salvarConsulta() async{
    if(_formKey.currentState!.validate()){
      final DateTime finalDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute
      );
      //criar a consulta
      final newConsulta = Consulta(
        petId: widget.petId,
        dataHora: finalDateTime,
        tipoServico: tipoServico,
        observacao: observacao=="" ? null : observacao);
      _controllerConsultas.insertConsulta(newConsulta);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PetDetalheScreen(petId: widget.petId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat("dd/MM/yyyy");
    final DateFormat timeFormatter = DateFormat("HH:mm"); 
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Nova Consulta"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Tipo de Serviço"),
              validator: (value) => value!.isEmpty ? "Por Favor, insira um tipo de serviço":null,
              onSaved: (value) => tipoServico = value!,
            ),
            Row(
              children: [
                Expanded(child: Text("Data: ${dateFormatter.format(_selectedDate)}")),
                TextButton(onPressed: () => _selectedDate, child: Text("Selecionar Data")),
              ],
            ),
          Row(children: [
              Expanded(child: Text("Hora: ${timeFormatter.format(DateTime(0,0,0,_selectedTime.hour,_selectedTime.minute))}")),
              TextButton(onPressed: () => _selectedTime, child: Text("Selecionar Hora"))
            ],),
            TextFormField(
              decoration: InputDecoration(labelText: "Observação"),
              maxLines: 3,
              onSaved: (value) => observacao=value!,
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _salvarConsulta, child: Text("Agendar Consulta"))
          ],
        ),),
        ),
    );
  }
}

