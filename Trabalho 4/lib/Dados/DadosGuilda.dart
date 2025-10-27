// lib/Dados/ConfigGuilda.dart
import 'package:sqflite/sqflite.dart';
import 'package:projeto/Modelos/Guilda.dart';
// CAMINHOS CORRIGIDOS
import '../Banco/Config.dart';

class Dadosguilda {
  final dbHelper = Banco.instance;

  Future<int> salvar(Guilda guilda) async {
    Database db = await dbHelper.database;
    return await db.insert(Banco.guildaTable, guilda.toMap());
  }

  Future<List<Guilda>> listarTodos() async {
    Database db = await dbHelper.database;
    final maps = await db.query(Banco.guildaTable);
    return List.generate(maps.length, (i) => Guilda.fromMap(maps[i]));
  }
}
