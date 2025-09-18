//classe modelo de filmes 
class Movie {
  //atributos
  final int id; //id do filme no tmdb
  final String title; //titulo do filme
  final String posterPath; //caminho do poster
  
  double rating; //nota que o usuário dará ao filme (0 a 5)

  //construtor
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });

  //método para converter o objeto em um mapa (para salvar no banco de dados)
  //toMap -> converte o objeto em um mapa
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  //método para criar um objeto a partir de um mapa (para ler do banco de dados)
  //fromMap -> cria um objeto a partir de um mapa
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie (
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"]);
  }
}