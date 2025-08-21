class BooksModel {
  //atributos
  final String? id;
  final String title;
  final String author;
  final bool avaliable;

  //construtor
  BooksModel({
    this.id,
    required this.title,
    required this.author,
    required this.avaliable,
  });

  //método
  //toJson
  Map<String,dynamic> toJson() => {
    "id":id,
    "title":title,
    "author":author,
    "avaliable":avaliable
  };

  //fromJson
  factory BooksModel.fromJson(Map<String,dynamic> json) => BooksModel(
    id: json["id"].toString(),
    title: json["title"].toString(), 
    author: json["author"].toString(), 
    avaliable: json["avaliable"]);

}