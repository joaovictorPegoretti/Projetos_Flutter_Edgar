import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Banco {
  static const _databaseName = "rpgPlaynium.db";
  static const _databaseVersion = 1;

  static const guildaTable = 'guilda';
  static const jogadorTable = 'jogador';

  Banco._privateConstructor();
  static final Banco instance = Banco._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $guildaTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        tag TEXT NOT NULL,
        servidor TEXT NOT NULL,
        lider TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $jogadorTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        nivel INTEGER NOT NULL,
        classe TEXT NOT NULL,
        plataforma TEXT NOT NULL,
        idade INTEGER NOT NULL,
        guildaId INTEGER NOT NULL,
        FOREIGN KEY (guildaId) REFERENCES $guildaTable (id) ON DELETE CASCADE
      )
    ''');
  }
}
