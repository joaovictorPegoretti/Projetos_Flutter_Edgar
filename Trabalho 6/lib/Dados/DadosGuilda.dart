// lib/Dados/DadosGuilda.dart
import 'package:sqflite/sqflite.dart';
// CAMINHOS CORRIGIDOS
import '../Banco/Config.dart';
import '../Modelos/Guilda.dart'; // Corrigindo import duplicado/errado

class Dadosguilda {
  final dbHelper = Banco.instance;

  Future<int> salvar(Guilda guilda) async {
    Database db = await dbHelper.database;
    return await db.insert(Banco.guildaTable, guilda.toMap());
  }

  // NOVO: Método para Atualizar uma guilda
  Future<int> update(Guilda guilda) async {
    Database db = await dbHelper.database;
    return await db.update(
      Banco.guildaTable,
      guilda.toMap(),
      where: 'id = ?',
      whereArgs: [guilda.id],
    );
  }

  // NOVO: Método para Deletar uma guilda
  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete(Banco.guildaTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Guilda>> listarTodos() async {
    Database db = await dbHelper.database;
    final maps = await db.query(Banco.guildaTable);
    return List.generate(maps.length, (i) => Guilda.fromMap(maps[i]));
  }
}
