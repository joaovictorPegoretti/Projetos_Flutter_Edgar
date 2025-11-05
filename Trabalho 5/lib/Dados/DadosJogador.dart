// lib/Dados/DadosJogador.dart
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

  // NOVO: Método para Atualizar um jogador
  Future<int> update(Jogador jogador) async {
    Database db = await dbHelper.database;
    return await db.update(
      Banco.jogadorTable,
      jogador.toMap(),
      where: 'id = ?', // Usa o ID para saber qual registro atualizar
      whereArgs: [jogador.id],
    );
  }

  // NOVO: Método para Deletar um jogador
  Future<int> delete(int id) async {
    Database db = await dbHelper.database;
    return await db.delete(
      Banco.jogadorTable,
      where: 'id = ?', // Usa o ID para saber qual registro deletar
      whereArgs: [id],
    );
  }

  Future<List<Jogador>> listarTodos() async {
    Database db = await dbHelper.database;
    final maps = await db.query(Banco.jogadorTable);
    return List.generate(maps.length, (i) => Jogador.fromMap(maps[i]));
  }
}
