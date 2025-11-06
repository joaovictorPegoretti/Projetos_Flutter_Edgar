// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Modelos/Jogador.dart';
import 'Modelos/Guilda.dart';
import 'Dados/DadosJogador.dart';
import 'Dados/DadosGuilda.dart';
import 'Telas/FormularioJogador.dart';
// import 'Telas/FormularioGuilda.dart'; // Não é mais usado diretamente aqui
import 'Telas/TelaListagemGuildas.dart'; // 1. IMPORTAR A NOVA TELA
import 'Providers/JogadorProvider.dart';
import 'Providers/GuildaProvider.dart';

Future<void> main() async {
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  await _inserirDadosIniciaisParaTeste();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JogadorProvider()),
        ChangeNotifierProvider(create: (_) => GuildaProvider()),
      ],
      child: const RpgPlayniumApp(),
    ),
  );
}

// ... (A função _inserirDadosIniciaisParaTeste() continua EXATAMENTE IGUAL)
Future<void> _inserirDadosIniciaisParaTeste() async {
  final guildaRepo = Dadosguilda();
  final jogadorRepo = Dadosjogador();

  List<Guilda> guildas = await guildaRepo.listarTodos();
  if (guildas.isEmpty) {
    print("Banco de dados vazio. Inserindo dados de teste...");

    final guildaTitans = Guilda(
      nome: "Titãs de Aço",
      tag: "TDA",
      servidor: "BR-Hydra",
      lider: "Marcos",
    );
    final guildaSombras = Guilda(
      nome: "Legião Sombria",
      tag: "LGS",
      servidor: "NA-Storm",
      lider: "Ana",
    );
    int guildaId1 = await guildaRepo.salvar(guildaTitans);
    int guildaId2 = await guildaRepo.salvar(guildaSombras);

    await jogadorRepo.salvar(
      Jogador(
        nome: "João",
        nivel: 11,
        classe: "Mago",
        plataforma: "PC",
        idade: 21,
        guildaId: guildaId1,
      ),
    );
    await jogadorRepo.salvar(
      Jogador(
        nome: "Rodinei",
        nivel: 41,
        classe: "Caçador",
        plataforma: "Play5",
        idade: 57,
        guildaId: guildaId1,
      ),
    );
    await jogadorRepo.salvar(
      Jogador(
        nome: "Samuel",
        nivel: 99,
        classe: "Ninja",
        plataforma: "Steam Deck",
        idade: 10,
        guildaId: guildaId2,
      ),
    );
    await jogadorRepo.salvar(
      Jogador(
        nome: "Eduardo",
        nivel: 34,
        classe: "Assassino",
        plataforma: "Xbox Series X",
        idade: 16,
        guildaId: guildaId2,
      ),
    );

    print(
      "Dados de teste inseridos. Rode o app para ver os resultados na tela e no console.",
    );
  } else {
    print("O banco de dados já contém dados. Exibindo na tela.");
  }
}

class RpgPlayniumApp extends StatelessWidget {
  const RpgPlayniumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RPG do Playnium',
      theme: ThemeData(primarySwatch: Colors.lightBlue, useMaterial3: true),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega ambos os providers quando a tela principal inicia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JogadorProvider>(context, listen: false).carregarJogadores();
      Provider.of<GuildaProvider>(context, listen: false).carregarGuildas();
    });
  }

  void _abrirFormulario([Jogador? jogador]) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioJogadorScreen(jogador: jogador),
      ),
    );
  }

  void _deletarJogador(Jogador jogador, BuildContext context) async {
    try {
      await Provider.of<JogadorProvider>(
        context,
        listen: false,
      ).deletarJogador(jogador.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${jogador.nome} foi deletado com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar ${jogador.nome}.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ... (As funções _showResultDialog e _maiorEMenorNivel continuam iguais)
  void _showResultDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _maiorEMenorNivel(List<Jogador> jogadores) {
    if (jogadores.isEmpty) return "Nenhum jogador encontrado.";
    Jogador maior = jogadores.first;
    Jogador menor = jogadores.first;
    for (final jogador in jogadores) {
      if (jogador.nivel > maior.nivel) maior = jogador;
      if (jogador.nivel < menor.nivel) menor = jogador;
    }
    return 'Jogador com maior nível:\n'
        'Nome: ${maior.nome} (Nível: ${maior.nivel})\n\n'
        'Jogador com menor nível:\n'
        'Nome: ${menor.nome} (Nível: ${menor.nivel})';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RPG - Dados Persistentes'),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shield),
            tooltip: 'Gerenciar Guildas', // 2. MUDAR O TOOLTIP
            onPressed: () {
              // 3. MUDAR A NAVEGAÇÃO
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaListagemGuildas(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<JogadorProvider>(
        builder: (context, provider, child) {
          // ... (O body (lista de jogadores) continua EXATAMENTE IGUAL)
          final jogadores = provider.jogadores;

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (jogadores.isNotEmpty) {
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Jogador com maior e menor nível'),
                  onTap: () => _showResultDialog(
                    'Maior e Menor Nível',
                    _maiorEMenorNivel(jogadores),
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Jogadores no Banco de Dados:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...jogadores
                    .map(
                      (jogador) => Dismissible(
                        key: Key(jogador.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          _deletarJogador(jogador, context);
                        },
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(jogador.nivel.toString()),
                            ),
                            title: Text(jogador.nome),
                            subtitle: Text(
                              "${jogador.classe} | Plataforma: ${jogador.plataforma}",
                            ),
                            onTap: () {
                              _abrirFormulario(jogador);
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            );
          }

          return const Center(
            child: Text("Nenhum jogador encontrado. Adicione um novo!"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormulario,
        tooltip: 'Adicionar novo jogador',
        child: const Icon(Icons.add),
      ),
    );
  }
}
