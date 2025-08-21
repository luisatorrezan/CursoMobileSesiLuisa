import 'package:biblioteca_app/models/users_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UserController {
  //métodos
  //GET dos usuários
  Future<List<UsersModel>> fetchAll() async {
    final list = await ApiService.getList("users?_sort=name");
    //retorna a lista de usuário convertida para user model
    return list.map<UsersModel>((item)=>UsersModel.fromJson(item)).toList();
  }

  //POST -> criar novo usuário
  Future<UsersModel> create(UsersModel u) async{
    final created = await ApiService.post("users", u.toJson());
    //adiciona um usuário e retorna o usuário criado
    return UsersModel.fromJson(created);
  }

  //GET -> buscar um usuário
  Future<UsersModel> fetchOne(String id) async{
    final user = await ApiService.getOne("users", id);
    //retorna o usuário encontrado no banco de dados
    return UsersModel.fromJson(user);
  }

  //PUT -> autalizar usuário
  Future<UsersModel> upDate(UsersModel u) async{
    final updated = await ApiService.put("users", u.toJson(), u.id!);
    //retorna o usuário atualizado
    return UsersModel.fromJson(updated);
  }

  Future<void> delete(String id) async{
    await ApiService.delete("users", id);
    //não há retorno, usuário deletado com sucesso
  }
}