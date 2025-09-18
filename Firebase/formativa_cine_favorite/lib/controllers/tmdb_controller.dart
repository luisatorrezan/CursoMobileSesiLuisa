//classe responsável por buscar as informações no TMDB e converter em objeto

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbController {
  //colocar os dados da API
  static const String _apiKey = "Colocar a chave Api";
  static const String _baseUrl = "https://api.themoviedb.org/3";

  //método para buscar filme com base no texto
  static Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    //http.get(baseUrl)
    final url = Uri.parse("$_baseUrl/search/movie?api_key=$_apiKey&query=$query");
    final response = await http.get(url); //requisição http
    //se resposta for ok ==200
    if (response.statusCode == 200) {
      final data = response.body; //corpo da resposta
      final list = jsonDecode(data)["results"]as List; //decodifica o json para lista de mapas 
      return List<Map<String, dynamic>>.from(list); //converte para lista de mapas
    //caso contrário crie uma exception 
    } else {
      throw Exception("Erro ao buscar filmes"); //lança exceção em caso de erro
    }
  }
}