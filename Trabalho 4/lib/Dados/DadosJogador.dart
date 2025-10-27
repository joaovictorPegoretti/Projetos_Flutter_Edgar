// lib/Dados/ConfigJogador.dart
import 'package:sqflite/sqflite.dart';
// CAMINHOS CORRIGIDOS
import '../Banco/Config.dart';
import '../Modelos/Jogador.dart';

class Dadosjogador {
  final dbHelper = Banco.instance;

  Future<int> salvar(Jogador jogador) async {
    Database db = await dbHelper.database;
    return await db.insert(Banco.jogadorTable, jogador.toMap());
  }

  Future<List<Jogador>> listarTodos() async {
    Database db = await dbHelper.database;
    final maps = await db.query(Banco.jogadorTable);
    return List.generate(maps.length, (i) => Jogador.fromMap(maps[i]));
  }
}
