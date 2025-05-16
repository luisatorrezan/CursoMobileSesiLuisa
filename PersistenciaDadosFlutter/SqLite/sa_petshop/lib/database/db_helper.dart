import 'dart:io';

import 'package:path/path.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';

class PetShopDBHelper{
  static Database? _database; //objeto para criar conexões 

  Future<Database> get database async{
    if(_database != null){
      return _database!; //se o banco ja existe, retorna ele mesmo
    }
    //se não existe - inia a conexão
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async{
    Directory _dbPath = (await getDatabasesPath()) as Directory;
    final path = join(_dbPath as String,"petshop.db"); //caminho do banco de dados

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    //criar a tabela dos pets
    await db.execute(
      """CREATE TABLE pets(id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      raca TEXT NOT NULL,
      nome_dono  TEXT NOT NULL,
      telefone_dono TEXT NOT NULL)"""
    );

    //criar a tabela das consultas 
    await db.execute(
      """CREATE TABLE consultas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pet_id INTEGER NOT NULL,
      data_hora TEXT NOT NULL,
      tipo_servico TEXT NOT NULL,
      observacao TEXT NOT NULL,
      FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE)"""
    );
  }

  //métodos crud para pets
  Future<int> insertPet(Pet pet) async{
    final db = await database;
    return await db.insert("pets", pet.toMap()); //retorna o id do pet
  }

  Future<List<Pet>> getPets() async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query("pets"); //recebe todos os pets cadastrados
    //converter em objetos 
    return maps.map((e)=>Pet.fromMap(e)).toList(); //adiciona elemento por elemento na lista convertido em objeto
  }

  Future<Pet?> getPetById(int id) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query( //faz busca no BD
      "pets", where: "id=?", whereArgs: [id]); //a partir do ID solicitado 
    //se encontrado
    if(maps.isNotEmpty){
      return Pet.fromMap(maps.first); //cria o objeto com 1º elemento da lista
    }else{
      null;
    }
  }

  Future<int> deletePet(int id) async{
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]); //deleta o pet da tabela que tenha o id igual ao passado pelo parâmetro
  }

  //métodos CRUDs para consultas
  Future<int> insertConculta (Consulta consulta) async{
    final db = await database; //insere a consulta no BD
    return await db.insert("consultas", consulta.toMap());
  }

  Future<List<Consulta>> getConsultaForPet(int petId) async{
    final db = await database;
    //consulta por pet específico
    final List<Map<String,dynamic>> maps = await db.query(
      "consulta",
      where: "pet_id = ?",
      whereArgs: [petId],
      orderBy: "data_hora ASC" //ordem pela data/hora
    );
    //converter a map para objeto
    return maps.map((e) => Consulta.fromMap(e)).toList();
  }

  Future<int> deleteConsulta(int id) async{
    final db = await database;
    //delete pelo DB
    return await db.delete("consulta", where: "id = ?", whereArgs: [id]);
  }
}