# Trabalho 4 – Camada de Dados e Persistência

Este projeto foi desenvolvido como parte da disciplina **Computação Móvel (8º Período - Multivix)**, sob orientação do professor **Edgard da Cunha Pontes**.  
O objetivo principal foi implementar a **camada de dados com persistência local** em Flutter, aplicando o **padrão Repository** para isolar o acesso ao banco de dados da interface do usuário.

---

## Objetivo e Justificativa

Migrar uma aplicação Flutter que antes utilizava listas em memória para uma solução com **persistência de dados local**, garantindo que as informações sejam salvas e recuperadas mesmo após o fechamento do aplicativo.  

O projeto foi implementado utilizando o banco **SQLite** através da biblioteca **`sqflite`**, pois esta oferece um controle robusto e nativo de banco de dados relacional no dispositivo, sendo ideal para a estrutura de dados proposta.

---

## Estrutura do Projeto

A aplicação foi dividida em camadas para facilitar a manutenção e a compreensão do código:

```
Trabalho 4/
├── lib/
│   ├── Banco/
│   │   └── Config.dart
│   ├── Dados/
│   │   ├── DadosGuilda.dart
|   |   └── DadosJogador.dart
│   ├── Modelos/
│   │   ├── Guilda.dart
│   │   └── Jogador.dart
│   ├── Telas/
│   |   ├── FormularioGuilda.dart
│   |   └── FormularioJogador.dart
|   ├── main.dart
├── pubspec.yaml
```

---

## Modelagem de Dados

O projeto trabalha com **dois conceitos principais**: `Jogador` e `Guilda`.

### [Classe Jogador](/Trabalho%204/lib/Modelos/Jogador.dart)
Representa as informações do jogador e contém:
- `id` (int)
- `nome` (string)
- `nivel` (int)
- `classe` (string)
- `plataforma` (string)
- `idade` (int)
- `guildaId` (int)

### [Classe Guilda](/Trabalho%204/lib/Modelos/Guilda.dart)
Representa as informações da guilda e contém:
- `id` (int)
- `nome` (string)
- `tag` (string)
- `servidor` (string)
- `lider` (string)

Ambas as classes incluem métodos de conversão entre Map e Objeto Dart, permitindo a integração com o banco SQLite.

---

## Persistência de Dados

A persistência foi implementada com a biblioteca **[sqflite](https://pub.dev/packages/sqflite)**, que oferece suporte a operações CRUD (Create, Read, Update e Delete) utilizando o banco **SQLite** local.

A classe `DatabaseHelper` é responsável por:
- Criar o banco de dados (`app_database.db`);
- Definir as tabelas;
- Gerenciar a conexão com o SQLite.

```dart
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
```

---

## Camada de Repositórios

A lógica de persistência foi isolada em **repositórios**, garantindo que a camada de interface (UI) não acesse o banco diretamente.

### [Dados da Guilda](/Trabalho%204/lib/Dados/DadosGuilda.dart)
Contém os métodos:
```dart
Future<int> salvar(Guilda guilda) async {
    Database db = await dbHelper.database;
    return await db.insert(Banco.guildaTable, guilda.toMap());
  }

  Future<List<Guilda>> listarTodos() async {
    Database db = await dbHelper.database;
    final maps = await db.query(Banco.guildaTable);
    return List.generate(maps.length, (i) => Guilda.fromMap(maps[i]));
  }
```

### [Dados do Jogador](/Trabalho%204/lib/Dados/DadosJogador.dart)
Contém os métodos:
```dart
Future<int> salvar(Jogador jogador) async {
    Database db = await dbHelper.database;
    return await db.insert(Banco.jogadorTable, jogador.toMap());
  }

  Future<List<Jogador>> listarTodos() async {
    Database db = await dbHelper.database;
    final maps = await db.query(Banco.jogadorTable);
    return List.generate(maps.length, (i) => Jogador.fromMap(maps[i]));
  }
```

Os métodos utilizam `await` para acesso assíncrono ao banco, evitando travamentos na interface do aplicativo.

---

## Teste de Persistência

A lógica de persistência foi validada através de uma função de inicialização no `main.dart`, que verifica se o banco está vazio e, em caso afirmativo, insere dados de teste.

- As inserções são salvas corretamente no banco local.
- A leitura retorna as listas de guildas e jogadores completas para a interface.
- O uso de `async/await` garante operações não bloqueantes.

**Resultado da Escrita (Saída do Console na primeira execução):**

O console exibe as seguintes mensagens, confirmando a inserção dos dados de teste:

---

## Execução do Projeto

### Pré-requisitos
- Flutter instalado e configurado.
- Dependências listadas no `pubspec.yaml` (instaladas via `flutter pub get`).

### Passos para executar
1. Clone o repositório:
   ```bash
   git clone https://github.com/joaovictorPegoretti/Projetos_Flutter_Edgar
   ```
2. Acesse a pasta do projeto:
   ```bash
   cd "Projetos_Flutter_Edgar/Trabalho 4"
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o aplicativo:
   ```bash
   flutter run
   ```
5.Escolha a opção que deseja executar:
```bash
Connected devices:
Windows (desktop) • windows • windows-x64    • Microsoft Windows [versÆo 10.0.26100.6584]
Chrome (web)      • chrome  • web-javascript • Google Chrome 141.0.7390.125
Edge (web)        • edge    • web-javascript • Microsoft Edge 142.0.3595.53
[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)
Please choose one (or "q" to quit):
```
6.Resultado do Console:
```bash
Launching lib\main.dart on Windows in debug mode...
Building Windows application...                                     9,8s
√ Built build\windows\x64\runner\Debug\projeto.exe
O banco de dados já contém dados. Exibindo na tela.
Syncing files to device Windows...                                  66ms

Flutter run key commands.
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on Windows is available at: http://127.0.0.1:59808/p3aIVN1uNwI=/
The Flutter DevTools debugger and profiler on Windows is available at:
http://127.0.0.1:9101?uri=http://127.0.0.1:59808/p3aIVN1uNwI=/
```
---

## Desenvolvedores

- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)

---
