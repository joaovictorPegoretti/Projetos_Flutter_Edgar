// lib/main.dart
import 'package:flutter/material.dart';
// 1. IMPORTE O NOVO PACOTE
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Seus outros imports...
import 'Modelos/Jogador.dart';
import 'Modelos/Guilda.dart';
import 'Dados/DadosJogador.dart';
import 'Dados/DadosGuilda.dart';
import 'Telas/FormularioJogador.dart';
import 'Telas/FormularioGuilda.dart';

Future<void> main() async {
  // 2. INICIALIZE O BANCO DE DADOS PARA DESKTOP (A CORREÇÃO)
  // Esta linha deve vir ANTES de 'WidgetsFlutterBinding.ensureInitialized()'
  databaseFactory = databaseFactoryFfi;

  // O restante do seu código continua igual
  WidgetsFlutterBinding.ensureInitialized();
  await _inserirDadosIniciaisParaTeste();
  runApp(const RpgPlayniumApp());
}

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
  late Future<List<Jogador>> _jogadoresFuture;
  final Dadosjogador _jogadorRepository = Dadosjogador();

  @override
  void initState() {
    super.initState();
    _carregarJogadores();
  }

  void _carregarJogadores() {
    setState(() {
      _jogadoresFuture = _jogadorRepository.listarTodos();
    });
  }

  // Função para navegar para a tela de formulário
  void _abrirFormulario() async {
    // Navega para a tela de formulário e espera um resultado
    final foiSalvo = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioJogadorScreen()),
    );

    // Se o resultado for 'true', significa que um novo jogador foi salvo.
    // Então, atualizamos a lista.
    if (foiSalvo == true) {
      _carregarJogadores();
    }
  }

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
            tooltip: 'Adicionar nova guilda',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormularioGuildaScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Jogador>>(
        future: _jogadoresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar jogadores: ${snapshot.error}"),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final jogadores = snapshot.data!;
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
                      (jogador) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(jogador.nivel.toString()),
                          ),
                          title: Text(jogador.nome),
                          subtitle: Text(
                            "${jogador.classe} | Plataforma: ${jogador.plataforma}",
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
      // O BOTÃO FLUTUANTE AGORA ABRE O FORMULÁRIO
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormulario, // Chama a nova função
        tooltip: 'Adicionar novo jogador',
        child: const Icon(Icons.add), // Ícone de "adicionar"
      ),
    );
  }
}
