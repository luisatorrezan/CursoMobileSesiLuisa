class LoansModel {
  //atributos
  final String? id;
  final String userId;
  final String bookId;
  final String startDate;
  final String dueDate;
  final String returned;

  //construtor
  LoansModel({
    this.id,
    required this.userId,
    required this.bookId,
    required this.startDate,
    required this.dueDate,
    required this.returned
  });

  //métodos
  //toJson
  Map<String,dynamic> toJson() => {
    "id":id,
    "userId":userId,
    "bookId":bookId,
    "startDate":startDate,
    "dueDate":dueDate,
    "returned":returned
  };

  //fromJson
  factory LoansModel.fromJson(Map<String,dynamic> json) => LoansModel(
    id: json["id"].toString(),
    userId: json["userId"].toString(), 
    bookId: json["bookId"].toString(), 
    startDate: json["startDate"].toString(), 
    dueDate: json["dueDate"].toString(), 
    returned: json["returned"].toString());
}