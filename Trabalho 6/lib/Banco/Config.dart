// lib/Banco/Config.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    // Usa o diretório correto dependendo se é Android/iOS ou Desktop
    String path;
    if (Platform.isAndroid || Platform.isIOS) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      path = join(documentsDirectory.path, _databaseName);
    } else {
      // Para Desktop (Windows/Linux) e TESTES, usamos o banco em memória ou local FFI
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      path = join(await getDatabasesPath(), _databaseName);
    }

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onConfigure: _onConfigure, // Importante para Foreign Keys
    );
  }

  // Habilita chaves estrangeiras no SQLite
  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
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

  // MÉTODO NOVO: Permitir injetar um banco de dados em memória para TESTES
  // Isso atende ao requisito de preparação de ambiente
  Future<void> initTestDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    _database = await openDatabase(
      inMemoryDatabasePath, // Banco temporário na memória RAM
      version: _databaseVersion,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  // Método para fechar o banco após testes
  Future<void> close() async {
    Future<void> initTestDatabase() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      _database = await openDatabase(
        inMemoryDatabasePath, // Banco temporário na memória RAM
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
      );
    }

    // Método para fechar o banco após testes
    Future<void> close() async {
      final db = _database;
      if (db != null) {
        await db.close();
        _database = null;
      }
    }

    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
