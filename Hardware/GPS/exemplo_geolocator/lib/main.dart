// exemplo de uso do GPS

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}

// Exemplo de implementação simples do ClimaService
class ClimaService {
  Future<Map<String, dynamic>> getCityWeatherByPosition(String position) async {
    // Aqui você deve implementar a chamada real à API de clima usando a posição.
    // Este é apenas um exemplo de retorno simulado.
    return {
      "name": "Cidade Exemplo",
      "main": {
        "temp": 300, // Kelvin
      }
    };
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String mensagem = "";

  //método para pegar a localização dos dispositivo
  //verificar se a localização está çiberada para uso do app
  Future<String> getLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    //verificar se o serviço de localização está liberado no dispositivo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return "Serviço de Localização desabilitado";
    }
    //solicitar a liberação do serviço
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return "Permissão de Localização Negada";
      }
    }
    Position position = await Geolocator.getCurrentPosition();
      return "Latitude: ${position.latitude} - Longitude: ${position.longitude}";
  }
  
 Future<String> getLocationWeather() async{
  final position = await getLocation();

  final climaPosition = await ClimaService().getCityWeatherByPosition(position);

  return "${climaPosition["name"]} -- ${climaPosition["main"]["temp"] - 273} -- Sensação de: ${climaPosition["main"]["temp"]}";
 }
 
 
 @override
 void initState() {
    super.initState();
    //chamar o método ao iniciar a aplicação
    setState(() {
      mensagem = getLocation().toString();
    });
  }
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(
              onPressed: () async{
                String result = await getLocationWeather();
                setState(() {
                  mensagem = result;
                });
              },
              child: Text("Obter Localização"))
          ],
        ),
      ),
    );
  }
}