class UsersModel {
  //atributos
  final String? id; //pode ser nulo inicialmente
  final String name;
  final String email;

  //construtor
  UsersModel({
    this.id, 
    required this.name,
    required this.email
  });

  //método
  //toJson
  Map<String,dynamic> toJson() => {
    "id":id,
    "name":name,
    "email":email
  };

  //fromJson
  factory UsersModel.fromJson(Map<String,dynamic> json) => UsersModel(
    id: json["id"].toString(),
    name: json["name"].toString(), 
    email: json["email"].toString());
}