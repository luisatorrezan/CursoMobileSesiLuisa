//exemplo de convert json

import 'dart:convert'; //biblioteca para o funcionamento do json

void main() {
  //texto em formato json
  String dbJson = ''' {
            "id":1,
            "nome": "João",
            "login": "joao_user",
            "ativo": true,
            "senha": 1234
                }''';

//convertendo texto json -> map dart
Map<String,dynamic> usuario = json.decode(dbJson);

print(usuario["login"]); //joao_user

//mudar a senha do usuario pra 1111

usuario["senha"] = 1111;

//fazer o encode -> map dart -> texto json

dbJson = json.encode(usuario);

//printar o json 

print(dbJson);
}